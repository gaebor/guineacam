while true; do
### ip
  ip_str=`lynx -connect_timeout=10 --dump http://ipecho.net/plain 2> /dev/null | grep -P "(\d{1,3}\.){3}\d{1,3}"`
  if [[ $? -eq 0 && $ip_str ]]
  then
    if [[ ! -e "ip.txt" || "`cat ip.txt`" != "$ip_str" ]]
    then
      echo $ip_str > ip.txt
      echo "http://$ip_str/
rtsp://$ip_str:8554/" | mail -s "ip changed" guineacam@googlegroups.com
    fi
  fi
### still image
  STILL_ERROR=`sudo raspistill -w 768 -h 1024 -q 100 -rot 90 -e jpg -o "/var/www/html/guinea_pic.jpg" --metering average --nopreview 2>&1 > /dev/null`
  STILL_RESULT=$?
  echo $STILL_ERROR
### stream
  sudo raspivid -o - -t 1000000 -w 480 -h 640 --rotation 90 --metering average --profile high --nopreview -fps 25 --intra 25 | \
  cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:8554/}' :demux=h264 --play-and-exit
  VIDEO_RESULT=$?
### check error  
  if [ $STILL_RESULT != 0 ] || [ $VIDEO_RESULT != 0 ] || [ -n "$STILL_ERROR" ]
  then
    mail -s "camera error" guineacam@googlegroups.com <<<"\`raspistill\` returned $STILL_RESULT and reported:
$STILL_ERROR
\`raspivid\` returned $VIDEO_RESULT!"
    break
  fi
done