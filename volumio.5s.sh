#!/bin/bash
# <bitbar.title>Volumio</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Tikkerei</bitbar.author>
# <bitbar.author.github>tikkerei</bitbar.author.github>
# <bitbar.desc>Control Volumio music player via BitBar</bitbar.desc>
#TODO: <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
# <bitbar.dependencies>bash, curl, volumio</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/tikkerei/bitbar-volumio</bitbar.abouturl>

# Set manual the ip address of volumio, if not set the script will try to recongize it.
VOL_IP=""

########################################################################################
# NO EDIT AREA BELOW                                                                   #
########################################################################################

# Get the volumio ip if not set
if [ ! $VOL_IP ]; then
    VOL_IP=`host volumio | awk '/has address/ { print $4 ; exit }'`
fi

# function to extract the data from json result
jsonValue () {
  KEY=$1
  NUM=$2
  awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/\042'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${NUM}p
}

NOTERM="terminal=false refresh=true"
# Volumio icon coded in base64, format 32x32px / 144dpi
ICON_VOL=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
# get the volumio json data
VOL_JSON_SYSTEM=`curl -s    $VOL_IP/api/v1/getSystemVersion`
VOL_JSON_STATE=`curl -s     $VOL_IP/api/v1/getState`
VOL_JSON_RADIO_FAV=`curl -s $VOL_IP/api/v1/browse?uri=radio/favourites`
VOL_JSON_PLAYLISTS=`curl -s $VOL_IP/api/v1/browse?uri=playlists`
# extract json values
VOL_VERSION=`echo       $VOL_JSON_SYSTEM | jsonValue systemversion 1`
VOL_STATUS=`echo        $VOL_JSON_STATE | jsonValue status 1`
VOL_TITLE=`echo         $VOL_JSON_STATE | jsonValue title 1`
VOL_TYPE=`echo          $VOL_JSON_STATE | jsonValue trackType 1`
VOL_ARTIST=`echo        $VOL_JSON_STATE | jsonValue artist 1` 
VOL_VOLUME=`echo        $VOL_JSON_STATE | jsonValue volume 1`

# check if volumio is available 
if [ ! "$VOL_IP" ] || [ ! "$VOL_STATUS" ]; then
    echo "| templateImage=$ICON_VOL"
    echo "---"
    echo "Volumio not found! | color=red"
    echo "Please set volumio IP manually| color=gray"
    exit;
fi

# set the playback shortcut
SET_PLAYBACK="$VOL_IP/api/v1/commands/?cmd="
case $1 in 
    playpause)  curl "$SET_PLAYBACK"toggle  ; exit ;;
    next)       curl "$SET_PLAYBACK"next    ; exit ;;
    prev)       curl "$SET_PLAYBACK"prev    ; exit ;;
esac

# set the volume level
SET_VOLUME="$VOL_IP/api/v1/commands/?cmd=volume&volume="
case $1 in 
    vol0)     curl "$SET_VOLUME"0   ; exit ;;
    vol5)     curl "$SET_VOLUME"5   ; exit ;;
    vol10)    curl "$SET_VOLUME"10  ; exit ;;
    vol15)    curl "$SET_VOLUME"15  ; exit ;;
    vol20)    curl "$SET_VOLUME"20  ; exit ;;
    vol25)    curl "$SET_VOLUME"20  ; exit ;;
    vol30)    curl "$SET_VOLUME"30  ; exit ;;
    vol40)    curl "$SET_VOLUME"40  ; exit ;;
    vol50)    curl "$SET_VOLUME"50  ; exit ;;
    vol60)    curl "$SET_VOLUME"60  ; exit ;;
    vol70)    curl "$SET_VOLUME"70  ; exit ;;
    vol80)    curl "$SET_VOLUME"80  ; exit ;;
    vol90)    curl "$SET_VOLUME"90  ; exit ;;
    vol100)   curl "$SET_VOLUME"100 ; exit ;;
esac

echo " | templateImage=$ICON_VOL"
echo "---"
if [ "$VOL_STATUS" = "play" ]; then
    echo "⏸ Pause | bash=$0 param1=playpause  $NOTERM size=15"
else
    echo "▶️ Play | bash=$0 param1=playpause  $NOTERM size=15"
fi
echo "⏭ Next            | bash=$0 param1=next       $NOTERM size=15"
echo "⏮ Previous        | bash=$0 param1=prev       $NOTERM size=15"
echo "---"
[ "$VOL_VOLUME" ] && echo "🔈 Volume ($VOL_VOLUME%)"
echo "--🔇   0% | bash=$0 param1=vol0   $NOTERM"
echo "--🔈   5% | bash=$0 param1=vol5   $NOTERM"
echo "--🔈  10% | bash=$0 param1=vol10  $NOTERM"
echo "--🔈  15% | bash=$0 param1=vol15  $NOTERM"
echo "--🔈  20% | bash=$0 param1=vol20  $NOTERM"
echo "--🔈  25% | bash=$0 param1=vol25  $NOTERM"
echo "--🔈  30% | bash=$0 param1=vol30  $NOTERM"
echo "--🔉  40% | bash=$0 param1=vol40  $NOTERM"
echo "--🔉  50% | bash=$0 param1=vol50  $NOTERM"
echo "--🔉  60% | bash=$0 param1=vol60  $NOTERM"
echo "--🔉  70% | bash=$0 param1=vol70  $NOTERM"
echo "--🔊  80% | bash=$0 param1=vol80  $NOTERM"
echo "--🔊  90% | bash=$0 param1=vol90  $NOTERM"
echo "--🔊 100% | bash=$0 param1=vol100 $NOTERM"
echo "---"
[ "$VOL_TITLE" ] && echo "Title: $VOL_TITLE | color=green length=40"
[ "$VOL_ARTIST" ] && echo "Artist: $VOL_ARTIST | color=green length=40"
echo "---"
echo "Volumio: v$VOL_VERSION | href=http://$VOL_IP"

