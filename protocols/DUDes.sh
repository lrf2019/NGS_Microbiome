#MOLGENIS nodes=1 ppn=1 mem=1gb walltime=05:00:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string externalSampleID
#string project
#string intermediateDir
#string dudesVersion
#string sampleBowtie2Sam
#string DudesReferenceNpz
#string sampleDudesOut

makeTmpDir ${sampleDudesOut}
tmpsampleDudesOut=${MC_tmpFile}

#Load module
module load ${dudesVersion}

python3 ${EBROORDUDES}/DUDes.py \
-s ${sampleBowtie2Sam} \
-d ${DudesReferenceNpz} \
-t 6 \
-m 50 \
-a 0.0005 \
-l strain \
-o ${tmpsampleDudesOut}

mv ${tmpsampleDudesOut}/* ${intermediateDir}
