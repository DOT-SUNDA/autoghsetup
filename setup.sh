#!/bin/bash


URL="https://raw.githubusercontent.com/DOT-SUNDA/autoghsetup/refs/heads/main"
RUN1="Run01.sh"
RUN2="Run02.sh"

wget -O run01 $URL/$RUN1
wget -O run02 $URL/$RUN2

chmod +x run01
chmod +x run02

screen -dmS run01 ./run01
screen -dmS run02 ./run02