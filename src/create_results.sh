#!/bin/bash
# 
# Process and create Graphs  ==========================================================================
#CA_IMAGES


#CA_IMAGES VARS
CA_METRICSPATH=../metrics/CA/
CA_IMG_PATH=../Images/CA_img/
CA_INITNAME=CA_DATA
CA_Filename=CA_AVG_BYTES_PER_COMPRESSOR
SAVEPATH=../metrics/processed_results/

#DR_IMAGES VARS
DR_METRICSPATH=../metrics/DR/
DR_IMG_PATH=../Images/DR_img/
DR_INITNAME=DR_DATA
DR_Filename=DR_AVG_BYTES_PER_COMPRESSOR

#NA_IMAGES VARS
NA_METRICSPATH=../metrics/NA/
NA_IMG_PATH=../Images/NA_img/
NA_INITNAME=NA_DATA
NA_Filename=NA_AVG_BYTES_PER_COMPRESSOR

#CR_IMAGES VARS
CR_METRICSPATH=../metrics/CR/
CR_IMG_PATH=../Images/CR_img/
CR_INITNAME=CR_DATA
CR_Filename=CR_AVG_BYTES_PER_COMPRESSOR

#US_IMAGES VARS
US_METRICSPATH=../metrics/US/
US_IMG_PATH=../Images/US_img/
US_INITNAME=US_DATA
US_Filename=US_AVG_BYTES_PER_COMPRESSOR

#PROCESS RESULTS##################
bash process_results.sh $CA_METRICSPATH $CA_IMG_PATH $CA_INITNAME
bash process_results.sh $DR_METRICSPATH $DR_IMG_PATH $DR_INITNAME
bash process_results.sh $NA_METRICSPATH $NA_IMG_PATH $NA_INITNAME
bash process_results.sh $CR_METRICSPATH $CR_IMG_PATH $CR_INITNAME
bash process_results.sh $US_METRICSPATH $US_IMG_PATH $US_INITNAME

# #DETERMINE SPENT BYTES/AVG########
bash avg_bytes.sh $CA_METRICSPATH $CA_Filename $SAVEPATH
bash avg_bytes.sh $DR_METRICSPATH $DR_Filename $SAVEPATH
bash avg_bytes.sh $NA_METRICSPATH $NA_Filename $SAVEPATH
bash avg_bytes.sh $CR_METRICSPATH $CR_Filename $SAVEPATH
bash avg_bytes.sh $US_METRICSPATH $US_Filename $SAVEPATH

# #DETERMINE AVG NC##################
bash avg_NC.sh $SAVEPATH $CA_INITNAME
bash avg_NC.sh $SAVEPATH $DR_INITNAME
bash avg_NC.sh $SAVEPATH $NA_INITNAME

bash avg_NC.sh $SAVEPATH $CR_INITNAME
bash avg_NC.sh $SAVEPATH $US_INITNAME

bash graph.sh
