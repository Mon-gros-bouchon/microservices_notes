#!/bin/bash

# Pull each local repository

. configurationQuiJeSuis.sh

echo ${DEPOT_LIST}
for (( i=0; i<${DEPOT_LIST_SIZE}; i++ ));
do 
    depot=${DEPOT_LIST[i]}
    echo "=================================="
    echo -e "Pulling \e[36m${DEPOT_LIST_NAME[i]}\e[0m"
    echo "=================================="
    cd ${SOURCES_DIR}/${depot}
    br=`git branch | grep "*"`
    echo -e "Current branch: \e[32m${br/* /}\e[0m"
    git pull
    cd ${SOURCES_DIR}
    echo
done

echo "End"