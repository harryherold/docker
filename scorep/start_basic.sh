
BT_DIR=/home/cherold/scorep/tests
SCOREP_DIR=/home/cherold/scorep/record_offsets

docker run  --user $(id -u)  -v $SCOREP_DIR:/opt/scorep -v $BT_DIR:/tests -it scorep_basic

