#!/usr/bin/env sh

[ -z "$run4D" ] && run4D=0

if [ $run4D -eq 1 ]; then
    SimOutDir=$SCRATCH/possum_example_4d/output
    LogDir=$SCRATCH/possum_example_4d/logs
else
    SimOutDir=$SCRATCH/possum_example/output
    LogDir=$SCRATCH/possum_example/logs
fi

inputDir=$HOME/Possum_Motion/possum_example

noutputs=$( find $SimOutDir -iname "possum_*" -type f | wc -l )
nexpected=32

if [ $noutputs -lt $nexpected ]; then
    echo "Number of possum outputs: $noutputs. Num expected: $nexpected."
    exit 1
fi

possum_sum -i ${SimOutDir}/possum_ -o ${SimOutDir}/possum_combined -n ${nexpected} -v 2>&1          |
   tee $LogDir/possum_sum-$(date +%F).log

signal2image -i ${SimOutDir}/possum_combined -a --homo -p $inputDir/example_pulse -o ${SimOutDir}/possum_example_simt2 |
   tee $LogDir/signal2image-$(date +%F).log
