#!/bin/bash

print_message() {
    echo -e "\033[1;36m$1\033[0m"
}

print_error() {
    echo -e "\033[1;31m$1\033[0m"
}

# Cek status autentikasi GitHub CLI
STATUS=$(gh auth status 2>&1)

# Cek apakah autentikasi berhasil
GITHUB_STATUS=""
if echo "$STATUS" | grep -q "Logged in to github.com"; then
    GITHUB_STATUS="Aktif"
else
    GITHUB_STATUS="Tidak Aktif"
fi

SCREEN_STATUS=$(screen -list | grep -oP '\d+\.\S+')

if [ -z "$SCREEN_STATUS" ]; then
    SCREEN_STATUS="Tidak Aktif"
else
    SCREEN_STATUS="Sesi aktif:\n$SCREEN_STATUS"
fi
# urlnya
URLGH="https://raw.githubusercontent.com/DOT-SUNDA/autoghsetup/refs/heads/main"
# Menampilkan informasi dengan format yang diinginkan
while true; do
echo "============================="
echo "  MENU GITHUB CLI BY DOTAJA"
echo "============================="
echo "Github Status    : $GITHUB_STATUS"
echo "Screen           : $SCREEN_STATUS"
echo "Waktu            : $(date)"
echo "============================="
echo "1.RunDOT01         2.RunDOT02"
echo "3.CekDOT01         4.CekDOT02"
echo "5.Auth-GH          6.Logout-GH"
echo "7.AllStop          8.Exit"
echo "============================="
read -p "Pilih menu [1-8]: " option
case $option in
        1)
            screen -dmS DOT01 bash -c "$(wget -qO- $URLGH/Run01.sh)"
            ;;
        2)
            screen -dmS DOT02 bash -c "$(wget -qO- $URLGH/Run02.sh)"
            ;;
        3)
            screen -r DOT01
            ;;
        4)
            screen -r DOT02
            ;;
        5)
            clear
            read -p "Masukan Token Bro!!!: " TOKEN
            bash -c "$(wget -qO- $URLGH/AuthNoRoot.sh)" $TOKEN
            ;;
        6)
            gh auth logout
            ;;
        7)
            screen -S "DOT01" -X quit
            screen -S "DOT02" -X quit
            ;;
        8)
            echo "Keluar..."
            exit 0
            ;;
        *)
            echo "Pilihan tidak valid!"
            ;;
    esac
    echo ""
    read -p "Tekan [Enter] untuk melanjutkan..."
done
