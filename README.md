# Splicing_with_rMATS
Protocol to run alternative splicing analysis on wasps (Myriad)

rMATS is a program that calculates event-specific alternative splicing measurements in RNA-Seq data. Check out their very well organised github page: https://github.com/Xinglab/rmats-turbo#usage

It takes a GTF (not GFF3, you may need to convert it), genome (indexed in STAR, explained later) and fastq data (I find only unzipped works :( ...).

**Myriad installation:**

**First**, you need to install **conda** on myriad. https://docs.conda.io/en/latest/miniconda.html  Try to do it yourself first, then ask me if there are any hickups.

**Second**:
conda install -c conda-forge -c bioconda rmats=4.1.0
conda install STAR

**Or** install from binaries, if the above does not work (then make sure you put these in your $PATH). e.g. STAR:
wget https://github.com/alexdobin/STAR/archive/2.7.0e.tar.gz
tar -xvf 2.7.0e.tar.gz
STAR --version

If this does not work, maybe you have sucessfully downloaded STAR, but it is not in your $PATH 
I make sure in my ~/.bash_profile I have the following line
export PATH=$PATH:/home/ucbtcdr/bin
Then I can cp my STAR executable into /home/ucbtcdr/bin . Then it should be able to find it on the command line (may need to close and reopen terminal)

**Third**, mount RDS onto myriad (use your own UCL ID, and enter password):
ssh ucbtcdr@transfer02

**4th**: Create a bash submission script to index your genome file (Run_index.sh: example below on my login):
#!/bin/bash -l
#$ -l h_rt=1:0:0
#$ -l mem=10G
#$ -N STAR_index
#$ -pe mpi 4
#$ -wd /home/ucbtcdr/Scratch/AS_Vespa/
#$ -e /home/ucbtcdr/Scratch/AS_Vespa/

STAR --runMode genomeGenerate --genomeFastaFiles V.crabro.RM.hymenoptera.fasta --genomeSAindexNbases 12 --runThreadN 4

qsub Run_index.sh

**5th**: Create bach submission script to run rMATS:
#!/bin/bash -l
#$ -l h_rt=30:0:0
#$ -l mem=10G
#$ -N rMATS_run
#$ -pe mpi 4
#$ -wd /home/ucbtcdr/Scratch/AS_Vespa/
#$ -e /home/ucbtcdr/Scratch/AS_Vespa/

rmats.py --nthread 4 --s1 Trial_1.txt --s2 Trial_2.txt --gtf Vespa_crabro.gtf -t paired --readLength 150 --od /home/ucbtcdr/Scratch/AS_Vespa/output --tmp /home/ucbtcdr/Scratch/AS_Vespa/tmp_output --bi /home/ucbtcdr/Scratch/AS_Vespa/Genome_index_2/GenomeDir 

Where 'Trials' are the full path to the fastq files (here i show forward (1) and reverse (2) reads for a Queen (VCQ) and Worker (VC_W) of Vespa crabro:

Trial_1.txt : /home/ucbtcdr/Scratch/AS_Vespa/Files_diff_name/VCQ2_1.fastq:/home/ucbtcdr/Scratch/AS_Vespa/Files_diff_name/VCQ2_2.fastq
Trial_2.txt : /home/ucbtcdr/Scratch/AS_Vespa/Files_diff_name/VC_W1_1.fastq:/home/ucbtcdr/Scratch/AS_Vespa/Files_diff_name/VC_W1_2.fastq

--bi  is the path to the genome index folder created by STAR in step 4. In my run it was called GenomeDir

**OUTPUT (folder output)**


