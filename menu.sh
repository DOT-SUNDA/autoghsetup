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
check_github_status() {
    if echo "$STATUS" | grep -q "Logged in to github.com"; then
        GITHUB_STATUS="\033[1;32mAktif\033[0m"
    else
        GITHUB_STATUS="\033[1;31mTidak Aktif\033[0m"
    fi
}

# Fungsi untuk cek status screen
check_screen_status() {
    SCREEN_STATUS=$(screen -list | grep -oP '\d+\.\S+')

    if [ -z "$SCREEN_STATUS" ]; then
        SCREEN_STATUS="Tidak Aktif"
    else
        SCREEN_STATUS="Sesi aktif:\n$SCREEN_STATUS"
    fi
}

# URL untuk script
URLGH="https://raw.githubusercontent.com/DOT-SUNDA/autoghsetup/refs/heads/main"

# Menampilkan informasi dengan format yang lebih modern
while true; do
    # Refresh status screen
    check_screen_status
    check_github_status
    # Tampilan header
    clear
    echo -e "\033[1;32m=============================\033[0m"
    echo -e "\033[1;32m  MENU GITHUB CLI BY DOTAJA  \033[0m"
    echo -e "\033[1;32m=============================\033[0m"
    echo -e "\033[1;37mGithub Status    : \033[1;34m$GITHUB_STATUS\033[0m"
    echo -e "\033[1;37mScreen           : \033[1;34m$SCREEN_STATUS\033[0m"
    echo -e "\033[1;37mWaktu            : \033[1;34m$(date)\033[0m"
    echo -e "\033[1;32m=============================\033[0m"
    echo -e "\033[1;36m1. Run-Codespace    \033[0m"
    echo -e "\033[1;36m2. Cek-Codespace    \033[0m"
    echo -e "\033[1;36m3. Stop-Codespace   \033[0m"
    echo -e "\033[1;36m4. Auth-Github      \033[0m"
    echo -e "\033[1;36m5. Logout-Github    \033[0m"
    echo -e "\033[1;36m6. Exit             \033[0m"
    echo -e "\033[1;32m=============================\033[0m"
    
    # Pilihan menu dengan efek input
    read -p "Pilih Menu : " option
    case $option in
        1)
            clear
            screen -dmS CODE bash -c "$(wget -qO- $URLGH/Run01.sh)"
            ;;
        2)
            clear
            screen -r CODE
            ;;
        3)
            clear
            screen -S CODE -X quit
            print_message "Semua sesi codespace di hentikan."
            ;;
        4)
            clear
            print_message "Masukan Token GitHub Anda:"
            read -p "Token: " TOKEN
            bash -c "$(wget -qO- $URLGH/AuthNoRoot.sh)" $TOKEN
            ;;
        5)
            clear
            gh auth logout
            print_message "Anda telah logout dari GitHub."
            ;;
        6)
            clear
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
