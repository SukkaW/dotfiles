#!/usr/bin/env python3
"""Emit reviewable `defaults write` commands from the current Mac.

The exporter deliberately handles only scalar values and arrays of strings.
Preference dictionaries often contain recent items, device identifiers, and
other machine-specific state that should not be copied into dotfiles.
"""

from __future__ import annotations

import argparse
import datetime as dt
import plistlib
import re
import shlex
import subprocess
import sys
import xml.parsers.expat
from pathlib import Path
from typing import Any, Iterable


DEFAULT_DOMAINS = (
    "NSGlobalDomain",
    "com.apple.dock",
    "com.apple.finder",
    "com.apple.screencapture",
    "com.apple.WindowManager",
    "com.apple.controlcenter",
    "com.apple.menuextra.clock",
    "com.apple.AppleMultitouchTrackpad",
    "com.apple.driver.AppleBluetoothMultitouch.trackpad",
    "com.apple.ActivityMonitor",
    "com.apple.TextEdit",
    "com.apple.Terminal",
)

PRIVATE_KEY_PARTS = (
    "account",
    "bookmark",
    "cookie",
    "credential",
    "deviceid",
    "email",
    "history",
    "recent",
    "secret",
    "token",
    "username",
    "uuid",
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Print current macOS preferences as defaults-write candidates."
    )
    parser.add_argument(
        "domains",
        nargs="*",
        help="preference domains to inspect (a conservative system list is the default)",
    )
    parser.add_argument(
        "--exclude-file",
        type=Path,
        metavar="PATH",
        help="omit domain/key pairs already written by this shell script",
    )
    parser.add_argument(
        "--include-private",
        action="store_true",
        help="include keys whose names suggest private or transient data",
    )
    parser.add_argument(
        "--show-skipped",
        action="store_true",
        help="print comments for values that cannot be represented safely",
    )
    return parser.parse_args()


def run(*command: str) -> subprocess.CompletedProcess[bytes]:
    return subprocess.run(command, check=False, capture_output=True)


def plist_paths(domain: str) -> Iterable[Path]:
    preferences = Path.home() / "Library" / "Preferences"
    if domain in {"NSGlobalDomain", "-g", ".GlobalPreferences"}:
        yield preferences / ".GlobalPreferences.plist"
        return

    yield preferences / f"{domain}.plist"
    yield (
        Path.home()
        / "Library"
        / "Containers"
        / domain
        / "Data"
        / "Library"
        / "Preferences"
        / f"{domain}.plist"
    )


def read_domain(domain: str) -> dict[str, Any]:
    exported = run("defaults", "export", domain, "-")
    if exported.returncode == 0:
        try:
            value = plistlib.loads(exported.stdout)
            if isinstance(value, dict):
                return value
        except (plistlib.InvalidFileException, ValueError, xml.parsers.expat.ExpatError):
            pass

    # `defaults export NSGlobalDomain -` can produce malformed XML when a
    # stored string contains a control character. Reading the binary plist is
    # a useful fallback and still leaves all writes to cfprefsd/`defaults`.
    for path in plist_paths(domain):
        try:
            value = plistlib.loads(path.read_bytes())
        except (
            FileNotFoundError,
            PermissionError,
            plistlib.InvalidFileException,
            ValueError,
            xml.parsers.expat.ExpatError,
        ):
            continue
        if isinstance(value, dict):
            return value

    detail = exported.stderr.decode(errors="replace").strip()
    raise RuntimeError(detail or "preference domain was not readable")


def existing_pairs(path: Path | None) -> set[tuple[str, str]]:
    if path is None:
        return set()

    text = path.read_text(encoding="utf-8")
    pattern = re.compile(
        r"^\s*(?:sudo\s+)?defaults(?:\s+-currentHost)?\s+write\s+"
        r"(?P<domain>\S+)\s+(?P<key>\"[^\"]+\"|'[^']+'|\S+)",
        re.MULTILINE,
    )
    pairs: set[tuple[str, str]] = set()
    for match in pattern.finditer(text):
        domain = match.group("domain")
        key = match.group("key")
        if key[:1] in {'"', "'"} and key[-1:] == key[:1]:
            key = key[1:-1]
        pairs.add((domain, key))
    return pairs


def shell_value(value: str) -> str:
    home = str(Path.home())
    if value == home:
        return '"${HOME}"'
    if value.startswith(home + "/"):
        return '"${HOME}"/' + shlex.quote(value[len(home) + 1 :])
    return shlex.quote(value)


def render_value(value: Any) -> str | None:
    if isinstance(value, bool):
        return f"-bool {str(value).lower()}"
    if isinstance(value, int):
        return f"-int {value}"
    if isinstance(value, float):
        return f"-float {value!r}"
    if isinstance(value, str):
        if len(value) > 512 or any(ord(char) < 32 and char not in "\t" for char in value):
            return None
        return f"-string {shell_value(value)}"
    if (
        isinstance(value, list)
        and len(value) <= 32
        and all(isinstance(item, str) and len(item) <= 256 for item in value)
    ):
        items = " ".join(shell_value(item) for item in value)
        return f"-array {items}".rstrip()
    return None


def is_private_key(key: str) -> bool:
    normalized = re.sub(r"[^a-z0-9]", "", key.lower())
    return any(part in normalized for part in PRIVATE_KEY_PARTS)


def macos_version() -> str:
    result = run("sw_vers", "-productVersion")
    return result.stdout.decode(errors="replace").strip() or "unknown"


def main() -> int:
    args = parse_args()
    domains = args.domains or DEFAULT_DOMAINS
    excluded = existing_pairs(args.exclude_file)

    print("#!/usr/bin/env bash")
    print()
    print(f"# Generated from explicit user preferences on macOS {macos_version()}.")
    print(f"# Generated at {dt.datetime.now().astimezone().isoformat(timespec='seconds')}.")
    print("# Review every line before committing; explicit does not mean user-changed.")
    print("# Quit affected applications before applying these commands.")

    emitted = 0
    skipped = 0
    for domain in domains:
        try:
            preferences = read_domain(domain)
        except RuntimeError as error:
            print(f"warning: {domain}: {error}", file=sys.stderr)
            continue

        commands: list[str] = []
        comments: list[str] = []
        for key in sorted(preferences, key=str.casefold):
            if (domain, key) in excluded:
                continue
            if not args.include_private and is_private_key(key):
                skipped += 1
                if args.show_skipped:
                    comments.append(f"# skipped possibly private key: {shlex.quote(key)}")
                continue

            rendered = render_value(preferences[key])
            if rendered is None:
                skipped += 1
                if args.show_skipped:
                    type_name = type(preferences[key]).__name__
                    comments.append(f"# skipped {type_name} value: {shlex.quote(key)}")
                continue

            commands.append(
                f"defaults write {shlex.quote(domain)} {shlex.quote(key)} {rendered}"
            )

        if commands or comments:
            print()
            print(f"# {domain}")
            for line in comments + commands:
                print(line)
            emitted += len(commands)

    print(
        f"export-defaults: emitted {emitted} commands; skipped {skipped} values",
        file=sys.stderr,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
