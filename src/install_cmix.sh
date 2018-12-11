#!/bin/bash
# 
# Install CMIX BINARIES ==========================================================================
sudo apt-get install g++-multilib
git clone https://github.com/byronknoll/cmix.git
cd cmix 
make
cd ..