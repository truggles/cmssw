#!/bin/bash
# Save current working dir so img can be outputted there later
W_DIR=$(pwd);
# Set SCRAM architecture var
SCRAM_ARCH=slc6_amd64_gcc630;
export SCRAM_ARCH;
source /afs/cern.ch/cms/cmsset_default.sh;
eval `scram run -sh`;
# Go back to original working directory
cd $W_DIR;
# Run get payload data script

mkdir $W_DIR/results

####################
# Test Gains
####################
/afs/cern.ch/user/c/condbpro/public/BROWSER_PI/getPayloadData.py \
    --plugin pluginSiStripApvGain_PayloadInspector \
    --plot plot_SiStripApvGainsByRegionComparator \
    --tag SiStripApvGainAfterAbortGap_PCL_v0_prompt \
    --time_type Run \
    --iovs '{"start_iov": "302393", "end_iov": "305114"}' \
    --db Prep \
    --test;

mv *.png $W_DIR/results/G2_update.png

/afs/cern.ch/user/c/condbpro/public/BROWSER_PI/getPayloadData.py \
    --plugin pluginSiStripApvGain_PayloadInspector \
    --plot plot_SiStripApvGainsByRegionComparator \
    --tag SiStripApvGain_GR10_v1_hlt \
    --time_type Run \
    --iovs '{"start_iov": "302322", "end_iov": "306054"}' \
    --db Prod \
    --test;

mv *.png $W_DIR/results/G1_updated.png