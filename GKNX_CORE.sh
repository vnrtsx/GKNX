#!/system/bin/sh
# GKNX_CORE - Monster Edition

clear
echo "==========================================="
echo "       GKNX_CORE : MONSTER LOADER          "
echo "==========================================="
echo "[*] Device RAM : 8191 MB"
echo "-------------------------------------------"

# Memaksa input dari keyboard
exec < /dev/tty

echo -n "[?] Masukkan Nama Package: "
read PKG_NAME

echo -n "[?] Jumlah Client (Angka): "
read MAX_CLIENT

# Validasi Angka agar seq tidak error
if ! [ "$MAX_CLIENT" -eq "$MAX_CLIENT" ] 2>/dev/null; then
  echo "[!] ERROR: Jumlah client harus berupa ANGKA!"
  exit 1
fi

echo "-------------------------------------------"
echo "[*] Memulai $MAX_CLIENT Client untuk $PKG_NAME..."

for i in $(seq 1 $MAX_CLIENT); do
    echo "[+] Opening Client-$i..."
    am force-stop $PKG_NAME > /dev/null 2>&1
    monkey -p $PKG_NAME -c android.intent.category.LAUNCHER 1 > /dev/null 2>&1
    sleep 2
done

echo "-------------------------------------------"
echo "        PROSES GKNX SELESAI                "
echo "==========================================="
