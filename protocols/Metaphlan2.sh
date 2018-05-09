#MOLGENIS nodes=1 ppn=1 mem=4gb walltime=23:59:00

#Parameter mapping
#string seqType
#string externalSampleID
#string project
#string intermediateDir
#string sampleKneadDataMergedFastq
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
module load "${metaphlan2Version}"
module list

echo "Starting taxonomy classification using Metaphlan"
metaphlan2.py "${sampleKneadDataMergedFastq}" \
--input_type multifastq \
--mpa_pkl "${MetaPhlAn2Index}" \
--nproc 6 \
-o "${sampleMetaphlanOutDir}"/"${externalSampleID}"_metaphlan.txt \
--tmp_dir "${tmpsampleMetaphlanOutDir}"

echo "mv ${tmpsampleMetaphlanOutDir}/${externalSampleID}_metaphlan.txt ${sampleMetaphlanOutTxt}"
#mv "${tmpsampleMetaphlanOutDir}"/"${externalSampleID}"_metaphlan.txt "${sampleMetaphlanOutTxt}"
