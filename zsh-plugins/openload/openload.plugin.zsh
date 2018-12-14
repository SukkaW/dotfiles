oload() {
    echo "====================="
    echo "Openload Downloader"
    echo "Make sure you are now at download folder"
    echo "---------------------"
    echo "Please input openload url (end with /)"
    echo "---------------------"
    read openloadurl
    echo "---------------------"
    echo 'Please input axel max connections (Default as 24)'
    echo "---------------------"
    read connections
    echo "====================="

    if [ ! -n "$connections" ]; then
        connections="24"
    fi

    downloadlink=$(openload link ${openloadurl})

    result=$(echo ${downloadlink} | grep "Error")

    if [[ "$result" != *"Error"* ]]
    then
       axel -n ${connections} $(openload link ${openloadurl})
    else
       echo ${downloadlink}
    fi
}

oload-config () {
    echo "====================="
    echo "Openload CLI Configuration"
    echo "---------------------"
    echo "Please input openload login"
    echo "---------------------"
    read login
    echo "---------------------"
    echo 'Please input openload key'
    echo "---------------------"
    read key
    echo "====================="

    if [ ! -n "$login" ] || [ ! -n "$key" ] ; then
        echo "You should enter all the field!"
    else
        openload config --login $login --key $key
    fi
}
