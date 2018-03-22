lan-route () {
    GATEWAY="$(netstat -nr | awk '/default/ { print $2 }' | grep '^10')"
    if [[ -z $GATEWAY ]]; then
        echo "Not connected to network"
        return;
    fi
    echo "Adding route to $GATEWAY" && sudo /sbin/route add 10.0.0.0/8 $GATEWAY
}
