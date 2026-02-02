sleeptime=120
while true
do
    cputemp=$(cat /sys/class/thermal/thermal_zone0/temp)
    if [[ $cputemp -lt 55000 ]]; then
        fanspeed="0x00"
    elif [ $cputemp -ge 55000 -a $cputemp -lt 60000 ]; then
        fanspeed="0x10"
    elif [ $cputemp -ge 60000 -a $cputemp -lt 65000 ]; then
        fanspeed="0x32"
    elif [ $cputemp -ge 65000 ]; then
        fanspeed="0x64"
    fi
    i2cget -y 1 0x01a $fanspeed
    sleep $sleeptime
done