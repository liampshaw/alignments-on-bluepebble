#!/bin/bash
#SBATCH --job-name=fasttree
#SBATCH --partition=compute
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --account=panm038524 # replace with your project name 

# load FastTree module
module load fasttree/2.1.11-ypks
# run FastTree (fast - will only take a few minutes)
FastTree -gtr -nt clean.core.postgubbins.aln > clean.core.postgubbins.tree


