# Ganga Example

Author: Sam Eriksen

Date: August 2023


## Overview
This directory contains a basic example of how to run BACCARAT on Perlmutter using ganga as the submission controller.
It is made up of 3-parts;
1. `ganga_script.py'
   * This is a piece of python code which ganga uses
   * It sets up the job, telling each sub-job which parameters it will have
2. `worker_node_script.sh`
   * This is the actual code that is executed on a node
3. `macros`
   * This directory contains the macros which you want to run

Each job is split up using the ganga `GenericSplitter`, where each job has a different dictionary in a list.
The jobs are then run using one of two backends;
1. slurm
   * This is just running `sbatch` in the background
2. local
   * This runs locally but in the background


