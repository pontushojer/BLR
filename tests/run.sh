#!/bin/bash
set -xeuo pipefail

( cd testdata && bowtie2-build chr1mini.fasta chr1mini > /dev/null )

rm -rf outdir
mkdir -p outdir
ln -s $PWD/testdata/reads.1.fastq.gz outdir/reads.1.fastq.gz
ln -s $PWD/testdata/reads.2.fastq.gz outdir/reads.2.fastq.gz

snakemake outdir/reads.1.final.fastq.gz outdir/reads.2.final.fastq.gz

m=$(samtools view outdir/mapped.sorted.tag.rmdup.x2.filt.bam | md5sum | cut -f1 -d" ")
test $m == 424db26031fa6d874da95ad5f023bbce