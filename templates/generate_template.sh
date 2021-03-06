#!/bin/bash

#module load NGS_Microbiome
module load Molgenis-Compute/v17.08.1-Java-1.8.0_74
module list

EBROOTNGS_MICROBIOME="/home/umcg-gvdvries/github/NGS_Microbiome/"

ENVIRONMENT=$(hostname -s)

function showHelp() {
	#
	# Display commandline help on STDOUT.
	#
	cat <<EOH
===============================================================================================================
Script to copy (sync) data from a succesfully finished analysis project from tmp to prm storage.
Usage:
	$(basename $0) OPTIONS
Options:
	-h   Show this help.
	-s   samplesheet ()
	-g   group (default=basename of ../../../ )
	-f   filePrefix (default=basename of this directory)
	-r   runID (default=run01)
	-t   tmpDirectory (default=basename of ../../ )
	-w   workdir (default=/groups/\${group}/\${tmpDirectory})
===============================================================================================================
EOH
	trap - EXIT
	exit 0
}


while getopts "s:t:g:w:f:r:h" opt;
do
	case $opt in h)showHelp;; t)tmpDirectory="${OPTARG}";; g)group="${OPTARG}";; w)workDir="${OPTARG}";; f)filePrefix="${OPTARG}";; r)runID="${OPTARG}";; s)samplesheet="${OPTARG}"
	esac
done

if [[ -z "${tmpDirectory:-}" ]]; then tmpDirectory=$(basename $(cd ../../ && pwd )) ; fi ; echo "tmpDirectory=${tmpDirectory}"
if [[ -z "${group:-}" ]]; then group=$(basename $(cd ../../../ && pwd )) ; fi ; echo "group=${group}"
if [[ -z "${workDir:-}" ]]; then workDir="/groups/${group}/${tmpDirectory}" ; fi ; echo "workDir=${workDir}"
if [[ -z "${filePrefix:-}" ]]; then filePrefix=$(basename $(pwd)) ; fi ; echo "filePrefix=${filePrefix}"
if [[ -z "${runID:-}" ]]; then runID="run01" ; fi ; echo "runID=${runID}"
if [[ -z "${samplesheet:-}" ]]; then samplesheet=("${workDir}/generatedscripts/${filePrefix}/") ; fi ; echo "samplesheet=${samplesheet}"

genScripts="${workDir}/generatedscripts/${filePrefix}/"
samplesheet="${genScripts}/${filePrefix}.csv" ; mac2unix "${samplesheet}"

PROJECT=${filePrefix}

WORKFLOW=${EBROOTNGS_MICROBIOME}/workflow.csv

#exit 0
perl ${EBROOTNGS_MICROBIOME}/convertParametersGitToMolgenis.pl ${EBROOTNGS_MICROBIOME}/parameters.csv > \
${workDir}/generatedscripts/${PROJECT}/parameters.csv

perl ${EBROOTNGS_MICROBIOME}/convertParametersGitToMolgenis.pl ${EBROOTNGS_MICROBIOME}/parameters_${ENVIRONMENT}.csv > \
${workDir}/generatedscripts/${PROJECT}/parameters_${ENVIRONMENT}.csv

sh ${EBROOTMOLGENISMINCOMPUTE}/molgenis_compute.sh \
-p ${workDir}/generatedscripts/${PROJECT}/parameters.csv \
-p ${workDir}/generatedscripts/${PROJECT}/parameters_${ENVIRONMENT}.csv \
-p ${workDir}/generatedscripts/${PROJECT}/${PROJECT}.csv \
-w ${EBROOTNGS_MICROBIOME}/workflow.csv \
-rundir ${workDir}/projects/${PROJECT}/ \
--runid ${runID} \
--weave \
--generate 
