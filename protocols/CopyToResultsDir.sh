#MOLGENIS walltime=05:59:00 nodes=1 cores=1 mem=1gb

#string projectResultsDir
#string projectJobsDir
#string projectLogsDir
#string intermediateDir
#list externalSampleID
#string project
#string logsDir

umask 0007

#Function to check if array contains value
array_contains () {
    local array="$1[@]"
    local seeking="${2}"
    local in=1
    for element in "${!array-}"; do
        if [[ "${element}" == "${seeking}" ]]; then
            in=0
            break
        fi
    done
    return "${in}"
}


# Make result directories
mkdir -p "${projectResultsDir}/FastQC"
mkdir -p "${projectResultsDir}/Kneaddata"
mkdir -p "${projectResultsDir}/Metaphlan2"
mkdir -p "${projectResultsDir}/qc"
mkdir -p "${projectResultsDir}/DUDes"
mkdir -p "${projectResultsDir}/Humann2"

UNIQUESAMPLES=()
for samples in "${externalSampleID[@]}"
do
	array_contains UNIQUESAMPLES "$samples" || UNIQUESAMPLES+=("$samples")    # If bamFile does not exist in array add it
done

EXTERN=${#UNIQUESAMPLES[@]}

# Copy project csv file to project results directory
printf "Copied project csv file to project results directory.."
rsync -a "${projectJobsDir}/${project}.csv" "${projectResultsDir}"
printf ".. finished (1/11)\n"

# Copy fastQC output to results directory
printf "Copying fastQC output to results directory.."
rsync -a "${intermediateDir}/"*_fastqc.zip "${projectResultsDir}/FastQC/"
rsync -a "${intermediateDir}/"*_fastqc.html "${projectResultsDir}/FastQC/"
printf ".. finished (2/11)\n"


##Copy Kneaddata results
printf "Copying Kneaddata output to results directory.."
for sample in "${UNIQUESAMPLES[@]}"
do
	if [ -f "${intermediateDir}/kneaddata_${sample}/${sample}.log" ]
	then
		rsync -a "${intermediateDir}/kneaddata_${sample}/${sample}.log" "${projectResultsDir}/Kneaddata/"
	fi
done
printf ".. finished (3/11)\n"


##Copy Metaphlan2 results
printf "Copying Metaphlan2 output to results directory.."
for sample in "${UNIQUESAMPLES[@]}"
do
	if [ -f "${intermediateDir}/metaphlan_${sample}//${sample}_metaphlan.txt" ]
	then
		rsync -a "${intermediateDir}/metaphlan_${sample}//${sample}_metaphlan.txt" "${projectResultsDir}/Metaphlan2/"
	fi
done
printf ".. finished (4/11)\n"

##Copy DUDes results
printf "Copying DUDes output to results directory.."
for sample in "${UNIQUESAMPLES[@]}"
do
        if [ -f "${intermediateDir}/${sample}_Dudes_strains.out" ]
        then
		rsync -a "${intermediateDir}/${sample}_Dudes.out" "${projectResultsDir}/DUDes/"
		rsync -a "${intermediateDir}/${sample}_Dudes_strains.out" "${projectResultsDir}/DUDes/"
        fi
done
printf ".. finished (5/11)\n"

##Copy Bowtie2 results
printf "Copying Bowtie2 output to results directory.."
for sample in "${UNIQUESAMPLES[@]}"
do
        if [ -f "${intermediateDir}/${sample}.bowtie2.log" ]
        then
                rsync -a "${intermediateDir}/${sample}.bowtie2.log" "${projectResultsDir}/qc/"
        fi
done
printf ".. finished (6/11)\n"

##Copy Humann2 results
printf "Copying Humann2 output to results directory.."
for sample in "${UNIQUESAMPLES[@]}"
do
	if [ -f "${intermediateDir}/${sample}.full.humann2.log" ]
	then
		rsync -a "${intermediateDir}/${sample}.full.humann2.log" "${projectResultsDir}/Humann2/"
		rsync -a "${intermediateDir}/${sample}.kneaddata.merged_genefamilies.tsv" "${projectResultsDir}/Humann2/${sample}.humann2.merged_genefamilies.tsv"
		rsync -a "${intermediateDir}/${sample}.kneaddata.merged_pathabundance.tsv" "${projectResultsDir}/Humann2/${sample}.humann2.merged_pathabundance.tsv"
		rsync -a "${intermediateDir}/${sample}.kneaddata.merged_pathcoverage.tsv" "${projectResultsDir}/Humann2/${sample}.humann2.merged_pathcoverage.tsv"
        fi
done
printf ".. finished (7/11)\n"

##Runtime statistics to resultsDir
printf "Runtime statistics to results directory.."

ml cluster-utils
cd ${projectJobsDir}
sjeff -o . > ${projectResultsDir}/runtimes.log
cd -
printf ".. finished (8/11)\n"
