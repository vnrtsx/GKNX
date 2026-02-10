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
echo "[*] Status      : UNLOCKED (Dev Mode)"
echo "[*] Device RAM  : 8191 MB (MONSTER)"
echo "-------------------------------------------"

# Memaksa input dari terminal (keyboard) agar tidak terlewati
exec < /dev/tty

echo -n "Masukkan Nama Package: "
read PKG_NAME

if [ -z "$PKG_NAME" ]; then
    echo "[!] Error: Nama package wajib diisi!"
    exit 1
fi

echo -n "Jumlah Client: "
read MAX_CLIENT

# ENGINE EKSEKUSI
START_APP() {
    ID=$1
    echo "[+] Membuka Client-$ID..."
    am force-stop $PKG_NAME > /dev/null 2>&1
    sleep 1
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
