#!/bin/bash

 # Clone every repository 

. configurationQuiJeSuis.sh

echo ${DEPOT_LIST}
for (( i=0; i<${DEPOT_LIST_SIZE}; i++ ));
do 
    depot=${DEPOT_LIST[i]}
    echo "Cloning ${depot}" 
    git clone $QJS_GIT_BASE_URL/$depot.git $SOURCES_DIR/$depot
    echo
done

echo "End"