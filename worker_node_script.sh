#!/bin/bash
#########################################################
#
# Title: worker_node_script.sh
# Author: Sam Eriksen
# Date: August 2023
#
# Description: Script to execute BACCARAT
#              It is designed be passed as part of ganga
#              However it can be run stand alone
#########################################################

# Save machine OS for debugging
cat /etc/os-release
echo

# Save to ganga stdout
export SEED="${SEED}"
export OUTPUT_FILENAME="${OUTPUT_FILENAME}"
export OUTPUT_DIR="${OUTPUT_DIR}"
export NBEAMON="${NBEAMON}"
export MACRO="${MACRO}"
export BACCARAT_VERSION="${BACCARAT_VERSION}"
export RESULTS_DIR="${RESULTS_DIR}"

echo "Environment Variables"
echo "export NBEAMON=${NBEAMON}"
echo "export OUTPUT_FILENAME=${OUTPUT_FILENAME}"
echo "export OUTPUT_DIR=${OUTPUT_DIR}"
echo "export MACRO=${MACRO}"
echo "export SEED=${SEED}"
echo "export BACCARAT_VERSION=${BACCARAT_VERSION}"
echo "export RESULTS_DIR=${RESULTS_DIR}"
echo

# Making output directories
echo "Working Dir: ${PWD}"
echo "ls of PWD"
ls

# Run Command for BACCARAT
run_command="source /cvmfs/lz.opensciencegrid.org/BACCARAT/release-${BACCARAT_VERSION}/x86_64-centos7-gcc8-opt/setup.sh;
             sv_execute -m performance_${SEED}.json BACCARATExecutable ${MACRO};
             mkdir -p ${RESULT_DIR};
             cp performance_${SEED}.json ${RESULTS_DIR}/performance_${SEED}.json;"

# Now write the run command, this is a bit of a hack to get things working correctly
echo "Run Command"
echo ${run_command}
echo "${run_command}" > run_file.sh
chmod +x run_file.sh
echo
echo -e "${blue_bg}Running BACCARAT shifter${reset_colour}"
shifter --module=cvmfs --image=luxzeplin/offline_hosted:centos7 /bin/bash ./run_file.sh