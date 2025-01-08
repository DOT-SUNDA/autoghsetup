#!/bin/bash

# Fungsi untuk menampilkan pesan dengan warna biru
print_message() {
    echo -e "\033[1;36m$1\033[0m"
}

# Fungsi untuk menampilkan pesan error dengan warna merah
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

# Fungsi untuk cek status screen (hanya nama sesi)
check_screen_status() {
    SCREEN_STATUS=$(screen -list | grep -oP '\S+$') # Menampilkan hanya nama sesi screen

    if [ -z "$SCREEN_STATUS" ]; then
        SCREEN_STATUS="Tidak Aktif"
    else
        SCREEN_STATUS="Sesi aktif: $SCREEN_STATUS"
    fi
}

# URL untuk script
URLGH="https://raw.githubusercontent.com/DOT-SUNDA/autoghsetup/refs/heads/main"

# Menampilkan informasi dengan format yang lebih modern
while true; do
    # Refresh status screen
    check_screen_status

    # Tampilan header
    clear
    echo -e "\033[1;32m=============================\033[0m"
    echo -e "\033[1;32m  MENU GITHUB CLI BY DOTAJA \033[0m"
    echo -e "\033[1;32m=============================\033[0m"
    echo -e "\033[1;37mGithub Status    : \033[1;34m$GITHUB_STATUS\033[0m"
    echo -e "\033[1;37mScreen           : \033[1;34m$SCREEN_STATUS\033[0m"
    echo -e "\033[1;37mWaktu            : \033[1;34m$(date)\033[0m"
    echo -e "\033[1;32m=============================\033[0m"
    echo -e "\033[1;36m1. RunDOT01         2. RunDOT02\033[0m"
    echo -e "\033[1;36m3. CekDOT01         4. CekDOT02\033[0m"
    echo -e "\033[1;36m5. Auth-GH          6. Logout-GH\033[0m"
    echo -e "\033[1;36m7. AllStop          8. Exit\033[0m"
    echo -e "\033[1;32m=============================\033[0m"
    
    # Pilihan menu dengan efek input
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
            print_message "Masukan Token GitHub Anda:"
            read -p "Token: " TOKEN
            bash -c "$(wget -qO- $URLGH/AuthNoRoot.sh)" $TOKEN
            ;;
        6)
            gh auth logout
            print_message "Anda telah logout dari GitHub."
            ;;
        7)
            screen -S "DOT01" -X quit
            screen -S "DOT02" -X quit
            print_message "Semua sesi dihentikan."
            ;;
        8)
            echo -e "\033[1;31mKeluar...\033[0m"
            exit 0
            ;;
        *)
            print_error "Pilihan tidak valid! Silakan pilih angka antara 1-8."
            ;;
    esac
    echo ""
    read -p "Tekan [Enter] untuk melanjutkan..."
done
