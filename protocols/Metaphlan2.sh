#MOLGENIS nodes=1 ppn=1 mem=1gb walltime=05:00:00

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

makeTmpDir ${sampleMetaphlanOutDir}
tmpsampleMetaphlanOutDir=${MC_tmpFile}

mkdir -p "${sampleMetaphlanOutDir}"

#Load module
module load MetaPhlAn/2.7.2-foss-2015b

echo "Starting taxonomy classification using Metaphlan"
metaphlan2.py ${sampleKneadDatafilteredFasta} \
--input_type multifastq \
--mpa_pkl ${MetaPhlAn2Index} \
--nproc 6 \
-o ${tmpsampleMetaphlanOutTxt} \
--tmp_dir ${intermediateDir}/

mv ${tmpsampleMetaphlanOutTxt} ${sampleMetaphlanOutTxt}
