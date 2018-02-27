#MOLGENIS nodes=1 ppn=1 mem=1gb walltime=05:00:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string bowtie2Reference
#string externalSampleID
#string project
#string intermediateDir
#string sampleKneadDataOut
#string kneaddataVersion
#string Bowtie2Version
#string picardVersion
#string Bowtie2Version
#string humann2Version

makeTmpDir ${sampleKneadDataOut}
tmpsampleKneadDataOut=${MC_tmpFile}

#Load module
module load ${picardVersion}
module load ${Bowtie2Version}
module load ${humann2Version}

export PATH=$PATH:/groups/umcg-gastrocol/tmp03/metagenomic_tools/metaphlan_2/
export PATH=$PATH:/home/umcg-avich/.local/bin

echo "Run Humann2, WARNING: Check Humann2 configuration!!! (We currently use Uniref90 + Chocophlan db)"
echo "Starting pathways prediction using Humann2"

humann2 --input ./$SAMPLE_ID/clean_reads/$SAMPLE_ID_kneaddata_merged.fastq \
--output ./$SAMPLE_ID/humann2/ \
--taxonomic-profile ./$SAMPLE_ID/metaphlan/$SAMPLE_ID_metaphlan.txt \
--threads 6 \
--o-log ./$SAMPLE_ID/clean_reads/$SAMPLE_ID.full.humann2.log \
--remove-temp-output

mv ./$SAMPLE_ID/clean_reads/*.log ./$SAMPLE_ID/
