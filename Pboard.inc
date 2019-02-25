SDK="/Devel/NOVAsdk2019.01"
UTILS_DIR="Utils"
FILESYSTEM_DIR="FileSystem"
KERNEL_DIR="Kernel"
DEPLOY_DIR="Deploy"
LOG_DIR="Logs"
DtbUserWorkArea_DIR="DtbUserWorkArea/PClass_bspf"

# Board specific parameters
BOARD_NAME="P"
REGTESTFS=RegressionTests${BOARD_NAME}
REGTESTLOG=${SDK}/${LOG_DIR}/RegressionTestsLogs${BOARD_NAME}
BOARD_DIR="${SDK}/${UTILS_DIR}/nxp"
SETUPFS_CMD="./SetupFs ${REGTESTFS} P PClass_Buildroot_Base.config"
KMAKE_CMD="./kmake linux-imx_4.1.15_1.2.0_ga SourceMe32"
MAKE_UBOOT_CMD="./umakeP"
BSPF_SAMPLE="Pregressiontests"
PARSER_CMD="${SDK}/Qt/NOVAembed/NOVAembed_P_Parser/bin/Debug/NOVAembed_P_Parser ${SDK}/${DtbUserWorkArea_DIR}/temp/SDL_${BSPF_SAMPLE}.bspf"
COMPILER_CMD="./user_dtb_compile SDL_${BSPF_SAMPLE} P"

