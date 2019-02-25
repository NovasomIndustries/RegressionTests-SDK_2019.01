SDK="/Devel/NOVAsdk2019.01"
UTILS_DIR="Utils"
FILESYSTEM_DIR="FileSystem"
KERNEL_DIR="Kernel"
DEPLOY_DIR="Deploy"
LOG_DIR="Logs"
DtbUserWorkArea_DIR="DtbUserWorkArea/UClass_bspf"

# Board specific parameters
BOARD_NAME="U"
REGTESTFS=RegressionTests${BOARD_NAME}
REGTESTLOG=${SDK}/${LOG_DIR}/RegressionTestsLogs${BOARD_NAME}
BOARD_DIR="${SDK}/${UTILS_DIR}/nxp"
SETUPFS_CMD="./SetupFs ${REGTESTFS} U5 U5Class_Buildroot_Base.config"
KMAKE_CMD="./kmake linux-imx_4.1.43 SourceMe32"
MAKE_UBOOT_CMD="./umakeU"
BSPF_SAMPLE="bspf/Uregressiontests"
PARSER_CMD="${SDK}/Qt/NOVAembed/NOVAembed_U_Parser/bin/Debug/NOVAembed_U_Parser ${SDK}/${DtbUserWorkArea_DIR}/${BSPF_SAMPLE}.bspf"
COMPILER_CMD="./user_dtb_compile ${BSPF_SAMPLE} U"
