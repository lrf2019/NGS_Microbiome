#MOLGENIS nodes=1 ppn=1 mem=1gb walltime=05:00:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string externalSampleID
#string project
#string intermediateDir

#Load module

module load Bowtie2/2.2.9-foss-2015b

bowtie2 \
-x /groups/umcg-gastrocol/tmp03/metagenomic_tools/dudes_v0_07/custom_db/db_refseq_20052017 \
--no-unal \
--fast \
-p 6 \
-k 50 \
-1 ./$SAMPLE_ID/clean_reads/$SAMPLE_ID_1_kneaddata_paired_1.fastq \
-2 ./$SAMPLE_ID/clean_reads/$SAMPLE_ID_1_kneaddata_paired_2.fastq \
-S ./$SAMPLE_ID/DUDes/$SAMPLE_ID_output.sam
