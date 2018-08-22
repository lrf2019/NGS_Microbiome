#MOLGENIS nodes=1 ppn=6 mem=40gb walltime=53:50:00

#Parameter mapping
#string seqType
#string bowtie2Reference
#string externalSampleID
#string project
#string intermediateDir
#string sampleKneadDataOut
#string sampleKneadDataMergedFastq
#string kneaddataVersion
#string bowtie2Version
#string picardVersion
#string bowtie2Version
#string humann2Version
#string sampleMetaphlanOutTxt
#string project
#string group
#string tmpDirectory
#string logsDir
#string chocophlanDB
#string unirefDB

makeTmpDir "${sampleKneadDataOut}"
tmpsampleKneadDataOut=${MC_tmpFile}

#Load module
module load "${picardVersion}"
module load "${bowtie2Version}"
module load "${humann2Version}"

echo "Run Humann2, WARNING: Check Humann2 configuration!!! (We currently use Uniref90 + Chocophlan db)"
echo "Starting pathways prediction using Humann2"

humann2 --input "${sampleKneadDataMergedFastq}" \
--output "${intermediateDir}" \
--taxonomic-profile "${sampleMetaphlanOutTxt}" \
--diamond ${EBROOTDIAMOND}/diamond \
--nucleotide-database "${chocophlanDB}" \
--protein-database "${unirefDB}" \
--threads 6 \
--o-log "${intermediateDir}/${externalSampleID}.full.humann2.log" \
--remove-temp-output
