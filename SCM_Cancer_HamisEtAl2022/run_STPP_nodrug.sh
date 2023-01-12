#!/bin/bash
RCP_MODEL="model_definition_STPP/rcp_models/model_no_celldeath.txt"
INITIAL_CELLCONFIG="1"

ICC="model_definition_STPP/initial_cell_configs/ICC${INITIAL_CELLCONFIG}.txt"
VERSION="v${INITIAL_CELLCONFIG}"

for i in {1..100}; 
do 
mkdir snapshots/${VERSION}/run${i}; 
done

for i in {1..100};
do
    STPP_code_files/ppsimulator -p model_definition_STPP/rcp_models/processes.txt -m $RCP_MODEL -i $ICC -o STPPoutputs/out -U 1000 -T 200 -dT 1 -r ${i} -osep snapshots/${VERSION}/run${i}/snap;
done

#The below lines can be included to generate snapshot films: 
#Rscript SPP_code_files/visualise_data.R
#ffmpeg -framerate 2 -f image2 -i snapshots/${VERSION}/run1/tmp%06d.jpeg snapshots/${VERSION}/video_${VERSION}.avi
