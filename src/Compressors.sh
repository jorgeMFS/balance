#!/bin/bash
#
##############Compressors##############
#Configs
RUN_RM=1;
USECMIX=0

# ==============================================================================
#Verify if there are inputs
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi
# ==============================================================================

#Paths
IMG_PATH=$1;
METRICSPATH=$2;
CMIX_COMPRESSOR_PATH=../Compressors/cmix/;
PAQS_COMPRESSOR_PATH=../Compressors/paqs/;

# Parameters

# ==============================================================================
if [[ "$RUN_RM" -eq "1" ]]; then
        rm `echo "${METRICSPATH}*"`;
fi

# ==============================================================================
Parameters
BZIP="bzip2.txt";
GZIP="gzip.txt";
LZMA="lzma.txt";
XZ="xz.txt";
ZSTD="zstd.txt";
BDM="bdm.txt";

if [[ "$USECMIX" -eq "1" ]]; then     
        CMIX="cmix.txt";
        echo "ImgName;Size;Time;CompSize" > ${METRICSPATH}$CMIX;
fi

echo "ImgName;Size;Time;CompSize" > ${METRICSPATH}$ZSTD;
echo "ImgName;Size;Time;CompSize" > ${METRICSPATH}$XZ;
echo "ImgName;Size;Time;CompSize" > ${METRICSPATH}$BZIP;
echo "ImgName;Size;Time;CompSize" > ${METRICSPATH}$GZIP;
echo "ImgName;Size;Time;CompSize" > ${METRICSPATH}$LZMA;
echo "ImgName;Size;Time;bdmvalue" > ${METRICSPATH}$BDM;


for filename in ${IMG_PATH}*.PROCESSED.bin; do
        imgfilename=$(basename -- "$filename");        
        imagetruename=`echo $imgfilename | awk -F '.' '{print $1}'`;
        decompressed=`ls -la $filename | awk '{print $5;}'`;

        #ZSTD
        echo "======================ZSTD======================"
        (time zstd -19 --rm $filename) &> TTT;
        
        TIME=`cat TTT | grep "real" | awk '{print $2}'`;
        compressedfilename="${filename}.zst"
        compressed=`ls -la $compressedfilename | awk '{ print $5;}'`;

        zstd -d --rm $compressedfilename

        echo "ZSTD-->$imagetruename; $decompressed; $TIME; $compressed";
        echo "$imagetruename; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$ZSTD;

        #XZ
        echo "======================XZ======================"
        (time xz -9 $filename) &> TTT;

        TIME=`cat TTT | grep "real" | awk '{print $2}'`;
        compressedfilename="${filename}.xz"    

        compressed=`ls -la $compressedfilename | awk '{ print $5;}'`;
        xz -d $compressedfilename

        echo "XZ-->$imagetruename; $decompressed; $TIME; $compressed";
        echo "$imagetruename; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$XZ;
        
        #BZIP
        echo "======================BZIP======================"
        (time bzip2 -9 $filename) &> TTT;
        
        TIME=`cat TTT | grep "real" | awk '{print $2}'`;
        rm TTT;

        compressedfilename="${filename}.bz2";
        compressed=`ls -la $compressedfilename | awk '{print $5;}'`;
        bzip2 -d $compressedfilename;

        echo "BZIP-->$imagetruename;$decompressed;$TIME;$compressed";
        echo "$imagetruename; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$BZIP;
        
        #GZIP
        echo "======================GZIP======================"
        (time gzip -9 $filename) &> TTT;
        
        TIME=`cat TTT | grep "real" | awk '{print $2}'`;
        rm TTT;
        
        compressedfilename="${filename}.gz";   
        compressed=`ls -la $compressedfilename | awk '{print $5;}'`;
        gzip -d $compressedfilename;

        echo "GZIP-->${imgfilename%.*};$decompressed;$TIME;$compressed";
        echo "$imagetruename; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$GZIP;

        #LZMA
        echo "======================LZMA======================"
        (time lzma -9 $filename) &> TTT;
        TIME=`cat TTT | grep "real" | awk '{print $2}'`;
        rm  TTT;

        compressedfilename="${filename}.lzma";     
        compressed=`ls -la $compressedfilename | awk '{print $5;}'`;
        lzma -d $compressedfilename;
        
        echo "LZMA-->$imagetruename;$decompressed;$TIME;$compressed";
        echo "$imagetruename; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$LZMA;


        #CMIX
        if [[ "$USECMIX" -eq "1" ]]; then  

                echo "======================CMIX======================"
                compressedfilename="${IMG_PATH}${imgfilename%.*}.cmix"
                (time ${CMIX_COMPRESSOR_PATH}cmix -c $filename $compressedfilename) &> TTT;
                TIME=`cat TTT | grep "real" | awk '{print $2}'`;
                rm TTT;
                
                compressed=`ls -la $compressedfilename | awk '{print $5;}'`;
                echo "CMIX-->$imagetruename;$decompressed;$TIME;$compressed";
                echo "$imagetruename; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$CMIX;

                rm $compressedfilename;
        fi
        
        #BDM
        echo "======================BDM======================"
        (time ./BDM_SRC/BDM.exe < $filename > JJJ) &> TTT;

        TIME=`cat TTT | grep "real" | awk '{print $2}'`;
        bdm_value=`cat JJJ`;
        rm  JJJ;
        echo "BDM-->$imagetruename;$decompressed;$TIME;$bdm_value";
        echo "$imagetruename; $decompressed; $TIME; $bdm_value" >> ${METRICSPATH}$BDM;
        printf "Done!\n";

done

#PAQS
# ==============================================================================
# Parameters
# ==============================================================================
EXT=exe;
pattern=$IMG_PATH*.paq*
files=( $pattern )
# ==============================================================================

for executable in $PAQS_COMPRESSOR_PATH*.${EXT}; do
        filep=$(basename -- "$executable");


        printf '\n';
        echo "---------COMPRESSOR FILE NAME: ${filep%.*} -------------";
        echo "COMPLETE PATH OF COMPRESSOR -->$executable"

        echo "ImgName;Size;Time;CompSize" > $METRICSPATH${filep%.*}.txt
        
        echo $METRICSPATH${filep%.*}.txt
        for filename in $IMG_PATH*.PROCESSED.bin; do
                echo $filename
                imgfilename=$(basename -- "$filename");
                imagetruename=`echo $imgfilename | awk -F '.' '{print $1}'`
                echo "FILENAME IMAGE--> $filename ... IMAGE NAME: $imgfilename ";
                
                decompressed=`ls -la $filename | awk '{print $5;}'`;
                (time "" | $executable -8 $filename) &> TTT;
                TIME=`cat TTT | grep "real" | awk '{print $2}'`;
                rm TTT;

                #echo $IMG_PATH*.paq*
                if [ ! -f $IMG_PATH*.paq* ]; then
                         echo "File not found!";
                         rm $METRICSPATH${filep%.*}.txt;
                         ls $IMG_PATH*.paq*
                else                        
                         fileWithPattern="${files[0]}";
                         echo "FILE FOUND!!! -->" $fileWithPattern;
                         compressed=`ls -la $fileWithPattern | awk '{print $5;}'`;
                         rm $fileWithPattern;
                         echo "$imagetruename; $decompressed; $TIME; $compressed" >> $METRICSPATH${filep%.*}.txt;              
                fi 
        done
done

