#MOLGENIS nodes=1 ppn=6 mem=40gb walltime=23:50:00

#Parameter mapping
#string seqType
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

makeTmpDir "${sampleKneadDataOut}"
tmpsampleKneadDataOut=${MC_tmpFile}

#Load module
module load ${picardVersion}
module load ${Bowtie2Version}
module load ${humann2Version}

echo "Run Humann2, WARNING: Check Humann2 configuration!!! (We currently use Uniref90 + Chocophlan db)"
echo "Starting pathways prediction using Humann2"

humann2 --input ${sampleKneadDataMergedFasta} \
--output "${intermediateDir}" \
--taxonomic-profile "${sampleMetaphlanOutTxt}" \
--diamond ${EBROOTDIAMOND}/diamond \
--nucleotide-database "/apps/data/humann2/chocophlan/" \
--protein-database "/apps/data/humann2/uniref/" \
--threads 6 \
--o-log "${intermediateDir}/${externalSampleID}.full.humann2.log" \
--remove-temp-output
