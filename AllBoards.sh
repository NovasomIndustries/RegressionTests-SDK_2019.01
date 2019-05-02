#!/bin/bash
# just include one of them as we use only $SDK variable ...
. ./inc/M7board.inc
CFGS=`ls ${SDK}/Utils/Configurations/PClass_Buildroot_*`
for i in ${CFGS}; do
	FILE=`basename ${i}`
	./RegressionTests.sh P ${FILE}
done
CFGS=`ls ${SDK}/Utils/Configurations/U5Class_Buildroot_*`
for i in ${CFGS}; do
	FILE=`basename ${i}`
	./RegressionTests.sh U ${FILE}
done
CFGS=`ls ${SDK}/Utils/Configurations/M7Class_Buildroot_*`
for i in ${CFGS}; do
	FILE=`basename ${i}`
	./RegressionTests.sh M7 ${FILE}
done
