#MOLGENIS walltime=00:01:00 mem=1gb
#string tmpName
#string projectJobsDir
#string intermediateDir
#string project
#string logsDir

cd "${projectJobsDir}"


countShScripts=$(find *.sh | wc -l)
countFinishedFiles=$(find *.sh.finished | wc -l)

#remove 3, because there are 3 sh scripts that cannot have (already) a finished file, those are the following:
#
## CountAllFinishedFiles.sh, CopyToResultsDir.sh and submit.sh

countShScripts=$(($countShScripts-3))

rm -f "${projectJobsDir}/${taskId}_INCORRECT"

if [ "${countShScripts}" -eq "${countFinishedFiles}" ]
then    
        echo "all files are finished" > "${projectJobsDir}/${taskId}_CORRECT"
else
        echo "These files are not finished: " > "${projectJobsDir}/${taskId}_INCORRECT"
        for getSh in $(ls *.sh)
        do
                if [ ! -f "${getSh}.finished" ]
                then
                        echo "${getSh}" >> "${projectJobsDir}/${taskId}_INCORRECT"
                fi
        done
        trap - EXIT
        exit 0

fi
