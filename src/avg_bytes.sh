#!/bin/bash

# AVG Compress bytes in images =================================================
# ==============================================================================
#Verify if there are inputs
# ==============================================================================

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi
# ==============================================================================
#Configs
# ==============================================================================
rm -rf AVG_BYTES_SPENT

#Parameters
counter=0
# ==============================================================================
#Paths
METRICSPATH=$1
#echo "METRICSPATH --> $METRICSPATH"
Filename=$2
#echo "Filename --> $Filename"
SAVEPATH=$3
#echo "SAVEPATH --> $SAVEPATH"
rm -rf $SAVEPATH$Filename

for x in $METRICSPATH*.txt;do
    echo $x
    metricsFileName=$(basename -- "$x")
    CompressorName=${metricsFileName%.*}
    CompName=${CompressorName//_}

    tail -n +2 $x >> QWERTY
    rowNb=`wc -l QWERTY | awk '{print $1}'`
    sumOfCompEl=`cat QWERTY | awk -F';' '{print $4}'| paste -sd+ | bc`
    avg_bytes_per_img=$sumOfCompEl/$rowNb
    AVG=`echo "scale=3 ; $avg_bytes_per_img" | bc`
   
    echo -e "$counter\t$sumOfCompEl\t$AVG\t\"$CompName\"" 
    echo -e "$counter\t$sumOfCompEl\t$AVG\t\"$CompName\"" >> ${SAVEPATH}${Filename}
    counter=$((counter+1))
    rm QWERTY
done
