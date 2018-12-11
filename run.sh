#!/bin/bash
# 

cd ./src/
chmod +x TestCompressors.sh
chmod +x Compressors/create_results.sh
chmod +x Compressors/goose-info
chmod +x Compressors/paqs/*

./TestCompressors.sh &
./create_results.sh &
