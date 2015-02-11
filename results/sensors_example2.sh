#!/bin/bash

# enable the sensors
echo 1 > /sys/bus/i2c/drivers/INA231/4-0045/enable
echo 1 > /sys/bus/i2c/drivers/INA231/4-0040/enable
echo 1 > /sys/bus/i2c/drivers/INA231/4-0041/enable
echo 1 > /sys/bus/i2c/drivers/INA231/4-0044/enable

echo "CPU0_FREQ, CPU1_FREQ, CPU2_FREQ, CPU3_FREQ, CPU4_FREQ, CPU5_FREQ, CPU6_FREQ, CPU7_FREQ, A15_W, A7_W, MEM_W, GPU_W" 

# settle two seconds to the sensors get fully enabled and have the first reading
sleep 2

# Main infinite loop
while true; do

# ----------- CPU DATA ----------- #

# Node Configuration for CPU Frequency
if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ];
then  
	CPU0_FREQ=$((`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`/1000))
else
	CPU0_FREQ=0
fi

if [ -f /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq ];                
then                                                                            
        CPU1_FREQ=$((`cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq`/1000))
else                                                                                 
        CPU1_FREQ=0                                                                  
fi                                                                                   

if [ -f /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq ];                
then                                                                            
        CPU2_FREQ=$((`cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq`/1000))
else                                                                                 
        CPU2_FREQ=0                                                                  
fi                                                                                   

if [ -f /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq ];                
then                                                                            
        CPU3_FREQ=$((`cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq`/1000))
else                                                                                 
        CPU3_FREQ=0                                                                  
fi                                                                                   

if [ -f /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq ];                
then                                                                            
        CPU4_FREQ=$((`cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq`/1000))
else                                                                                 
        CPU4_FREQ=0                                                                  
fi                                                                                   

if [ -f /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq ];                
then                                                                            
        CPU5_FREQ=$((`cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq`/1000))
else                                                                                 
        CPU5_FREQ=0                                                                  
fi                                                                                   

if [ -f /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq ];                
then                                                                            
        CPU6_FREQ=$((`cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq`/1000))
else                                                                                 
        CPU6_FREQ=0                                                                  
fi                                                                                   

if [ -f /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq ];                
then                                                                            
        CPU7_FREQ=$((`cat /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq`/1000))
else                                                                                 
        CPU7_FREQ=0                                                                  
fi                                                                                   

#CPU1_FREQ=$((`cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq`/1000))" Mhz"
#CPU2_FREQ=$((`cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq`/1000))" Mhz"
#CPU3_FREQ=$((`cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq`/1000))" Mhz"
#CPU4_FREQ=$((`cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq`/1000))" Mhz"
#CPU5_FREQ=$((`cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq`/1000))" Mhz"
#CPU6_FREQ=$((`cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq`/1000))" Mhz"
#CPU7_FREQ=$((`cat /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq`/1000))" Mhz"

# CPU Governor
CPU_GOVERNOR=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`

# Note Configuration for CPU Core Temperature
# This file is written on the following format:
# CPU0 CPU1 CPU2 CPU3
TMU_FILE=`cat /sys/devices/10060000.tmu/temp`

# We need to slip those in nice variables...
CPU0_TEMP=`echo $TMU_FILE | awk '{printf $1}'`"C"
CPU1_TEMP=`echo $TMU_FILE | awk '{printf $2}'`"C"
CPU2_TEMP=`echo $TMU_FILE | awk '{printf $3}'`"C"
CPU3_TEMP=`echo $TMU_FILE | awk '{printf $4}'`"C"

# Now lets get CPU Power Comsumption
# Letter Values are:
# V = Volts
# A = Amps
# W = Watts

# A7 Nodes
A7_V=`cat /sys/bus/i2c/drivers/INA231/4-0045/sensor_V`"V"
A7_A=`cat /sys/bus/i2c/drivers/INA231/4-0045/sensor_A`"A"
A7_W=`cat /sys/bus/i2c/drivers/INA231/4-0045/sensor_W`

# A15 Nodes
A15_V=`cat /sys/bus/i2c/drivers/INA231/4-0040/sensor_V`"V"
A15_A=`cat /sys/bus/i2c/drivers/INA231/4-0040/sensor_A`"A"
A15_W=`cat /sys/bus/i2c/drivers/INA231/4-0040/sensor_W`


# --------- MEMORY DATA ----------- # 
MEM_V=`cat /sys/bus/i2c/drivers/INA231/4-0041/sensor_V`"V"
MEM_A=`cat /sys/bus/i2c/drivers/INA231/4-0041/sensor_A`"A"
MEM_W=`cat /sys/bus/i2c/drivers/INA231/4-0041/sensor_W`

# ---------- GPU DATA ------------- # 
GPU_V=`cat /sys/bus/i2c/drivers/INA231/4-0044/sensor_V`"V"
GPU_A=`cat /sys/bus/i2c/drivers/INA231/4-0044/sensor_A`"A"
GPU_W=`cat /sys/bus/i2c/drivers/INA231/4-0044/sensor_W`
#GPU_FREQ=`cat /sys/module/pvrsrvkm/parameters/sgx_gpu_clk`" Mhz"

# ---------- FAN Speed ------------- # 
FAN_SPEED=$((`cat /sys/devices/odroid_fan.15/pwm_duty` * 100 / 255))"%"

# ---------- DRAW Screen ----------- #

echo "$CPU0_FREQ, $CPU1_FREQ, $CPU2_FREQ, $CPU3_FREQ, $CPU4_FREQ, $CPU5_FREQ, $CPU6_FREQ, $CPU7_FREQ, $A15_W, $A7_W, $MEM_W, $GPU_W" 
#echo "$CPU1_FREQ, "
#echo "$CPU2_FREQ, "
#echo "$CPU3_FREQ, "
#echo "$CPU4_FREQ, "
#echo "$CPU5_FREQ, "
#echo "$CPU6_FREQ, "
#echo "$CPU7_FREQ, "
#echo "Governor: $CPU_GOVERNOR"
#echo "Fan Speed: $FAN_SPEED"
#echo "$A15_W, "
#echo "A7 Power: $A7_V, $A7_A, $A7_W"
#echo "MEM Power: $MEM_V, $MEM_A, $MEM_W"
#echo "GPU Power: $GPU_V, $GPU_A, $GPU_W @ $GPU_FREQ"

sleep 1
#clear
done
