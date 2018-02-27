#MOLGENIS nodes=1 ppn=1 mem=1gb walltime=05:00:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string externalSampleID
#string project
#string intermediateDir

#Load module

module load dudes/v0.08-foss-2015b-Python-3.4.1

python3 /groups/umcg-gastrocol/tmp03/metagenomic_tools/dudes_v0_07/DUDes.py \
-s ./$SAMPLE_ID/DUDes/$SAMPLE_ID_output.sam \
-d /groups/umcg-gastrocol/tmp03/metagenomic_tools/dudes_v0_07/custom_db/DUDES_refseq_db.npz \
-t 6 \
-m 50 \
-a 0.0005 \
-l strain \
-o ./$SAMPLE_ID/DUDes/$SAMPLE_ID
