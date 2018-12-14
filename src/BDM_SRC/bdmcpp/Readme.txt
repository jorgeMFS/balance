The following bash script for extracting and trim (multiple of 4 for both lines and columns) the binary matrix of an image:
  convert -colorspace gray $1 TEMP-IMG.PGM;
  width=$(identify -format "%w" "TEMP-IMG.PGM")> /dev/null;
  height=$(identify -format "%h" "TEMP-IMG.PGM")> /dev/null;
  printf "Geometry format (Width x Height): $width x $height\n";
  excedent_width=`echo "$width%4" | bc`;
  excedent_height=`echo "$height%4" | bc`;
  printf "Excedent width: $excedent_width\n";
  printf "Excedent height: $excedent_height\n";
  new_width=`echo "$width-$excedent_width" | bc`;
  new_height=`echo "$height-$excedent_height" | bc`;
  #
  convert -crop $new_width'x'$new_height-0-0 -compress none TEMP-IMG.PGM TEMP2-IMG.PGM
  printf "New geometry format (Width x Height): $new_width x $new_height\n";
  #
  printf "Binarizing image ...\n";
  idx=0;
  tail -n +4 TEMP2-IMG.PGM | tr -d '\n' | tr ' ' '\n' | while read LINE; 
    do
    ((idx++));
    CHARACTER=`printf $LINE | tr -d '\n'`;
    TMP_LINE=`printf "\x$(printf %x $CHARACTER)" | xxd -b | awk '{ print $2}'`;
    printf "$TMP_LINE" >> $1.PROCESSED.bin;
    if (( "$idx" == "$new_width" ));
      then
      printf "-" >> $1.PROCESSED.bin;
      idx=0;
      fi
    done
  rm -f TEMP-IMG.PGM TEMP2-IMG.PGM;
  printf "Done!\n";

