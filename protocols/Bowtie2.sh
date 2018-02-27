#MOLGENIS nodes=1 ppn=1 mem=1gb walltime=05:00:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string externalSampleID
#string project
#string intermediateDir
#string DudesReference
#string sampleKneadDataOutPE1
#string sampleKneadDataOutPE2
#string sampleBowtie2Sam
#string Bowtie2Version

#Load module
module load ${Bowtie2Version}
module list

makeTmpDir ${sampleBowtie2Sam}
tmpsampleBowtie2Sam=${MC_tmpFile}

${EBROOTBOWTIE2}/bin/bowtie2 \
-x ${DudesReference} \
--no-unal \
--fast \
-p 6 \
-k 50 \
-1 ${sampleKneadDataOutPE1} \
-2 ${sampleKneadDataOutPE2} \
-S ${sampleBowtie2Sam}

mv ${tmpsampleBowtie2Sam} ${sampleBowtie2Sam}
