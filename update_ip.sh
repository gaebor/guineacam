function m {
    mailsend-go -smtp smtp.gmail.com -port 587 -sub "$1" -f "$USER"@`hostname` \
        -t `head -n 1 ~/mail.conf | tail -n 1` \
        auth -user `head -n 2 ~/mail.conf | tail -n 1` -pass `head -n 3 ~/mail.conf | tail -n 1` \
        body -msg "$2"
}

ip_str=`curl --max-time 10 ifconfig.me`

if [ $? -eq 0 -a -n "$ip_str" ]
then
    if [ ! -e "~/.IP" -o "`cat ~/.IP`" != "$ip_str" ]
    then
      echo $ip_str > ~/.IP
      m "ip changed" "http://$ip_str/"
    fi
fi
