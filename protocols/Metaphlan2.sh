#MOLGENIS nodes=1 ppn=6 mem=4gb walltime=23:00:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string externalSampleID
#string project
#string intermediateDir
#string sampleKneadDataMergedFasta
#string MetaPhlAn2Index
#string sampleMetaphlanOutDir
#string sampleMetaphlanOutTxt
#string metaphlan2Version
#string project
#string group
#string tmpDirectory
#string logsDir

makeTmpDir "${sampleMetaphlanOutDir}"
tmpsampleMetaphlanOutDir=${MC_tmpFile}

mkdir -p "${sampleMetaphlanOutDir}"

#Load module
module load ${metaphlan2Version}

echo "Starting taxonomy classification using Metaphlan"
metaphlan2.py "${sampleKneadDataMergedFasta}" \
--input_type multifastq \
--mpa_pkl "${MetaPhlAn2Index}" \
--nproc 6 \
-o "${tmpsampleMetaphlanOutDir}"/"${externalSampleID}"_metaphlan.txt \
--tmp_dir "${tmpsampleMetaphlanOutDir}"

echo "mv ${tmpsampleMetaphlanOutDir}/${externalSampleID}_metaphlan.txt ${sampleMetaphlanOutTxt}"
mv "${tmpsampleMetaphlanOutDir}"/"${externalSampleID}"_metaphlan.txt "${sampleMetaphlanOutTxt}"
