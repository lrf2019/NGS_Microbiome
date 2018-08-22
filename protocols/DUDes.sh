#MOLGENIS nodes=1 ppn=1 mem=6gb walltime=07:00:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string externalSampleID
#string project
#string intermediateDir
#string dudesVersion
#string sampleBowtie2Sam
#string dudesReferenceNpz
#string sampleDudesOut
#string project
#string group
#string tmpDirectory
#string logsDir

makeTmpDir "${sampleDudesOut}"
tmpsampleDudesOut=${MC_tmpFile}

#Load module
module load "${dudesVersion}"

python3 ${EBROOTDUDES}/DUDes.py \
-s "${sampleBowtie2Sam}" \
-d "${dudesReferenceNpz}" \
-t 6 \
-m 50 \
-a 0.0005 \
-l strain \
-o "${tmpsampleDudesOut}"

mv "${tmpsampleDudesOut}"* "${intermediateDir}"
