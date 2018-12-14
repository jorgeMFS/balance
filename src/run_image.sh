#!/bin/bash

#===========================================
#Verify if there are inputs
#===========================================
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

#===========================================
#Configs
#===========================================
RUN_RM=1
USECMIX=0
ImagePath=$1
METRICSPATH=../metrics/Other/;
SAVERESULTS=INPUT_IMG_RESULTS
#===========================================

CMIX_COMPRESSOR_PATH=../Compressors/cmix/;
PAQS_COMPRESSOR_PATH=../Compressors/paqs/;
if [[ "$RUN_RM" -eq "1" ]]; then
        rm `echo "${METRICSPATH}*"`;
fi

echo "ImgName;Size;Time;CompSize" > $METRICSPATH$SAVERESULTS
#===========================================

imgfilename=$(basename -- "$ImagePath");
imgdir=$(dirname "${ImagePath}")/
#===========================================

echo "Running $ImagePath ...";
rm -f $ImagePath.PROCESSED.bin;
convert -colorspace gray $ImagePath TEMP-IMG.PGM;
width=$(identify -format "%w" "TEMP-IMG.PGM")> /dev/null;
height=$(identify -format "%h" "TEMP-IMG.PGM")> /dev/null;
printf "Geometry format (Width x Height): $width x $height\n";
excedent_width=`echo "$width%4" | bc`;
excedent_height=`echo "$height%4" | bc`;
printf "Excedent width: $excedent_width\n";
printf "Excedent height: $excedent_height\n";
new_width=`echo "$width-$excedent_width" | bc`;
new_height=`echo "$height-$excedent_height" | bc`;
convert -crop $new_width'x'$new_height-0-0 -compress none TEMP-IMG.PGM TEMP2-IMG.PGM
printf "New geometry format (Width x Height): $new_width x $new_height\n";
printf "Binarizing image ...\n";
tail -n +4 TEMP2-IMG.PGM | ./bitbit/target/release/bitbit $new_width > $ImagePath.PROCESSED.bin;
rm -f TEMP-IMG.PGM TEMP2-IMG.PGM;
printf "Done!\n";
# =======================
convertedfilepath=$ImagePath.PROCESSED.bin;

echo "$ImagePath, $imgfilename, ${imgfilename%.*}, $convertedfilepath"

ls $imgdir

decompressed=`ls -la $convertedfilepath | awk '{print $5;}'`;

#ZSTD
echo "======================ZSTD======================"
(time zstd -19 --rm $convertedfilepath) &> TTT;

TIME=`cat TTT | grep "real" | awk '{print $2}'`;
compressedfilename="${convertedfilepath}.zst"
compressed=`ls -la $compressedfilename | awk '{ print $5;}'`;

zstd -d --rm $compressedfilename

echo "ZSTD-->${imgfilename%.*}; $decompressed; $TIME; $compressed";
echo "ZSTD; ${imgfilename%.*}; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$SAVERESULTS;

#XZ
echo "======================XZ======================"
(time xz -9 $convertedfilepath) &> TTT;

TIME=`cat TTT | grep "real" | awk '{print $2}'`;
compressedfilename="${convertedfilepath}.xz"    

compressed=`ls -la $compressedfilename | awk '{ print $5;}'`;
xz -d $compressedfilename

echo "XZ-->${imgfilename%.*}; $decompressed; $TIME; $compressed";
echo "XZ; ${imgfilename%.*}; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$SAVERESULTS;

#BZIP
echo "======================BZIP======================"
(time bzip2 -9 $convertedfilepath) &> TTT;

TIME=`cat TTT | grep "real" | awk '{print $2}'`;
rm TTT;

compressedfilename="${convertedfilepath}.bz2";
compressed=`ls -la $compressedfilename | awk '{print $5;}'`;
bzip2 -d $compressedfilename;

echo "BZIP-->${imgfilename%.*};$decompressed;$TIME;$compressed";
echo "BZIP; ${imgfilename%.*}; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$SAVERESULTS;

#GZIP
echo "======================GZIP======================"
(time gzip -9 $convertedfilepath) &> TTT;

TIME=`cat TTT | grep "real" | awk '{print $2}'`;
rm TTT;

compressedfilename="${convertedfilepath}.gz";   
compressed=`ls -la $compressedfilename | awk '{print $5;}'`;
gzip -d $compressedfilename;

echo "GZIP-->${imgfilename%.*};$decompressed;$TIME;$compressed";
echo "GZIP; ${imgfilename%.*}; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$SAVERESULTS;

#LZMA
echo "======================LZMA======================"
(time lzma -9 $convertedfilepath) &> TTT;
TIME=`cat TTT | grep "real" | awk '{print $2}'`;
rm  TTT;

compressedfilename="${convertedfilepath}.lzma";     
compressed=`ls -la $compressedfilename | awk '{print $5;}'`;
lzma -d $compressedfilename;

echo "LZMA-->${imgfilename%.*};$decompressed;$TIME;$compressed";
echo "LZMA; ${imgfilename%.*}; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$SAVERESULTS;



#BDM
echo "======================BDM======================"
(time ./BDM_SRC/BDM.exe < $convertedfilepath > JJJ) &> TTT;

TIME=`cat TTT | grep "real" | awk '{print $2}'`;
bdm_value=`cat JJJ`;
rm  JJJ;
echo "BDM-->${imgfilename%.*};$decompressed;$TIME;$bdm_value";
echo "${imgfilename%.*}; $decompressed; $TIME; $bdm_value" >> ${METRICSPATH}$SAVERESULTS;
printf "Done!\n";


#CMIX
if [[ "$USECMIX" -eq "1" ]]; then  

        echo "======================CMIX======================"
        compressedfilename="${imgdir}${imgfilename%.*}.cmix"
        (time ${CMIX_COMPRESSOR_PATH}cmix -c $convertedfilepath $compressedfilename) &> TTT;
        TIME=`cat TTT | grep "real" | awk '{print $2}'`;
        rm TTT;
        
        compressed=`ls -la $compressedfilename | awk '{print $5;}'`;
        echo "CMIX-->${imgfilename%.*};$decompressed;$TIME;$compressed";
        echo "CMIX; ${imgfilename%.*}; $decompressed; $TIME; $compressed" >> ${METRICSPATH}$SAVERESULTS;

        rm $compressedfilename;
fi


#PAQS
# ==============================================================================
# Parameters
# ==============================================================================
EXT=exe;
pattern=$imgdir*.paq*
files=( $pattern )
rm $imgdir*.paq*
# ==============================================================================

for executable in $PAQS_COMPRESSOR_PATH*.${EXT}; do
        filep=$(basename -- "$executable");


        printf '\n';
        echo "---------COMPRESSOR FILE NAME: ${filep%.*} -------------";
        echo "COMPLETE PATH OF COMPRESSOR -->$executable"

        
        echo $METRICSPATH$SAVERESULTS
        
        echo "FILENAME IMAGE--> $convertedfilepath ... IMAGE NAME: $imgfilename ";
        
        decompressed=`ls -la $convertedfilepath | awk '{print $5;}'`;
                        
        (time "" | $executable -8 $convertedfilepath) &> TTT;
        TIME=`cat TTT | grep "real" | awk '{print $2}'`;
        rm TTT;
        
        #echo $imgdir*.paq*
        if [ ! -f $imgdir*.paq* ]; then
                    echo "File not found!";
        else                        
                    fileWithPattern="${files[0]}";
                    echo "FILE FOUND!!! -->" $fileWithPattern;
                    compressed=`ls -la $fileWithPattern | awk '{print $5;}'`;
                    rm $fileWithPattern;
                    echo "${filep%.*}; ${imgfilename%.*}; $decompressed; $TIME; $compressed" >> $METRICSPATH$SAVERESULTS;              
        fi 

done


##############################################3
#variables
counter=0
##############################################3

Alf=`../Compressors/goose-info < $convertedfilepath |grep "Alphabet size"| awk -F ' ' '{print $3}'`

rm ${METRICSPATH}REPORTCOMP

x=../metrics/Other/INPUT_IMG_RESULTS

metricsFileName=$(basename -- "$x")
tail -n +2 $x >> QWERTY

CompressorName=${metricsFileName%.*}
CompName=${CompressorName//_}
counter=0
###################################################
# Creating Reports
###################################################
while read p; do
    cmp=`echo "$p" | awk -F';' '{print $1}'`
    CompName=${cmp//_}
    img=`echo "$p" | awk -F';' '{print $2}'`
    size=`echo "$p" | awk -F';' '{print $3}'`
    tm=`echo "$p" | awk -F';' '{print $4}'`
    compress=`echo "$p" | awk -F';' '{print $5}'`
    
    echo -e "$CompName\t$img\t$size\t$tm\t$compress"

    #Compression            
    echo "${compress}" "${size}"
    
    log2=`echo "scale=3 ; l($Alf)/l(2)" | bc -l`
    echo $log2 
    base=`echo "scale=3 ; $size*$log2" | bc -l`
    echo $base 
    
    RATIO=`echo "scale=3 ; $compress*8/$base" | bc -l`
    echo "$log2 $RATIO "
    echo ${METRICSPATH}REPORTCOMP

    #TimeParsing to seconds
    minuts=`echo $tm | awk -F 'm' '{print $1}'`
    seconds=`echo $tm | awk -F 'm' '{print $2}'`
    seconds=${seconds//s}
    
    min_to_sec=$minuts*60
    tm_in_sec=$min_to_sec+$seconds

    TMP=`echo "scale=5 ;$tm_in_sec"|bc`
    echo "$tm --> $TMP"
    echo -e "$counter\t$TMP\t$RATIO\t\"$CompName\""
    echo -e "$counter\t$TMP\t$RATIO\t\"$CompName\"" >> ${METRICSPATH}REPORTCOMP
    counter=$((counter+1))


done <QWERTY
rm QWERTY

###################################################
# Plots
###################################################
cd $METRICSPATH


gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "REPORTCOMP" using 1:3:xtic(4) with boxes title "Compressibility of Image"  linecolor '#FF4136'
   set ylabel "Time in seconds (s)"
   plot "REPORTCOMP" using 2:xtic(4) with boxes title "Compression time of Image" linecolor '#FF4136'

EOF

for x in *.pdf;do
    mv $x ../../Results/ 
done
xdg-open ../../Results/NC.pdf

cd ../../src/