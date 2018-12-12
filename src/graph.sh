#!/bin/bash
# 
# PLOTS  ==========================================================================

#Paths
METRICSPATH=../metrics/processed_results/

cd $METRICSPATH


##############CA####################
gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "CA_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "CA_DATA_109_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image 109"
   plot "CA_DATA_193_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image 193"
   plot "CA_DATA_135_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image 135"
   plot "CA_DATA_149_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image 149"
   plot "CA_DATA_161_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image 161"
   plot "CA_DATA_182_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image 182"
   plot "CA_DATA_73_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image 73"
   plot "CA_DATA_86_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image 86"
   plot "CA_DATA_89_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image 89"
EOF


gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "CA_AVG_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "CA_DATA_AVG_Compression" using 1:2:xtic(3) with boxes linecolor '#3D9970' title "Average Compressibility Compressor"
EOF

gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "CA_BYTES_COMPRESSOR.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Bytes"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "CA_AVG_BYTES_PER_COMPRESSOR" using 1:2:xtic(4) with boxes linecolor '#2ECC40' title "Total Bytes used by Compressor in Algoritmic Images"
   plot "CA_AVG_BYTES_PER_COMPRESSOR" using 1:3:xtic(4) with boxes linecolor '#2ECC40' title "Average Bytes used by Compressor per Algoritmic Images"
EOF



gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "CA_time.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set ytics 0,5,100
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set xlabel "Compressor" 
   set style fill solid 
   set ylabel "Time in seconds"
   set format '%g'
   set datafile separator "\t"
   plot "CA_DATA_109_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image 109"
   plot "CA_DATA_193_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression TimeImage 193"
   plot "CA_DATA_135_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image 135"
   plot "CA_DATA_149_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image 149"
   plot "CA_DATA_161_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image 161"
   plot "CA_DATA_182_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image 182"
   plot "CA_DATA_73_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image 73"
   plot "CA_DATA_86_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image 86"
   plot "CA_DATA_89_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image 89"

EOF

################################CR####################


gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "CR_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "CR_DATA_CR1_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image CR1"
   plot "CR_DATA_CR2_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image CR2"
   plot "CR_DATA_CR3_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image CR3"
   plot "CR_DATA_CR4_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image CR4"
   plot "CR_DATA_CR5_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image CR5"
   plot "CR_DATA_CR6_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image CR6"
   plot "CR_DATA_CR7_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image CR7"
   plot "CR_DATA_CR8_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image CR8"
   plot "CR_DATA_CR9_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image CR9"
EOF


gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "CR_AVG_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "CR_DATA_AVG_Compression" using 1:2:xtic(3) with boxes linecolor '#3D9970' title "Average Compressibility Compressor"
EOF

gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "CR_BYTES_COMPRESSOR.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Bytes"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "CR_AVG_BYTES_PER_COMPRESSOR" using 1:2:xtic(4) with boxes linecolor '#2ECC40' title "Total Bytes used by Compressor in Algoritmic Images"
   plot "CR_AVG_BYTES_PER_COMPRESSOR" using 1:3:xtic(4) with boxes linecolor '#2ECC40' title "Average Bytes used by Compressor per Algoritmic Images"
EOF






gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "CR_time.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set ytics 0,5,100
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set xlabel "Compressor" 
   set style fill solid 
   set ylabel "Time in seconds"
   set format '%g'
   set datafile separator "\t"
   plot "CR_DATA_CR1_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image CR1"
   plot "CR_DATA_CR2_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression TimeImage CR2"
   plot "CR_DATA_CR3_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image CR3"
   plot "CR_DATA_CR4_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image CR4"
   plot "CR_DATA_CR5_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image CR5"
   plot "CR_DATA_CR6_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image CR6"
   plot "CR_DATA_CR7_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image CR7"
   plot "CR_DATA_CR8_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image CR8"
   plot "CR_DATA_CR9_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image CR9"

EOF

exit 1
################################DR####################

gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "DR_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "DR_DATA_DR1_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image DR1"
   plot "DR_DATA_DR2_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image DR2"
   plot "DR_DATA_DR3_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image DR3"
   plot "DR_DATA_DR4_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image DR4"
   plot "DR_DATA_DR5_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image DR5"
   plot "DR_DATA_DR6_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image DR6"
   plot "DR_DATA_DR7_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image DR7"
   plot "DR_DATA_DR8_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image DR8"
   plot "DR_DATA_DR9_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image DR9"
EOF


gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "DR_AVG_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "DR_DATA_AVG_Compression" using 1:2:xtic(3) with boxes linecolor '#3D9970' title "Average Compressibility Compressor"
EOF

gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "DR_BYTES_COMPRESSOR.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Bytes"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "DR_AVG_BYTES_PER_COMPRESSOR" using 1:2:xtic(4) with boxes linecolor '#2ECC40' title "Total Bytes used by Compressor in Algoritmic Images"
   plot "DR_AVG_BYTES_PER_COMPRESSOR" using 1:3:xtic(4) with boxes linecolor '#2ECC40' title "Average Bytes used by Compressor per Algoritmic Images"
EOF






gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "DR_time.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set ytics 0,5,100
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set xlabel "Compressor" 
   set style fill solid 
   set ylabel "Time in seconds"
   set format '%g'
   set datafile separator "\t"
   plot "DR_DATA_DR1_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image DR1"
   plot "DR_DATA_DR2_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression TimeImage DR2"
   plot "DR_DATA_DR3_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image DR3"
   plot "DR_DATA_DR4_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image DR4"
   plot "DR_DATA_DR5_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image DR5"
   plot "DR_DATA_DR6_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image DR6"
   plot "DR_DATA_DR7_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image DR7"
   plot "DR_DATA_DR8_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image DR8"
   plot "DR_DATA_DR9_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image DR9"

EOF

################################NA####################




gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "NA_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "NA_DATA_NA1_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image NA1"
   plot "NA_DATA_NA2_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image NA2"
   plot "NA_DATA_NA3_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image NA3"
   plot "NA_DATA_NA4_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image NA4"
   plot "NA_DATA_NA5_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image NA4"
   plot "NA_DATA_NA6_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image NA5"
   plot "NA_DATA_NA7_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image NA6"
   plot "NA_DATA_NA8_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image NA7"
   plot "NA_DATA_NA9_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image NA8"
EOF


gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "NA_AVG_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "NA_DATA_AVG_Compression" using 1:2:xtic(3) with boxes linecolor '#3D9970' title "Average Compressibility Compressor"
EOF

gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "NA_BYTES_COMPRESSOR.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Bytes"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "NA_AVG_BYTES_PER_COMPRESSOR" using 1:2:xtic(4) with boxes linecolor '#2ECC40' title "Total Bytes used by Compressor in Algoritmic Images"
   plot "NA_AVG_BYTES_PER_COMPRESSOR" using 1:3:xtic(4) with boxes linecolor '#2ECC40' title "Average Bytes used by Compressor per Algoritmic Images"
EOF






gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "NA_time.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set ytics 0,5,100
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set xlabel "Compressor" 
   set style fill solid 
   set ylabel "Time in seconds"
   set format '%g'
   set datafile separator "\t"
   plot "NA_DATA_NA1_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image NA1"
   plot "NA_DATA_NA2_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression TimeImage NA2"
   plot "NA_DATA_NA3_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image NA3"
   plot "NA_DATA_NA4_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image NA4"
   plot "NA_DATA_NA5_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image NA5"
   plot "NA_DATA_NA6_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image NA6"
   plot "NA_DATA_NA7_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image NA7"
   plot "NA_DATA_NA8_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image NA8"
   plot "NA_DATA_NA9_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image NA9"

EOF

################################US####################


gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "US_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "US_DATA_US1_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image US1"
   plot "US_DATA_US2_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image US2"
   plot "US_DATA_US3_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image US3"
   plot "US_DATA_US4_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image US4"
   plot "US_DATA_US5_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image US4"
   plot "US_DATA_US6_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image US5"
   plot "US_DATA_US7_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image US6"
   plot "US_DATA_US8_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image US7"
   plot "US_DATA_US9_Compression" using 1:2:xtic(3) with boxes linecolor '#FF4136' title "Compressibility of Image US8"
EOF


gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "US_AVG_NC.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:1]
   set ytics 0.2
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Normalized Compression"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "US_DATA_AVG_Compression" using 1:2:xtic(3) with boxes linecolor '#3D9970' title "Average Compressibility Compressor"
EOF

gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "US_BYTES_COMPRESSOR.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set style fill solid 
   set ylabel "Bytes"
   set format '%g'
   set xlabel "Compressor" 
   set datafile separator "\t"
   plot "US_AVG_BYTES_PER_COMPRESSOR" using 1:2:xtic(4) with boxes linecolor '#2ECC40' title "Total Bytes used by Compressor in Algoritmic Images"
   plot "US_AVG_BYTES_PER_COMPRESSOR" using 1:3:xtic(4) with boxes linecolor '#2ECC40' title "Average Bytes used by Compressor per Algoritmic Images"
EOF






gnuplot << EOF
   reset
   set terminal pdfcairo enhanced color font 'Verdana,8'
   set output "US_time.pdf"
   set boxwidth 0.5
   set xtics 5 rotate by -45
   set ytics 0,5,100
   set size ratio 0.6
   set style line 101 lc rgb '#000000' lt 1 lw 3
   set key outside horiz center top
   set tics nomirror out scale 0.75
   set xrange [:]
   set yrange [0:*]
   set border 3 front ls 101
   set grid ytics lt -1
   set xlabel "Compressor" 
   set style fill solid 
   set ylabel "Time in seconds"
   set format '%g'
   set datafile separator "\t"
   plot "US_DATA_US1_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image US1"
   plot "US_DATA_US2_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression TimeImage US2"
   plot "US_DATA_US3_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image US3"
   plot "US_DATA_US4_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image US4"
   plot "US_DATA_US5_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image US5"
   plot "US_DATA_US6_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image US6"
   plot "US_DATA_US7_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image US7"
   plot "US_DATA_US8_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image US8"
   plot "US_DATA_US9_time" using 1:2:xtic(3) with boxes linecolor '#001f3f' title "Compression Time Image US9"
EOF



for x in *.pdf;do
    mv $x ../../Results/ 
done


cd ../../src/
