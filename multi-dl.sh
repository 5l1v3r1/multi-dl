#!/bin/bash
# Author: github.com/thelinuxchoice
# Instagram: @thelinuxchoice
trap 'printf "\n\e[1;77mPending downloads will finish\e[0m\n"; exit 1 ' 2

banner() {

printf "\e[1;91m  _  _  _                     _  _    _             _  _ \e[0m\n"
printf "\e[1;91m | || || |  _ __ ___   _   _ | || |_ (_)         __| || |\e[0m\n"
printf "\e[1;91m | || || | | '_ \` _ \ | | | || || __|| | _____  / _\` || |\e[0m\n"
printf "\e[1;77m | || || | | | | | | || |_| || || |_ | ||_____|| (_| || |\e[0m\n"
printf "\e[1;77m |_||_||_| |_| |_| |_| \__,_||_| \__||_|        \__,_||_|\e[0m\n"
printf "\n"
printf "\e[1;41m   Multi-download tool, v1.0. Coded by: @thelinuxhoice   \e[0m\n\n"


}

function start() {

read -p $'\n\e[1;92mLinks file path: \e[0m' wg_list
default_threads="5"
read -p $'\e[1;92mSimultaneous download: \e[0m' threads
threads="${threads:-${default_threads}}"
printf "\n"
}



function download() {

startline=1 ###
endline="$threads" ###
counter=0
count_link=$(wc -l $wg_list | cut -d " " -f1)


while [[ "$counter" -lt "$count_link" ]]; do ###
IFS=$'\n'
for link in $(sed -n ''$startline','$endline'p' $wg_list); do ###

countlink=$(grep -n "$link" "$wg_list" | cut -d ":" -f1)
token=$(($counter+1))
printf "\e[1;77mDownload link (%s/%s)\e[0m: \"%s\"\n" $countlink $count_link $link

{( trap '' SIGINT && curl --progress-bar -m 5 -O $link 2> /dev/null && printf "\e[1;92mDownload\e[0m\e[1;77m %s\e[0m \e[1;92mcomplete\e[0m\n" $countlink || printf "\e[1;92mDownload\e[0m\e[1;77m %s\e[0m\e[1;91m failed\n\e[0m" $countlink ) } & done; wait $!;
let token++
let counter++

let startline+=$threads
let endline+=$threads
#done
done
exit 1
}
banner
start
download
