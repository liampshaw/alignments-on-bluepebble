#!/bin/bash
#SBATCH --job-name=gubbins
#SBATCH --partition=compute
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --account=panm038524 # replace with your project name 

module load apps/gubbins/3.4.3
module load apps/raxml-ng/2.0.2

# If running from start 
run_gubbins.py --threads 8 --seed 12345 --verbose clean.full.aln  # might want to set prefix too?
# If running a job that was killed/cancelled while resuming it
run_gubbins.py --threads 8 --prefix clean.full --seed 12345 --verbose \
  --tree-builder raxmlng \
  --resume clean.full.iteration_1.tre \
  clean.full.aln
