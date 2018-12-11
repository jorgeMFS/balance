#!/bin/bash
#
# RUN  Compression##############

#CA
IMG_PATH_CA=../Images/CA_img/
METRICSPATH_CA=../metrics/CA/

#CR
IMG_PATH_CR=../Images/CR_img/
METRICSPATH_CR=../metrics/CR/

#DR
IMG_PATH_DR=../Images/DR_img/
METRICSPATH_DR=../metrics/DR/

#NA
IMG_PATH_NA=../Images/NA_img/
METRICSPATH_NA=../metrics/NA/

#US
IMG_PATH_US=../Images/US_img/
METRICSPATH_US=../metrics/US/

#CA
bash Compressors.sh $IMG_PATH_CA $METRICSPATH_CA

#CR
bash Compressors.sh $IMG_PATH_CR $METRICSPATH_CR

#DR
# bash Compressors.sh $IMG_PATH_DR $METRICSPATH_DR

#NA
# bash Compressors.sh $IMG_PATH_NA $METRICSPATH_NA

#US
# bash Compressors.sh $IMG_PATH_US $METRICSPATH_US
