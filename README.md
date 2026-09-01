# Alignments on BluePebble 


We assume that we have the output of running Snippy to map short reads to a reference genome, and we've removed the weird characters to get `clean.full.aln`. Now we want to build a tree.

### Removing recombination

First, we need to remove recombinant regions - that is, regions of the genome where there are lots of SNPs due to the transfer of a big chunk of DNA, rather than because of individual mutations. If we don't do this, the tree we build won't reflect the true phylogenetic signal. 

We can do this with [gubbins](https://github.com/nickjcroucher/gubbins). We can run it with `sbatch run_gubbins.sh` which runs the following command:

```
run_gubbins.py --threads 8 --prefix gubbins_out --seed 12345 --verbose clean.full.aln 
# Flag meanings:
# --threads 8 : use 8 threads
# --prefix gubbins_out : put 'gubbins_out' in front of output files
# --seed 12345 : for reproducibility in the future (can be any number, used to seed random number generator)
# --verbose : give lots of information about each step (good for debugging purposes)
``` 

If the job gets killed due to running out of time or memory, you can rerun by editing the script and using `resume` (there is an example of this in there).

By way of example,rRunning `run_gubbins.sh` on 228 *Klebsiella pneumoniae* isolates from Aimee took about 2.5 days. This produces `gubbins.filtered_polymorphic_sites.fasta` which can be used to get a clean core alignment with `snp-sites`:

```
# you may need to create a conda environment with snp-sites first using these commands:
# conda create -n snp-sites
# conda activate snp-sites
# conda install -c bioconda snp-sites
# Then run snp-sites (very quick - seconds)
snp-sites -c clean.full.filtered_polymorphic_sites.fasta > clean.core.postgubbins.aln 
```

### Building a tree

Then we want to use this new alignment to build a tree. The quickest option (fine for most cases) would be to use FastTree to get a quick tree with `run_fasttree.sh`.

Alternatively, we can run `raxml-ng` with `run_raxml-ng.sh`. **This is currently a work-in-progress, not yet confirmed it works.**

