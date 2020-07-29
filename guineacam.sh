INTERVAL=1000

if [ -n "$1" ]
then
    INTERVAL="$1"
fi

function m {
    mailsend-go -smtp smtp.gmail.com -port 587 -sub "$1" -f "$USER"@`hostname` \
        -t `head -n 1 ~/mail.conf | tail -n 1` \
        auth -user `head -n 2 ~/mail.conf | tail -n 1` -pass `head -n 3 ~/mail.conf | tail -n 1` \
        body -msg "$2"
}

IP_FILE=/home/pi/ip.txt

while true
do
### ip
  ip_str=`lynx -connect_timeout=10 --dump http://ipecho.net/plain 2> /dev/null | grep -P "(\d{1,3}\.){3}\d{1,3}" | tr -d '[:space:]'`
  if [ $? -eq 0 -a -n "$ip_str" ]
  then
    if [ ! -e $IP_FILE -o "`cat $IP_FILE`" != "$ip_str" ]
    then
      echo $ip_str > $IP_FILE
      m "ip changed" "http://$ip_str/
rtsp://$ip_str:8554/"
    fi
  fi
### still image
  STILL_ERROR=`sudo raspistill -w 768 -h 1024 -q 100 -rot 90 -e jpg -o "/var/www/html/guinea_pic.jpg" --metering average --nopreview 2>&1 > /dev/null`
  STILL_RESULT=$?
  echo $STILL_ERROR
  sudo chmod 755 /var/www/html/guinea_pic.jpg
### stream
  sudo raspivid -o - -t $((1000*INTERVAL)) -w 480 -h 640 --rotation 90 --metering average --profile high --nopreview -fps 25 --intra 25 | \
  cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:8554/}' :demux=h264 --play-and-exit
  VIDEO_RESULT=$?
### check error
  if [ $STILL_RESULT -ne 0 -o $VIDEO_RESULT -ne 0 -o -n "$STILL_ERROR" ]
  then
    m "camera error" "\`raspistill\` returned $STILL_RESULT and reported:
$STILL_ERROR
\`raspivid\` returned $VIDEO_RESULT!"
    break
  fi
done
