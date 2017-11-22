#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
## 5 minutes is fine, preprocessing is fast; GPU not required
#SBATCH --time=00:05:00
#SBATCH --mem=16GB
#SBATCH --job-name=preprocessing
#SBATCH --mail-type=END
#SBATCH --mail-user=netID@nyu.edu
#SBATCH --output=preprocessing-_%j.out

# script to run torch-rnn library
# https://github.com/jcjohnson/torch-rnn
# performs preprocessing; takes .txt input file and creates .h5 and .json output

# clear previous packages
module purge
# load packages
module load python/intel/2.7.12
module load h5py/intel/2.7.0rc2

# source directory that contains preprocessing data and script
SRCDIR=$SCRATCH/torch-rnn
# copy the source directory into a new 'run' folder
RUNDIR=$SCRATCH/preprocessing/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
cd $RUNDIR
cp -R $SRCDIR/* $RUNDIR

python scripts/preprocess.py --input_txt data/tiny-shakespeare.txt --output_h5 data/tinyshakespeare-processed.h5 --output_json data/tinyshakespeare-processed.json

# leave a blank line at the end
