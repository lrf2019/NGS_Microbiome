#MOLGENIS nodes=1 ppn=6 mem=20gb walltime=23:50:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string bowtie2Reference
#string externalSampleID
#string project
#string intermediateDir
#string sampleKneadDataOut
#string sampleKneadDataMergedFasta
#string kneaddataVersion
#string Bowtie2Version
#string picardVersion
#string Bowtie2Version
#string humann2Version
#string sampleMetaphlanOutTxt
#string project
#string group
#string tmpDirectory
#string logsDir

makeTmpDir ${sampleKneadDataOut}
tmpsampleKneadDataOut=${MC_tmpFile}

#Load module
module load ${picardVersion}
module load ${Bowtie2Version}
module load ${humann2Version}

#export PATH=$PATH:/groups/umcg-gastrocol/tmp03/metagenomic_tools/metaphlan_2/
#export PATH=$PATH:/home/umcg-avich/.local/bin

echo "Run Humann2, WARNING: Check Humann2 configuration!!! (We currently use Uniref90 + Chocophlan db)"
echo "Starting pathways prediction using Humann2"

humann2 --input ${sampleKneadDataMergedFasta} \
--output ${intermediateDir} \
--taxonomic-profile ${sampleMetaphlanOutTxt} \
--threads 6 \
--o-log ${intermediateDir}/${externalSampleID}.full.humann2.log \
--remove-temp-output
