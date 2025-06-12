ENTRY="127.0.0.2 sokaraku.42.fr"
HOSTS_FILE="/etc/hosts"

if grep -q "$ENTRY" $HOSTS_FILE; then
    echo "The entry '$ENTRY' already exists in $HOSTS_FILE"
else
    echo "$ENTRY" | sudo tee -a $HOSTS_FILE
    echo "Added '$ENTRY' to $HOSTS_FILE"
fi