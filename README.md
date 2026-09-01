# Alignments on BluePebbl 

We assume that we have the output of running Snippy to map short reads to a reference genome, and we've removed the weird characters to get `clean.full.aln`.

Then we run `gubbins` to remove recombinant regions. If we don't do this, the tree won't reflect a true phylogenetic signal. We can do this with `sbatch run_gubbins.sh` which runs the following command:

```
run_gubbins.py --threads 8 --prefix gubbins_out --seed 12345 --verbose clean.full.aln 
# Flag meanings:
# --threads 8 : use 8 threads
# --prefix gubbins_out : put 'gubbins_out' in front of output files
# --seed 12345 : for reproducibility in the future (can be any number, used to seed random number generator)
# --verbose : give lots of information about each step (good for debugging purposes)
``` 

If the job gets killed due to running out of time or memory, you can rerun by editing the script and using `resume`.

Running `run_gubbins.sh` on 228 *Klebsiella pneumoniae* isolates from Aimee took about 2.5 days. This produces `gubbins.filtered_polymorphic_sites.fasta` which can be used to get a clean core aignment with `snp-sites`:

```
# you may need to create a conda environment with snp-sites first
# conda create -n snp-sites
# conda activate snp-sites
# conda install -c bioconda snp-sites
snp-sites -c clean.full.filtered_polymorphic_sites.fasta > clean.core.postgubbins.aln 
```

Then use FastTree to get a quick tree with `run_fasttree.sh`.

Or alternatively, run `raxml-ng` with `run_raxml-ng.sh`.

