#!/usr/bin/env bash

bgimage='../../documents/smitsborg_bw.jpg'
image="${0%%.*}.png"
message=Smitsborg
color='rgb(204,0,0)'

height=$(identify -format %h $bgimage)
convert -fill $color -pointsize $(( height/10 )) -gravity center -font "Futura-Medium-BT"\
  -draw "text 0,$(( height/4 )) '${message}'" \
  "$bgimage" "$image" >/dev/null
