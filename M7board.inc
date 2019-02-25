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
