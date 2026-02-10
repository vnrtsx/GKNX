#!/system/bin/sh
# ===========================================================
# PROJECT : GKNX (Global Klepon Nexus)
# MODULE  : GKNX_CORE (Open Edition)
# OWNER   : Gi
# ===========================================================

clear
echo "==========================================="
echo "       GKNX_CORE : OPEN LOADER             "
echo "==========================================="
echo "[*] Status      : UNLOCKED (Development Mode)"
echo "[*] Device RAM  : 8191 MB (MONSTER)"
echo "-------------------------------------------"

# 1. INPUT MANUAL
echo -n "Masukkan Nama Package (e.g. com.android.chrome): "
read PKG_NAME

# Validasi jika input kosong
if [ -z "$PKG_NAME" ]; then
    echo "[!] Error: Nama package wajib diisi!"
    exit 1
fi

echo -n "Jumlah Client yang ingin dibuka: "
read MAX_CLIENT

# 2. ENGINE EKSEKUSI
START_APP() {
    ID=$1
    echo "[+] Membuka Client-$ID..."
    
    # Auto-Killer agar RAM tetap optimal
    am force-stop $PKG_NAME > /dev/null 2>&1
    sleep 1
    
    # Menjalankan aplikasi
    monkey -p $PKG_NAME -c android.intent.category.LAUNCHER 1 > /dev/null 2>&1
    
    echo "[✔] Client-$ID Berhasil Aktif."
    sleep 2
}

echo "-------------------------------------------"
echo "[*] Memproses $MAX_CLIENT Client untuk $PKG_NAME"

for i in $(seq 1 $MAX_CLIENT); do
    START_APP $i
done

echo "-------------------------------------------"
echo "        PROSES GKNX SELESAI                "
echo "==========================================="
