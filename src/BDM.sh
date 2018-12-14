#!/bin/bash
#
# ==============================================================================
# Options
# ==============================================================================
INSTALL_BDM=0;
BUILD_BINARY=0;
TRANSFORM_DATA=1;
# ==============================================================================
# Install BDM
# ==============================================================================
if [[ "$INSTALL_BDM" -eq "1" ]];
   then
   rm -fr BDM_SRC/
   mkdir BDM_SRC/
   cd BDM_SRC/
   wget https://www.algorithmicdynamics.net/uploads/4/3/8/0/43802527/bdmcpp.zip
   unzip bdmcpp.zip
   cd bdmcpp/
   g++ -o BDM.exe BDM.cpp -lgmp -lm
   cp BDM.exe ../
   cp complexities.txt ../
   cd ../../
   fi
# ==============================================================================
# Buid bitbit binary
# ==============================================================================
if [[ "$BUILD_BINARY" -eq "1" ]];
   then
    cd bitbit/
    cargo build --release
    cd ../
   fi

# ==============================================================================
#Transform_DATA so to apply metrics
# ==============================================================================
if [[ "$TRANSFORM_DATA" -eq "1" ]];
   then
    rm ../Images/CA_img/*PROCESSED.bin;
    
    shopt -s globstar

    for x in ../Images/CA_img/*.bin;
     do
     echo "Running $x ...";
     tr '\n' '-' < $x > $x.PROCESSED.bin;
    done

    for x in ../Images/**/*.pgm;
     do
     echo "Running $x ...";
     rm -f $x.PROCESSED.bin;
     convert -colorspace gray $x TEMP-IMG.PGM;
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
     tail -n +4 TEMP2-IMG.PGM | ./bitbit/target/release/bitbit $new_width > $x.PROCESSED.bin;
     rm -f TEMP-IMG.PGM TEMP2-IMG.PGM;
     printf "Done!\n";
    done
fi

# ==============================================================================
