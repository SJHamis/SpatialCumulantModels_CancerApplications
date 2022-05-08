#!/bin/bash
INITIAL_CELLCONFIG="1"
DOSE_TIME="200"

RCP_MODEL_DIR="model_definition_STPP/rcp_models/v${INITIAL_CELLCONFIG}"
ICC_DIR="snapshots/v${INITIAL_CELLCONFIG}"

VERSIONMFPM="v${INITIAL_CELLCONFIG}_dMFPM"
VERSIONSCM="v${INITIAL_CELLCONFIG}_dSCM"

for i in {1..100}; 
do 
mkdir snapshots/${VERSIONMFPM}/run${i}; 
mkdir snapshots/${VERSIONSCM}/run${i}; 
done

for i in {1..100};
do
    STPP_code_files/ppsimulator.o -p model_definition_STPP/rcp_models/processes.txt -m $RCP_MODEL_DIR/Model_MFPM_${i} -i $ICC_DIR/run${i}/snap000$DOSE_TIME -o STPPoutputs/out -U 1000 -T 150 -dT 1 -r ${i} -osep snapshots/${VERSIONMFPM}/run${i}/snap;
done

for i in {1..100};
do
    STPP_code_files/ppsimulator.o -p model_definition_STPP/rcp_models/processes.txt -m $RCP_MODEL_DIR/Model_SCM_${i} -i $ICC_DIR/run${i}/snap000$DOSE_TIME -o STPPoutputs/out -U 1000 -T 150 -dT 1 -r ${i} -osep snapshots/${VERSIONSCM}/run${i}/snap;
done