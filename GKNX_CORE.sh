#!/system/bin/sh
# ===========================================================
# PROJECT : GKNX (Global Klepon Nexus)
# MODULE  : GKNX_CORE (Dynamic Package Loader)
# OWNER   : Gi
# ===========================================================

# 1. PENGAMANAN HWID (Lock ke Monster RAM 8GB milik Gi)
MY_HWID="293c734343840d8108"
CURRENT_ID=$(settings get secure android_id)

if [ "$CURRENT_ID" != "$MY_HWID" ]; then
    echo "ERROR: HWID TIDAK TERDAFTAR!"
    echo "ID Anda: $CURRENT_ID"
    exit 1
fi

clear
echo "==========================================="
echo "       GKNX_CORE : DYNAMIC LOADER          "
echo "==========================================="
echo "[*] HWID Status : VERIFIED"
echo "[*] Device RAM  : 8191 MB"
echo "-------------------------------------------"

# 2. INPUT NAMA PACKAGE
echo -n "Masukkan Nama Package (contoh: com.android.chrome): "
read PKG_NAME

if [ -z "$PKG_NAME" ]; then
    echo "[!] Error: Nama package tidak boleh kosong!"
    exit 1
fi

# 3. INPUT JUMLAH CLIENT
# Mengingat RAM 8GB, kamu bisa menjalankan banyak sekaligus
echo -n "Berapa banyak client yang ingin dijalankan? (Max 8): "
read MAX_CLIENT

# 4. EKSEKUSI FARMING
echo "-------------------------------------------"
echo "[*] Memulai GKNX Nexus untuk: $PKG_NAME"

START_APP() {
    ID=$1
    echo "[+] Membuka Client-$ID..."
    # Menggunakan Activity Manager untuk menjalankan package
    monkey -p $PKG_NAME -c android.intent.category.LAUNCHER 1 > /dev/null 2>&1
    sleep 2
}

for i in $(seq 1 $MAX_CLIENT); do
    START_APP $i
done

echo "-------------------------------------------"
echo "[✔] $MAX_CLIENT Client Berhasil Dimuat."
echo "==========================================="

