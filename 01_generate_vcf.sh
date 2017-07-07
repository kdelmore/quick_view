#!/bin/bash
## obtain vcf from ANGSD that can be fed into Max's dxy script (ie. needs genotype field)
## author: kira delmore
## usage is ./*.sh <species> <project> <ref> <min_ind> <list>
## date: june 2017

species=$1
project=$2
ref=$3
minind=$4
list=$5

while read prefix 
do

ANGSD="/SciBorg/array0/kdelmore/tools/angsd/angsd"
out="/SciBorg/array0/kdelmore/comparative_analysis/$species/own_reference/$project.dxy.mind"

$ANGSD/angsd -P 2 -b $project.realigned_bam.list -ref $ref -out $out/"$prefix"_prep \
       -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -trim 0 \
       -minMapQ 20 -minQ 20 -minInd $minind -skipTriallelic 1 \
       -SNP_pval 1e-6 -r "$prefix": \
       -doPlink 2 -doGeno -4 -doPost 1 -doMajorMinor 1 -GL 1 -doCounts 1 -doMaf 2 -postCutoff 0.95

~/tools/plink --tfile $out/"$prefix"_prep --maf 0.05 --out $out/"$prefix"_prep --make-bed --allow-extra-chr
~/tools/plink --bfile $out/"$prefix"_prep --recode vcf-fid --allow-extra-chr --out $out/"$prefix"_prep

done < $list
