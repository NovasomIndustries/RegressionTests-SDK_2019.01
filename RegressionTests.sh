#!/bin/bash
if [ -z $1 ]; then
	echo "Choose board : P , U or M7"
	exit
fi

[ "$1" == "P" ] && . ./inc/Pboard.inc
[ "$1" == "U" ] && . ./inc/Uboard.inc
[ "$1" == "M7" ] && . ./inc/M7board.inc

HERE=`pwd`

NOW=`date +%Y-%d-%m_%H-%M`

cd ${SDK}/Utils
rm -rf ${SDK}/${FILESYSTEM_DIR}/${REGTESTFS}
echo "Regression tests started at `date +%Y-%d-%m.%H:%M`" >> ${REGTESTLOG}-${NOW}
if [ -z $2 ]; then
	SETUPFS_CMD="./SetupFs ${REGTESTFS} $1 ${DEFAULTCONFIG}"
	FSCONFIG=${DEFAULTCONFIG}
else
	SETUPFS_CMD="./SetupFs ${REGTESTFS} $1 $2"
	FSCONFIG=$2
fi
#echo "**** in  ./RegressionTests.sh **** "
#echo $2
#echo ${SETUPFS_CMD}
#echo "**** out ./RegressionTests.sh **** "
#exit

echo "Testing ${BOARD_NAME} board with ${FSCONFIG} at `date +%Y-%d-%m.%H:%M`" >> ${REGTESTLOG}-${NOW}
./${SETUPFS_CMD}
if ! [ "$?" == "0" ]; then
	echo "	Filesystem Generation : FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "	Filesystem Generation : Pass" >> ${REGTESTLOG}-${NOW}
	cd ${SDK}/${FILESYSTEM_DIR}/${REGTESTFS}
	make
	if ! [ "$?" == "0" ]; then
		echo "	Filesystem Compilation : FAIL" >> ${REGTESTLOG}-${NOW}
		mv ${SDK}/${FILESYSTEM_DIR}/${REGTESTFS} ${SDK}/${FILESYSTEM_DIR}/${REGTESTFS}_FAILED
	else
		echo "	Filesystem Compilation : Pass" >> ${REGTESTLOG}-${NOW}
	fi
fi
cd ${BOARD_DIR}
${KMAKE_CMD}
if ! [ "$?" == "0" ]; then
	echo "	Kernel : FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "	Kernel : Pass" >> ${REGTESTLOG}-${NOW}
fi
cd ${HERE}
cp ${BSPF_SAMPLE}.bspf ${SDK}/${DtbUserWorkArea_DIR}/.
cd ${SDK}/${UTILS_DIR}
${PARSER_CMD}
${COMPILER_CMD}
if ! [ "$?" == "0" ]; then
	echo "	Dtb Parser : FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "	Dtb Parser : Pass" >> ${REGTESTLOG}-${NOW}
fi
if ! [ "$?" == "0" ]; then
	echo "	DTB Compiler : FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "	DTB Compiler : Pass" >> ${REGTESTLOG}-${NOW}
fi
cd ${BOARD_DIR}
${MAKE_UBOOT_CMD}
if ! [ "$?" == "0" ]; then
        echo "	u-boot compile : FAIL" >> ${REGTESTLOG}-${NOW}
else
        echo "	u-boot compile : Pass" >> ${REGTESTLOG}-${NOW}
fi
echo "Regression tests finished at `date +%Y-%d-%m.%H:%M`" >> ${REGTESTLOG}-${NOW}

