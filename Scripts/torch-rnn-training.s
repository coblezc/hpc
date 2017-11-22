#!/bin/bash
#SBATCH --gres=gpu:k80:2
#SBATCH --time=08:00:00
#SBATCH --mem=16GB
#SBATCH --job-name=training
#SBATCH --mail-type=END
#SBATCH --mail-user=netID@nyu.edu
#SBATCH --output=training-_%j.out

# script to run torch-rnn library
# https://github.com/jcjohnson/torch-rnn
# performs training on corpus
# for more info on the training flags, see
# https://github.com/jcjohnson/torch-rnn/blob/master/doc/flags.md#training

module load torch/gnu/20170504

SRCDIR=$SCRATCH/torch-rnn
RUNDIR=$SCRATCH/wikipedia/training_test/run-${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
cd $RUNDIR
cp -R $SRCDIR/* $RUNDIR

th train.lua -input_h5 data/preprocessed-data.h5 -input_json data/preprocessed-data.json -seq_length 256 -rnn_size 512 -dropout 0.25 -num_layers 2 -checkpoint_name cv/checkpoint

# leave a blank line at the end
