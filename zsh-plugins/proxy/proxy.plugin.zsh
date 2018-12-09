if [ ! -f "${HOME}/.proxy/status" ] || [ ! -f "${HOME}/.proxy/http" ] || [ ! -f "${HOME}/.proxy/socks5" ] ; then
    echo -e "You should run init_proxy first"
else
    _PROXY_STATUS=$(cat "${HOME}/.proxy/status")
    _PROXY_HTTP=$(cat "${HOME}/.proxy/http")
    _PROXY_SOCKS5=$(cat "${HOME}/.proxy/socks5")
fi


init_proxy() {
    mkdir $HOME/.proxy
    touch $HOME/.proxy/status
    touch $HOME/.proxy/http
    touch $HOME/.proxy/socks5
    echo -e "Great! The proxy plugin has initialized"
}

remove_proxy_plugin() {
    rm -rf $HOME/.proxy
}

check_ip() {
    curl https://ip.cn
    echo "---------------------"
    curl https://ip.gs
}

config_proxy() {
    echo "====================="
    echo "Configuring proxy"
    echo "---------------------"
    echo -n 'Please input socks5 proxy (Default as 127.0.0.1:1080)
[Format address:port] '
    read socks5
    echo "---------------------"
    echo -n 'Please input http proxy (Default as 127.0.0.1:1090)
[Format address:port] '
    read http
    echo "====================="

    if [ ! -n "$socks5" ]; then
        socks5="127.0.0.1:1080"
    fi
    if [ ! -n "$http" ]; then
        http="127.0.0.1:1090"
    fi

    echo "socks5://$socks5" > $HOME/.proxy/socks5
    echo "http://$http" > $HOME/.proxy/http

    source $HOME/.zshrc
}

enable_proxy() {
    export ALL_PROXY="${_PROXY_SOCKS5}"
    export all_proxy="${_PROXY_SOCKS5}"
}

disable_proxy() {
    unset ALL_PROXY
    unset all_proxy
}

enable_apt_proxy() {
    sudo sed -i -e '/Acquire::http::Proxy/d' /etc/apt/apt.conf
    sudo sed -i -e '/Acquire::https::Proxy/d' /etc/apt/apt.conf
    echo -e "Acquire::http::Proxy \"${_PROXY_HTTP}\";" | sudo tee -a /etc/apt/apt.conf > /dev/null
    echo -e "Acquire::https::Proxy \"${_PROXY_HTTP}\";" | sudo tee -a /etc/apt/apt.conf > /dev/null
    echo "1" > $HOME/.proxy/status
}

disable_apt_proxy() {
    sudo sed -i -e '/Acquire::http::Proxy/d' /etc/apt/apt.conf
    sudo sed -i -e '/Acquire::https::Proxy/d' /etc/apt/apt.conf
    echo "0" > $HOME/.proxy/status
}

auto_proxy() {
    if [ "${_PROXY_STATUS}" = "1" ]; then
        enable_proxy
    fi
    if [ "${_PROXY_STATUS}" = "0" ]; then
        disable_proxy
    fi
}

# Aliases for backward compatibility
proxy() {
    enable_proxy
    enable_apt_proxy
    check_ip
}

noproxy() {
    disable_proxy
    disable_apt_proxy
    check_ip
}

auto_proxy
