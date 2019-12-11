#!/bin/bash

# Change this directory to specify where to find the sources projects
SOURCES_DIR=`pwd`
echo "SOURCE DIR $SOURCES_DIR"

# list of the repository name
# IMPORTANT: Order is important for the buildAll.sh script

DEPOT_LIST=(
    "microservice-competitions" 
    "microservice-datacontroller" 
    "microservice-encounters" 
    "microservice-humans" 
    "microservice-mercato"
    "microservice-simulationcontroller"
    "microservice-user"
    "front"
    "tools"
)

DEPOT_LIST_NAME=(
    "Competitions"
    "Data Controller"
    "Encounters"
    "Humans"
    "Mercato"
    "Simulation Controller"
    "User"
    "Front"
    "Tools"
)

QJS_GIT_BASE_URL="https://gitlab.com/quijesuis"

DEPOT_LIST_SIZE=${#DEPOT_LIST[@]}
echo "Array size = "$DEPOT_LIST_SIZE

LOGS_DIR=${SOURCES_DIR}/logs
if [ ! -d "$LOGS_DIR" ]; then
    mkdir $LOGS_DIR
fi

# PARSE COMMAND LINE FOR ARGUMENTS
DO_TEST=0

# PARSE COMMAND LINE
for i in "$@"
do
    case $i in
        -t|--test)
        DO_TEST=1
        shift 
        ;;
        *)
            # unknown option
        ;;
    esac
done

echo "#############################################"
echo "## OPTIONS ARE :"
echo "## -t | --test to execute test"
echo "#############################################"
echo "DO TEST  = $DO_TEST"

MAVEN_OPTS="$MAVEN_OPTS"
if [ $DO_TEST -eq 1 ] ; then
   echo "Test will be executed"
else 
    MAVEN_OPTS="$MAVEN_OPTS -DskipTests=true -Dargument=\"-DskipTests=true\" "
fi

echo "MAVEN_OPTS:  $MAVEN_OPTS"

export MAVEN_OPTS
export DEPOT_LIST
export DEPOT_LIST_SIZE
export DEPOT_LIST_NAME
export SOURCES_DIR
export DO_TEST
export LOGS_DIR
