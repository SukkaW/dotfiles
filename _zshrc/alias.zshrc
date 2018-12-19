alias rezsh="source $HOME/.zshrc"

alias rmrf "rm -rf"
alias gitcm "git commit -m"
alias gitp "git push"
alias gita "git add -a"
alias gitall "git add ."
alias lg='lazygit'
alias myip='check_ip'

eval $(thefuck --alias)

ci-edit-update() {
    (
        cd "$HOME/ci_edit"
        git pull
    ) && \. sudo "$HOME/ci_edit/install.sh"
}

git-config() {
    echo -n "
=============================
Git Configuration
-----------------------------
Please input Git Username: "

    read username

echo -n "
-----------------------------
Please input Git Email: "

    read email

echo -n "
=============================
"

    git config --global user.name "${username}"
    git config --global user.email "${email}"

}