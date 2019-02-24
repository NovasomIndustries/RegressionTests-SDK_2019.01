#!/bin/sh
SDK="/Devel/NOVAsdk2019.01"
UTILS_DIR="Utils"
FILESYSTEM_DIR="FileSystem"
KERNEL_DIR="Kernel"
DEPLOY_DIR="Deploy"
LOG_DIR="Logs"
DtbUserWorkArea_DIR="DtbUserWorkArea/M7Class_bspf"

# Board specific parameters
BOARD_NAME="M7"
REGTESTFS=RegressionTests${BOARD_NAME}
REGTESTLOG=${SDK}/${LOG_DIR}/RegressionTestsLogs${BOARD_NAME}
BOARD_DIR="${SDK}/${UTILS_DIR}/rock"
SETUPFS_CMD="./SetupFs ${REGTESTFS} M7 M7Class_Buildroot_Base.config"
KMAKE_CMD="./kmake linux-4.4.167_M7 SourceMe64"
MAKE_UBOOT_CMD="./umakeM7"
BSPF_SAMPLE="M7regressiontests"
PARSER_CMD="${SDK}/Qt/NOVAembed/NOVAembed_M7_Parser/bin/Debug/NOVAembed_M7_Parser ${SDK}/${DtbUserWorkArea_DIR}/${BSPF_SAMPLE}.bspf"
COMPILER_CMD="./user_dtb_compile ${BSPF_SAMPLE} M7"


# END of Board specific parameters
HERE=`pwd`

NOW=`date +%Y-%d-%m_%H-%M`

cd ${SDK}/Utils
rm -rf ${SDK}/${FILESYSTEM_DIR}/${REGTESTFS}
echo "Regression tests started at ${NOW}" > ${REGTESTLOG}-${NOW}
echo "Testing ${BOARD_NAME} board at `date +%Y-%d-%m.%H:%M`" >> ${REGTESTLOG}-${NOW}
echo "	Filesystem" >> ${REGTESTLOG}-${NOW}
echo "		Executing command ${SETUPFS_CMD}" >> ${REGTESTLOG}-${NOW}
./${SETUPFS_CMD}
if ! [ "$?" == "0" ]; then
	echo "		${SETUPFS_CMD} FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "		${SETUPFS_CMD} Passed" >> ${REGTESTLOG}-${NOW}
fi
cd ${SDK}/${FILESYSTEM_DIR}/${REGTESTFS}
echo "		Executing command make" >> ${REGTESTLOG}-${NOW}
make
if ! [ "$?" == "0" ]; then
	echo "		make on ${REGTESTFS} FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "		make on ${REGTESTFS} Passed" >> ${REGTESTLOG}-${NOW}
fi
echo "	Filesystem basic test finished at `date +%Y-%d-%m.%H:%M`" >> ${REGTESTLOG}-${NOW}
echo "	Kernel" >> ${REGTESTLOG}-${NOW}
cd ${BOARD_DIR}
${KMAKE_CMD}
echo "		Executing command ${KMAKE_CMD}" >> ${REGTESTLOG}-${NOW}
if ! [ "$?" == "0" ]; then
	echo "		${KMAKE_CMD} FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "		${KMAKE_CMD} Passed" >> ${REGTESTLOG}-${NOW}
fi
echo "	Kernel basic test finished at `date +%Y-%d-%m.%H:%M`" >> ${REGTESTLOG}-${NOW}
echo "	Bspf" >> ${REGTESTLOG}-${NOW}
cd ${HERE}
cp ${BSPF_SAMPLE}.bspf ${SDK}/${DtbUserWorkArea_DIR}/.
cd ${SDK}/${UTILS_DIR}
echo "		Executing command ${PARSER_CMD}" >> ${REGTESTLOG}-${NOW}
${PARSER_CMD}
if ! [ "$?" == "0" ]; then
	echo "		${PARSER_CMD} FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "		${PARSER_CMD} Passed" >> ${REGTESTLOG}-${NOW}
fi
echo "		Executing command ${COMPILER_CMD}" >> ${REGTESTLOG}-${NOW}
${COMPILER_CMD}
if ! [ "$?" == "0" ]; then
	echo "		${COMPILER_CMD} FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "		${COMPILER_CMD} Passed" >> ${REGTESTLOG}-${NOW}
fi

echo "	Bspf basic test finished at `date +%Y-%d-%m.%H:%M`" >> ${REGTESTLOG}-${NOW}

echo "	u-boot" >> ${REGTESTLOG}-${NOW}
echo "		Executing command ${MAKE_UBOOT_CMD}" >> ${REGTESTLOG}-${NOW}
cd ${BOARD_DIR}
${MAKE_UBOOT_CMD}
if ! [ "$?" == "0" ]; then
	echo "		${MAKE_UBOOT_CMD} FAIL" >> ${REGTESTLOG}-${NOW}
else
	echo "		${MAKE_UBOOT_CMD} Passed" >> ${REGTESTLOG}-${NOW}
fi
echo "	u-boot basic test finished at `date +%Y-%d-%m.%H:%M`" >> ${REGTESTLOG}-${NOW}
echo "Regression tests finished at `date +%Y-%d-%m.%H:%M`" >> ${REGTESTLOG}-${NOW}

