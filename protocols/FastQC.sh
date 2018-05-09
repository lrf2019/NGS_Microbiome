#MOLGENIS nodes=1 ppn=1 mem=1gb walltime=01:00:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string externalSampleID
#string fastqcVersion
#string project
#string intermediateDir
#string project
#string group
#string tmpDirectory
#string logsDir

#Load module
module load ${fastqcVersion}
module list

makeTmpDir ${intermediateDir}
tmpintermediateDir=${MC_tmpFile}

#If paired-end do fastqc for both ends, else only for one
if [ ${seqType} == "PE" ]
then
	# end1 & end2
	fastqc ${fastq1} \
	${fastq2} \
	-o ${tmpintermediateDir}

	echo -e "\nFastQC finished succesfull. Moving temp files to final.\n\n"
	mv -f ${tmpintermediateDir}/* ${intermediateDir}
else
	fastqc ${fastq1} \
	-o ${tmpintermediateDir}

	echo -e "\nFastQC finished succesfull. Moving temp files to final.\n\n"
	mv -f ${tmpintermediateDir}/* ${intermediateDir}
fi
