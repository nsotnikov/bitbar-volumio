#!/bin/bash
# <bitbar.title>Volumio</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Tikkerei</bitbar.author>
# <bitbar.author.github>tikkerei</bitbar.author.github>
# <bitbar.desc>Control Volumio Music Player via BitBar</bitbar.desc>
#TODO <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
# <bitbar.dependencies>bash</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/tikkerei/bitbar-volumio</bitbar.abouturl>

# Volumio icon coded in base64, format 32x32px / 144dpi
echo "| templateImage=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"

echo "---"

echo "TEST"
echo "---"
echo "TEST2"
echo "TEST3"
echo "--TEST3"
echo "--TEST4"


# function jsonValue() {
# KEY=$1
# num=$2
# awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
# }

# read VOLUME  <<< $(curl 'volumio.local/api/v1/getstate'  | jsonValue volume)
# echo "Volume: ${VOLUME}"

# read STATUS  <<< $(curl 'volumio.local/api/v1/getstate'  | jsonValue status)
# echo "STATUS: ${STATUS}"

# read VOLUME  <<< $(curl 'volumio.local/api/v1/getstate' | awk '/volume[[:space:]]/ { print $0 }')
# echo "${VOLUME}"

# $ read IPETH0 IPLO <<< $(ifconfig | awk '/inet[[:space:]]/ { print $2 }')
# $ echo "${IPETH0}"
# 192.168.23.2
# $ echo "${IPLO}"


# 127.0.0.1
# echo one
# echo two
# echo three
# echo ---
# echo These lines are only visible
# echo when you open the menu.
# exit_with_error() {
#   echo "err | color=red";
#   exit 1;
# }



# volumio.local/api/v1/commands/?cmd=volume&volume=80
# 
# curl 'volumio.local:3000/api/v1/commands/?cmd=stop'
# {"time":1537609205936,"response":"stop Success"}%
# 
# curl 'volumio.local/api/v1/getstate'
# {"status":"stop","position":0,"title":"Hitradio ??3","albumart":"/albumart","uri":"http://yp.shoutcast.com/sbin/tunein-station.m3u?id=1586567","trackType":"webradio","seek":250,"samplerate":"","bitdepth":"","channels":0,"random":null,"repeat":null,"repeatSingle":false,"consume":false,"volume":36,"mute":false,"stream":"webradio","updatedb":false,"volatile":false,"service":"webradio"}%

