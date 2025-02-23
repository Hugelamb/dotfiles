#!/usr/bin/env bash

report() {
  task report
}


add() {
  # open fuzzel prompt to take user input? or maybe a foot terminal of height 1
  echo "incomplete"
}

modify() {
  echo "incomplete"
}

fuzzel_explorer() {
  fuzzel_std=("fuzzel" "--dmenu" "-i" "-a" "top" "--y-margin=3" "--x-margin=3" "--prompt=>")
  fuzzel_edit=("fuzzel" "--dmenu" "-i" "-a" "top" "-l 5" "--prompt=>")
  fuzzel_prompt=("fuzzel" "--dmenu" "-i" "-a" "top" "--y-margin=3" "--x-margin=3" "--prompt-only=>")
  fuzzel_search=("fuzzel" "--dmenu" "-i" "-a" "top" "--prompt=>" "--hide-before-typing") 
  default_width=30
  width=30
  newtask=$("${fuzzel_prompt[@]}" "--placeholder=new task")
  task add $newtask
  echo "$(task next)"
  fuzzel
}


