#MOLGENIS nodes=1 ppn=1 mem2gb walltime=05:59:00

#Parameter mapping
#string seqType
#string sampleRawtmpDataR1
#string sampleRawtmpDataR2
#string bowtie2Reference
#string externalSampleID
#string project
#string intermediateDir
#string sampleKneadDataOut
#string kneaddataVersion
#string Bowtie2Version
#string fastqcVersion
#string project
#string group
#string tmpDirectory
#string logsDir

#Load module
module load ${kneaddataVersion}
module load ${Bowtie2Version}
module load ${fastqcVersion}
module list

echo "Remove reads mapping the human genome and quality filtering with Kneaddata:"

makeTmpDir ${sampleKneadDataOut}
tmpsampleKneadDataOut=${MC_tmpFile}

mkdir -p "${sampleKneadDataOut}"

kneaddata \
--input "${sampleRawtmpDataR1}" \
--input "${sampleRawtmpDataR2}" \
-t 6 \
-p 7 \
-db "${bowtie2Reference}" \
--bowtie2 ${EBROOTBOWTIE2}/bin/ \
--fastqc "${EBROOTFASTQC}" \
--output "${tmpsampleKneadDataOut}/" \
--log "${tmpsampleKneadDataOut}/"${externalSampleID}".log"

cat ${tmpsampleKneadDataOut}/${externalSampleID}_1_kneaddata_paired_1.fastq ${tmpsampleKneadDataOut}/${externalSampleID}_1_kneaddata_paired_2.fastq > ${tmpsampleKneadDataOut}/${externalSampleID}.kneaddata.merged.fastq
echo "mv ${tmpsampleKneadDataOut}/${externalSampleID}.kneaddata.merged.fastq ${sampleKneadDataOut}/${externalSampleID}.kneaddata.merged.fastq"
echo "mv ${tmpsampleKneadDataOut}/${externalSampleID}_1_kneaddata_paired_1.fastq ${sampleKneadDataOut}"
echo "mv ${tmpsampleKneadDataOut}/${externalSampleID}_1_kneaddata_paired_2.fastq ${sampleKneadDataOut}"
echo "mv ${tmpsampleKneadDataOut}/${externalSampleID}.log ${sampleKneadDataOut}"
mv "${tmpsampleKneadDataOut}"/"${externalSampleID}".kneaddata.merged.fastq "${sampleKneadDataOut}"/"${externalSampleID}".kneaddata.merged.fastq
mv "${tmpsampleKneadDataOut}"/"${externalSampleID}"_1_kneaddata_paired_1.fastq "${sampleKneadDataOut}"
mv "${tmpsampleKneadDataOut}"/"${externalSampleID}"_1_kneaddata_paired_2.fastq "${sampleKneadDataOut}"
mv "${tmpsampleKneadDataOut}"/"${externalSampleID}".log "${sampleKneadDataOut}"
