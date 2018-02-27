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


#Load module
module load kneaddata/v0.5.1-foss-2015b-Python-2.7.11
module load Bowtie2/2.2.9-foss-2015b

echo "Remove reads mapping the human genome and quality filtering with Kneaddata:"

makeTmpDir ${sampleKneadDataOut}
tmpsampleKneadDataOut=${MC_tmpFile}

mkdir -p "${sampleKneadDataOut}"

kneaddata \
--input ${fastq1} \
--input ${fastq2} \
-t 6 \
-p 7 \
-db ${bowtie2Reference} \
--bowtie2 ${EBROOTBOWTIE2}/bin/ \
--output ${tmpsampleKneadDataOut}/ \
--log ${sampleKneadDataOut}/${externalSampleID}.log

cat ${tmpsampleKneadDataOut}/${externalSampleID}_1_kneaddata_paired_1.fastq > ${sampleKneadDataOut}/kneaddata_${externalSampleID}/clean_reads/${externalSampleID}.kneaddata_merged.fastq
cat ${tmpsampleKneadDataOut}/kneaddata_${externalSampleID}${externalSampleID}_2_kneaddata_paired_2.fastq >> ${sampleKneadDataOut}/kneaddata_${externalSampleID}/clean_reads/${externalSampleID}.kneaddata_merged.fastq
mv ${tmpsampleKneadDataOut}/${externalSampleID}_1_kneaddata_paired_1.fastq ${sampleKneadDataOut}
mv ${tmpsampleKneadDataOut}/${externalSampleID}_1_kneaddata_paired_1.fastq ${sampleKneadDataOut}
mv ${tmpsampleKneadDataOut}/${externalSampleID}.kneaddata_merged.fastq ${sampleKneadDataOut}
