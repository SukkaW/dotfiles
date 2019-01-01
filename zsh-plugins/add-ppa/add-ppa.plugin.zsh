add-ppa() {
    echo "========================================="
    echo "Sukka Add PPA Helper"
    echo ""
    echo "This tool help to add ubuntu ppa to debian"
    echo "-----------------------------------------"
    echo "(1/4) PPA Name"
    echo -n "[ppa:some/ppa]: "
    read ppaname
    echo "-----------------------------------------"
    echo "(2/4) The ubuntu code of package"
    echo "Here are some codes you might want to use"
    echo "disco | cosmic | bionic | artful | xenial | trusty | precise"
    echo -n "[input ubuntu code]: "
    read ubuntu
    echo "-----------------------------------------"
    echo "(3/4) Import the key"
    echo "You can find 'Signing key' at the homepage of ppa"
    echo "And input the key following the '/'"
    echo -n "[input ppa key]: "
    read key
    echo "========================================="
    echo "(4/4) Now let helper do the rest"
    echo "-----------------------------------------"
    if ! [ -x "$(command -v add-apt-repository)" ]; then
        echo "software-properties-common is not installed yet"
        echo "Installing now..."
        echo "-----------------------------------------"
        sudo apt-get update
        sudo apt-get install -y software-properties-common
        echo "-----------------------------------------"
    fi
    echo "Adding ${ppaname}..."
    echo "-----------------------------------------"
    sudo add-apt-repository ${ppaname}
    echo "-----------------------------------------"
    echo "Modifying sources.list.d"
    # WIP
    echo "-----------------------------------------"
    echo "Adding key..."
    echo "-----------------------------------------"
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ${key}
    echo "-----------------------------------------"
    echo "${ppaname} was now added to your sources.list.d"
    echo "========================================="
}

