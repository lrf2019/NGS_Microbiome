#MOLGENIS nodes=1 ppn=4 mem=4gb walltime=05:00:00

#Parameter mapping
#string seqType
#string fastq1
#string fastq2
#string externalSampleID
#string project
#string intermediateDir
#string project
#string group
#string tmpDirectory
#string logsDir

#Echo parameter values
echo "seqType: ${seqType}"
echo "peEnd1BarcodeFqGz: ${peEnd1BarcodeFqGz}"
echo "peEnd2BarcodeFqGz: ${peEnd2BarcodeFqGz}"
echo "srBarcodeFqGz: ${srBarcodeFqGz}"
echo "intermediateDir: ${intermediateDir}"

#Load module
module load ${BBMapVersion}
module list


#If paired-end do cutadapt for both ends, else only for one
if [ ${seqType} == "PE" ]
then

	${EBROOTBBMAP}/bbduk.sh -Xmx3g \
	in1=${fastq1} \
	in2=${fastq2} \
	out1=${fastq1}.tmp \
	out2=${fastq2}.tmp \
	ref=${EBROOTBBMAP}/resources/polyA.fa.gz,${EBROOTBBMAP}/resources/truseq.fa.gz \
	overwrite=true \
        k=13 \
	ktrim=l \
        qtrim=rl \
        trimq=14 \
        minlength=20 > ${intermediateDir}/${externalSampleID}.trimming.log 2>&1
	#\forcetrimleft=11

	gzip ${fastq1}.tmp
	gzip ${fastq2}.tmp
	mv ${fastq1}.tmp.gz ${peEnd1BarcodeFqGz}
	mv ${fastq2}.tmp.gz ${peEnd2BarcodeFqGz}

	echo -e "\nBBMap bbduk.sh finished succesfull. Moving temp files to final.\n\n"

elif [ ${seqType} == "SR" ]
then
	${EBROOTBBMAP}/bbduk.sh -Xmx3g \
	in=${fastq1} \
	out=${fastq1}.tmp \
	ref=${EBROOTBBMAP}/resources/polyA.fa.gz,${EBROOTBBMAP}/resources/truseq.fa.gz \
	overwrite=true \
        k=13 \
	ktrim=l \
        qtrim=rl \
        trimq=14 \
        minlength=20 > ${intermediateDir}/${externalSampleID}.trimming.log 2>&1
	#forcetrimleft=11

	gzip ${fastq1}.tmp
	mv ${fastq1}.tmp.gz ${fastq1}

	echo -e "\nBBMap bbduk.sh finished succesfull. Moving temp files to final.\n\n"
fi
