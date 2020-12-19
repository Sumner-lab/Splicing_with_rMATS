#!/bin/bash -l
#$ -l h_rt=30:0:0
#$ -l mem=10G
#$ -N rMATS
#$ -pe mpi 4
#$ -wd /home/ucbtcdr/Scratch/AS_Vespa/
#$ -e /home/ucbtcdr/Scratch/AS_Vespa/

rmats.py --nthread 4 --s1 Trial_1.txt --s2 Trial_2.txt --gtf Vespa_crabro.gtf -t paired --readLength 150 --od /home/ucbtcdr/Scratch/AS_Vespa/output --tmp /home/ucbtcdr/Scratch/AS_Vespa/tmp_output --bi /home/ucbtcdr/Scratch/AS_Vespa/Genome_index_2/GenomeDir 
