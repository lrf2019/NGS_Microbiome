



module load picard 
module load Python/3.4.1-foss-2015b
module load Bowtie2
module load humann2/v0.6.1-foss-2015b-Python-2.7.11

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
