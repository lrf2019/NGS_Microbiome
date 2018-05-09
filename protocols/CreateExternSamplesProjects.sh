#MOLGENIS walltime=00:01:00 mem=1gb nodes=1 ppn=1

#Parameter mapping
#list fastq1
#list fastq2
#string project
#string intermediateDir
#string projectRawtmpDataDir
#string projectPrefix
#string projectJobsDir
#string projectResultsDir
#string projectQcDir
#list seqType
#list externalSampleID
#list fastq1
#list fastq2
#string project
#string group
#string tmpDirectory
#string logsDir
#string samplesheet

#
# Create project dirs.
#
mkdir -p "${projectRawtmpDataDir}"
mkdir -p "${projectJobsDir}"
mkdir -p "${intermediateDir}"
mkdir -p "${projectResultsDir}"
mkdir -p "${projectQcDir}"

ROCKETPOINT=$(pwd)

cp "${samplesheet}" "${projectJobsDir}"
cd "${projectRawtmpDataDir}"

#
# Create symlinks to the raw data required to analyse this project
#
# For each sequence file (could be multiple per sample):
#


n_elements=${externalSampleID[@]}
max_index=${#externalSampleID[@]}-1
for ((samplenumber = 0; samplenumber <= max_index; samplenumber++))
do
	if [[ ${seqType[samplenumber]} == "SR" ]]
	then
		ln -sf ${fastq1[samplenumber]} ${projectRawtmpDataDir}/${externalSampleID[samplenumber]}_1.fq.gz
		ln -sf ${fastq1[samplenumber]}.md5 ${projectRawtmpDataDir}/${externalSampleID[samplenumber]}_1.fq.gz.md5
	elif [[ ${seqType[samplenumber]} == "PE" ]]
	then
		ln -sf ${fastq1[samplenumber]} ${projectRawtmpDataDir}/${externalSampleID[samplenumber]}_1.fq.gz
		ln -sf ${fastq2[samplenumber]} ${projectRawtmpDataDir}/${externalSampleID[samplenumber]}_2.fq.gz
		ln -sf ${fastq1[samplenumber]}.md5 ${projectRawtmpDataDir}/${externalSampleID[samplenumber]}_1.fq.gz.md5
		ln -sf ${fastq2[samplenumber]}.md5 ${projectRawtmpDataDir}/${externalSampleID[samplenumber]}_2.fq.gz.md5
	fi
done

cd $ROCKETPOINT

