#!/bin/bash
#SBATCH --job-name=gubbins
#SBATCH --partition=compute
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --account=panm038524 # replace with your project name 


module load apps/raxml-ng/2.0.2

raxml-ng --all \
  --msa clean.full.filtered_polymorphic_sites.fasta \
  --model GTR+G+ASC_LEWIS \
  --prefix bs1000 \
  --seed 12345 \
  --threads auto{8} \
  --bs-trees 1000
  --extra thread-nopin # may be needed to disable raxml's thread pinning, which causes longer runtimes?
