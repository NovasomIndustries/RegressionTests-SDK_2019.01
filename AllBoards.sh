#!/bin/bash
CFGS=`ls /Devel/NOVAsdk2019.01/Utils/Configurations/PClass_Buildroot_*`
for i in ${CFGS}; do
	FILE=`basename ${i}`
	./RegressionTests.sh P ${FILE}
done
CFGS=`ls /Devel/NOVAsdk2019.01/Utils/Configurations/U5Class_Buildroot_*`
for i in ${CFGS}; do
	FILE=`basename ${i}`
	./RegressionTests.sh U ${FILE}
done
CFGS=`ls /Devel/NOVAsdk2019.01/Utils/Configurations/M7Class_Buildroot_*`
for i in ${CFGS}; do
	FILE=`basename ${i}`
	./RegressionTests.sh M7 ${FILE}
done
