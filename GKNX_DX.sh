#!/system/bin/sh
# ===========================================================
# PROJECT : GKNX (Global Klepon Nexus)
# MODULE  : GKNX_DX (Device Diagnosis)
# OWNER   : Gi
# ===========================================================

clear
echo "==========================================="
echo "       GKNX_DX : DEVICE DIAGNOSIS          "
echo "==========================================="
echo "[*] Waktu Scan : $(date)"
echo "[*] Nama Proyek: GKNX Nexus"

# --- 1. IDENTIFIKASI PERANGKAT ---
echo "\n[1. INFO HARDWARE]"
TOTAL_RAM=$(free -m | awk '/Mem:/ {print $2}')
FREE_RAM=$(free -m | awk '/Mem:/ {print $4}')
CPU_CORES=$(grep -c ^processor /proc/cpuinfo)
ANDROID_ID=$(settings get secure android_id)

echo " > Device ID : $ANDROID_ID (HWID)"
echo " > CPU Cores : $CPU_CORES Core"
echo " > Total RAM : ${TOTAL_RAM} MB"
echo " > Free RAM  : ${FREE_RAM} MB"

# --- 2. UJI PERFORMA CPU (STRESS DX) ---
echo "\n[2. STRESS TEST CPU]"
echo " > Menghitung kalkulasi berat (3 detik)..."
START_DX=$(date +%s)
# Simulasi beban kerja intensif
(count=1; while [ $count -le 5000 ]; do count=$((count+1)); done)
END_DX=$(date +%s)
SPEED_DX=$((END_DX - START_DX))
echo " > Kecepatan Proses: $SPEED_DX detik (Semakin rendah semakin baik)"

# --- 3. ESTIMASI KAPASITAS GKNX ---
echo "\n[3. GKNX CAPACITY ESTIMATE]"
# Asumsi 1 client butuh 800MB
# Reservasi system 1.5GB agar stabil
CLIENT_WEIGHT=800
RESERVE=1500
MAX_SLOTS=$(( (TOTAL_RAM - RESERVE) / CLIENT_WEIGHT ))

if [ $MAX_SLOTS -gt 5 ]; then
    VONIS="SANGAT LAYAK (MONSTER)"
elif [ $MAX_SLOTS -ge 4 ]; then
    VONIS="LAYAK (OPTIMAL)"
else
    VONIS="TERBATAS"
fi

echo " > Beban/Client: ${CLIENT_WEIGHT} MB"
echo " > Max Client : ${MAX_SLOTS} Account"
echo " > Status     : $VONIS"

echo "==========================================="
echo "      DIAGNOSIS GKNX SELESAI               "
echo "==========================================="
