#!/usr/bin/env bash
for i in {1..5}
do 
    text=$(curl -s "https://wttr.in/$1?M&format=1")
    if [[ $? == 0 ]]
    then
      # regexPattern="($1:.*)"
      # regexPattern="(.*[\+\-][0-9]{1,2}°C)"
      #if [[ ! $text =~ $1 ]]; then
      if [[ ! $text  ]]; then
        echo "{\"text\":\"error\", \"tooltip\":\"$text\"}"
        exit 1 
      else
        text=$(echo "$text" | sed -E "s/\s+/ /g")
        tooltip=$(curl -s "https://wttr.in/$1?format=2")
        if [[ $? == 0 ]]
        then
            tooltip=$(echo "$tooltip" | sed -E "s/\s+/ /g")
            echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
            exit
        fi
      fi
    fi
    sleep 2
done
echo "{\"text\":\"Error\", \"tooltip\":\"$text\"}"
