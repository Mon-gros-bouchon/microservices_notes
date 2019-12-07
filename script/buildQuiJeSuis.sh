#!/bin/bash

# Build all repository backend
# Every build results is stored in an individual log file.
. configurationQuiJeSuis.sh

# Global mvn clean install  results
GLOBAL_MVN_RES=0

declare -a failed

echo""

for (( i=0; i<${DEPOT_LIST_SIZE}; i++ ));
do
    depot=${DEPOT_LIST[i]}
    depot_name=${DEPOT_LIST_NAME[i]}
    cd ${SOURCES_DIR}/${depot}
    branch=`git branch | grep "*"`
    echo "=============================="
    echo -e "Beginning build of \e[36m$depot_name\e[0m on branch \e[33m${branch/* /}\e[0m"
    echo "=============================="
    
	cd ${SOURCES_DIR}/$depot
    

    logfile=${LOGS_DIR}/maven-$depot-build-results.log
    mvn clean install  > $logfile
    
    results=$?
    GLOBAL_MVN_RES=$((GLOBAL_MVN_RES+results))
    
    echo "See log in $logfile"
    
    if [ $results -eq 0 ] ; then
        echo -e "[INFO] Build $depot \e[32mSUCCESSFUL\e[0m"
    else
	failed=( "${failed[@]}" $depot ) 
        echo -e "[ERROR] Build $depot \e[31mFAILED\e[0m"
    fi
    
    cd ${SOURCES_DIR}
    echo ""
done

echo "End"

if [ $GLOBAL_MVN_RES -eq 0 ] ; then
    echo -e "\e[32mEVERYTHING IS OK\e[0m"
else
    echo -e "\e[31mERROR WERE RAISED\e[0m"
    echo "The following repositories raised errors:"
    for (( i=0; i<${#failed[@]}; i++ ));
    do
        echo "    ${failed[i]}"
    done
fi
exit $GLOBAL_MVN_RES

