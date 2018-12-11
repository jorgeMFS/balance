#!/bin/bash
# 
# Process Results.====================================================

#Verify if there are inputs===========================================
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi
# ==============================================================================
#Configs
RUN_RM=1
counter=0
# ==============================================================================
#Paths
METRICSPATH=$1
SAVEMETRICSPATH=../metrics/processed_results/
IMG_PATH=$2
INITNAME=$3

flname=`ls $IMG_PATH | sort -n | head -1`
Alf=`../Compressors/goose-info < $IMG_PATH$flname | grep "Alphabet size"| awk -F ' ' '{print $3}'`
rm ${SAVEMETRICSPATH}$INITNAME*

for x in $METRICSPATH*.txt;do
        metricsFileName=$(basename -- "$x")
        tail -n +2 $x >> QWERTY
        CompressorName=${metricsFileName%.*}
        CompName=${CompressorName//_}
        while read p; do
            img=`echo "$p" | awk -F';' '{print $1}'`
            size=`echo "$p" | awk -F';' '{print $2}'`
            tm=`echo "$p" | awk -F';' '{print $3}'`
            compress=`echo "$p" | awk -F';' '{print $4}'`
            
            #Creating Reports
            REPORTCOMP="${INITNAME}_${img}_Compression"
            REPORTTIME="${INITNAME}_${img}_time"

            #Compression            
            echo "${compress}" "${size}"
            
            log2=`echo 'l('$Alf')/l(2)' | bc -l`

            bytes=`perl -w -e "use POSIX; print ceil($log2)"`
            
            base=$size*$bytes
            compRatio=$compress/$base
            RATIO=`echo "scale=3 ; $compRatio" | bc`
            echo -n "$RATIO "
            echo -e "$counter\t$RATIO\t\"$CompName\"" >> $SAVEMETRICSPATH$REPORTCOMP


            #TimeParsing to seconds
            minuts=`echo $tm | awk -F 'm' '{print $1}'`
            seconds=`echo $tm | awk -F 'm' '{print $2}'`
            seconds=${seconds//s}
            
            min_to_sec=$minuts*60
            tm_in_sec=$min_to_sec+$seconds

            TMP=`echo "scale=5 ;$tm_in_sec"|bc`
            echo "$tm --> $TMP"
            echo -e "$counter\t$TMP\t\"$CompName\"" >> $SAVEMETRICSPATH$REPORTTIME
            

            
                        
        done <QWERTY
        rm QWERTY
        counter=$((counter+1))
done