#!/system/bin/sh
# GKNX_CORE - Monster Force Start

clear
echo "==========================================="
echo "       GKNX_CORE : FORCE LOADER            "
echo "==========================================="
echo "[*] RAM Status : 8191 MB (MONSTER)"
echo "-------------------------------------------"

exec < /dev/tty

echo -n "[?] Masukkan Nama Package: "
read PKG_NAME

echo -n "[?] Jumlah Client: "
read MAX_CLIENT

echo "-------------------------------------------"

for i in $(seq 1 $MAX_CLIENT); do
    echo "[+] Menghidupkan Client-$i..."
    
    # 1. Matikan aplikasi secara total dulu
    am force-stop $PKG_NAME > /dev/null 2>&1
    sleep 1
    
    # 2. Paksa buka Activity utama (Cara paling ampuh)
    # Kita gunakan perintah 'am start' bukan 'monkey'
    am start -n $(pm dump $PKG_NAME | grep -A 1 "MAIN" | grep "android.intent.action.MAIN" | cut -d "{" -f 2 | cut -d " " -f 2 | cut -d "}" -f 1 | head -n 1) > /dev/null 2>&1
    
    # 3. Jika cara di atas gagal, gunakan cara alternatif ini
    if [ $? -ne 0 ]; then
        monkey -p $PKG_NAME -c android.intent.category.LAUNCHER 1 > /dev/null 2>&1
    fi
    
    echo "[✔] Client-$i Seharusnya Sudah Muncul di Layar"
    sleep 3
done

echo "-------------------------------------------"
echo "         PROSES GKNX SELESAI               "
echo "==========================================="
