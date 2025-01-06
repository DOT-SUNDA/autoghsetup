#!/bin/bash

# Daftar nama user
NEM="dotaja"
USER_LIST=("dotaja1" "dotaja2" "dotaja3" "dotaja4")
DEFAULT_PASSWORD="Dotaja123@HHHH"  # Password default

# Loop untuk membuat setiap user
for username in "${USER_LIST[@]}"; do
    # Periksa apakah user sudah ada
    if id "$username" &>/dev/null; then
        echo "User $username sudah ada, melewati..."
    else
        # Membuat user baru
        useradd -m -s /bin/bash "$username"
        echo "$username:$DEFAULT_PASSWORD" | chpasswd
        echo "User $username berhasil dibuat dengan password default: $DEFAULT_PASSWORD"
    fi
done

echo "Proses selesai."
