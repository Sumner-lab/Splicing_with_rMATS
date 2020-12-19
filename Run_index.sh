#!/bin/bash -l
#$ -l h_rt=30:0:0
#$ -l mem=10G
#$ -N STAR_index
#$ -pe mpi 4
#$ -wd /home/ucbtcdr/Scratch/AS_Vespa/Genome_index_2
#$ -e /home/ucbtcdr/Scratch/AS_Vespa/Genome_index_2

STAR --runMode genomeGenerate --genomeFastaFiles V.crabro.RM.hymenoptera.fasta --genomeSAindexNbases 12 --runThreadN 4
