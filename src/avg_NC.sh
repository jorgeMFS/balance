#!/bin/bash
# 
# AVG Compress in images =======================================================
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

counter=0
# ==============================================================================
#Paths
# ==============================================================================
METRICSPATH=$1
INITNAME=$2
SAVENAME=${INITNAME}_AVG_Compression
# ==============================================================================

numfls=`ls -Q ${METRICSPATH}${INITNAME}*Compression | wc -l`
indexes=""

#change nbr of files * 3
nrFiles=$numfls*3
for (( ind = 2; ind <= $nrFiles; ind=ind+3 ))
do
  indexes="$indexes\$$ind,"
done

indexes=${indexes::-1}


ls -tQ ${METRICSPATH}$INITNAME*Compression | xargs paste | awk '{ print '$indexes' }' > MALTA

cat MALTA | awk '{sum=0; for(i=1; i<=NF; i++) sum += $i; print sum}' > MALTA2
cat ${METRICSPATH}CA_DATA_73_Compression | awk '{print $1}' > AQW
awk -v c=$numfls '{ print $0/c }' MALTA2 > ASD
cat ${METRICSPATH}CA_DATA_73_Compression | awk '{print $3}' > AXC

paste -d "\t" AQW  ASD  AXC > ${METRICSPATH}${SAVENAME}
rm -rf MALTA MALTA2 AQW AXC ASD