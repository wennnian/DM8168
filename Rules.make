# Copyright Texas Instruments
ifeq ($(dvr_rdk_PATH), )

# Board type can be one of the following
#	1. DM816X_UD_DVR
#	2. DM816X_TI_EVM
#	3. DM814X_TI_EVM
#	4. DM810X_TI_EVM
#	5. DM810X_UD_DVR
#	6. DM810X_BCH_120_DVR

ifeq ($(DVR_RDK_BOARD_TYPE ), )
  DVR_RDK_BOARD_TYPE := DM816X_TI_EVM
endif

# Default build environment, windows or linux
ifeq ($(OS), )
  OS := Linux
endif

dvr_rdk_RELPATH = dvr_rdk

ifeq ($(OS),Windows_NT)
  dvr_rdk_BASE     := $(CURDIR)/..
  TI_SW_ROOT       := D:/ti_software
endif

ifeq ($(OS),Linux)
# dvr_rdk_BASE     := $(shell pwd)/..
  dvr_rdk_BASE     := /home/wen/dvrrdk/DVRRDK_04.01.00.02
  TI_SW_ROOT       := $(dvr_rdk_BASE)/ti_tools
endif

dvr_rdk_PATH     := $(dvr_rdk_BASE)/$(dvr_rdk_RELPATH)

# Code gen tools
CODEGEN_PATH_A8  := $(TI_SW_ROOT)/cgt_a8/arago/linux-devkit
CODEGEN_PATH_DSP := $(TI_SW_ROOT)/cgt_dsp/cgt6x_7_3_5/
CODEGEN_PATH_M3  := $(TI_SW_ROOT)/cgt_m3/cgt470_4_9_5/
CODEGEN_PREFIX   := $(CODEGEN_PATH_A8)/bin/arm-arago-linux-gnueabi-
CSTOOL_PREFIX    := arm-arago-linux-gnueabi-
ifeq ($(OS),Windows_NT)
CODEGEN_PREFIX   := $(TI_SW_ROOT)/cgt_a8/arm-2009q1/bin/arm-none-linux-gnueabi-
CSTOOL_PREFIX    := arm-none-linux-gnueabi-
endif


# BIOS side tools
xdc_PATH         := $(TI_SW_ROOT)/xdc/xdctools_3_23_03_53
bios_PATH        := $(TI_SW_ROOT)/bios/bios_6_33_05_46
ipc_PATH         := $(TI_SW_ROOT)/ipc/ipc_1_24_03_32
fc_PATH          := $(TI_SW_ROOT)/framework_components/framework_components_3_22_02_08_patched
edma3lld_PATH    := $(TI_SW_ROOT)/edma3lld/edma3_lld_02_11_06_01
iss_PATH         := $(TI_SW_ROOT)/iss/iss_02_00_00_08

hdvpss_PATH      := $(dvr_rdk_BASE)/ti_tools/hdvpss/dvr_rdk_hdvpss

# Codecs
xdais_PATH       := $(TI_SW_ROOT)/xdais/xdais_7_22_00_03
hdvicplib_PATH   := $(TI_SW_ROOT)/ivahd_hdvicp/hdvicp20
h264dec_DIR      := $(TI_SW_ROOT)/codecs/REL.500.V.H264AVC.D.HP.IVAHD.02.00.08.00
h264enc_DIR      := $(TI_SW_ROOT)/codecs/REL.500.V.H264AVC.E.IVAHD.02.00.06.00

h264dec_PATH     := $(h264dec_DIR)/500.V.H264AVC.D.HP.IVAHD.02.00/IVAHD_001
h264enc_PATH     := $(h264enc_DIR)/500.V.H264AVC.E.IVAHD.02.00/IVAHD_001
jpegdec_DIR      := $(TI_SW_ROOT)/codecs/REL.500.V.MJPEG.D.IVAHD.01.00.06.00
jpegenc_DIR      := $(TI_SW_ROOT)/codecs/REL.500.V.MJPEG.E.IVAHD.01.00.04.00
jpegdec_PATH     := $(jpegdec_DIR)/500.V.MJPEG.D.IVAHD.01.00/IVAHD_001
jpegenc_PATH     := $(jpegenc_DIR)/500.V.MJPEG.E.IVAHD.01.00/IVAHD_001
mpeg4dec_DIR     := $(TI_SW_ROOT)/codecs/REL.500.V.MPEG4.D.IVAHD.01.00.11.00
mpeg4dec_PATH    := $(mpeg4dec_DIR)/500.V.MPEG4.D.ASP.IVAHD.01.00/IVAHD_001
mpeg4enc_DIR     := $(TI_SW_ROOT)/codecs/REL.500.V.MPEG4.E.SP.IVAHD.01.00.01.00
mpeg4enc_PATH    := $(mpeg4enc_DIR)/500.V.MPEG4.E.SP.IVAHD.01.00/IVAHD_001
mpeg2dec_DIR     := $(TI_SW_ROOT)/codecs/REL.500.V.MPEG2.D.IVAHD.01.00.12.00
mpeg2dec_PATH    := $(mpeg2dec_DIR)/500.V.MPEG2.D.IVAHD.01.00/IVAHD_001
watermark_lib_PATH := $(TI_SW_ROOT)/codecs/REL_WATERMARK_DECRYPT_IVAHD_00_04.zip

# Audio framework (RPE) and Codecs
rpe_PATH         := $(TI_SW_ROOT)/rpe/remote-processor-execute
aaclcdec_PATH    := $(TI_SW_ROOT)/codecs/c674x_aaclcdec_01_41_00_00_elf
aaclcenc_PATH    := $(TI_SW_ROOT)/codecs/c674x_aaclcenc_01_00_01_00_elf_patched

# Linux side tools
syslink_PATH     := $(TI_SW_ROOT)/syslink/syslink_2_20_02_20
linuxdevkit_PATH := $(CODEGEN_PATH_A8)/arm-arago-linux-gnueabi
KERNELDIR        := $(TI_SW_ROOT)/linux_lsp/kernel/linux-dvr-rdk
UBOOTDIR         := $(TI_SW_ROOT)/linux_lsp/uboot/u-boot-dvr-rdk
LSP_COLLATERALS  := $(TI_SW_ROOT)/linux_lsp/collaterals

# DVR Qt GUI Application tools
ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_UD_DVR)
dvrapp_PATH      := $(dvr_rdk_PATH)/dvrapp/ti810x
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM816X_UD_DVR)
dvrapp_PATH      := $(dvr_rdk_PATH)/dvrapp/ti816x
endif

# NVR Qt GUI Application tools
ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_UD_DVR)
nvrapp_PATH      := $(dvr_rdk_PATH)/dvrapp/ti810x_nvr
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM816X_UD_DVR)
nvrapp_PATH      := $(dvr_rdk_PATH)/dvrapp/ti816x_nvr
endif

memcpy_neon_PATH := $(dvr_rdk_PATH)/module/memcpy_neon
live555_PATH     := $(dvr_rdk_PATH)/module/live555
qt_PATH          := /usr/local/Trolltech/QtEmbedded-4.8.1-arm

# filesystem related paths
mtdutils_PATH    := $(TI_SW_ROOT)/mtd_utils

TFTP_HOME     := $(dvr_rdk_BASE)/tftphome
TARGET_FS     := $(dvr_rdk_BASE)/target/rfs
TARGET_FS_DIR := $(dvr_rdk_PATH)/bin/ti816x
TARGET_EXE_DIR := opt/dvr_rdk/ti816x

ROOTDIR := $(dvr_rdk_PATH)

ifeq ($(DVR_RDK_BOARD_TYPE),DM814X_TI_EVM)
TARGET_FS_DIR := $(dvr_rdk_PATH)/bin/ti814x
TARGET_FS     := $(dvr_rdk_BASE)/target/rfs_814x
TARGET_EXE_DIR := opt/dvr_rdk/ti814x
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM814X_BCH_DVR)
TARGET_FS_DIR := $(dvr_rdk_PATH)/bin/ti814x
TARGET_FS     := $(dvr_rdk_BASE)/target/rfs_814x
TARGET_EXE_DIR := opt/dvr_rdk/ti814x
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM816X_TI_EVM)
TARGET_FS_DIR := $(dvr_rdk_PATH)/bin/ti816x
TARGET_FS     := $(dvr_rdk_BASE)/target/rfs_816x
TARGET_EXE_DIR := opt/dvr_rdk/ti816x
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM816X_UD_DVR)
TARGET_FS_DIR := $(dvr_rdk_PATH)/bin/ti816x
TARGET_FS     := $(dvr_rdk_BASE)/target/rfs_816x
TARGET_EXE_DIR := opt/dvr_rdk/ti816x
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_TI_EVM)
TARGET_FS_DIR := $(dvr_rdk_PATH)/bin/ti810x
TARGET_FS     := $(dvr_rdk_BASE)/target/rfs_810x
TARGET_EXE_DIR := opt/dvr_rdk/ti810x
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_BCH_DVR)
TARGET_FS_DIR := $(dvr_rdk_PATH)/bin/ti810x
TARGET_FS     := $(dvr_rdk_BASE)/target/rfs_810x
TARGET_EXE_DIR := opt/dvr_rdk/ti810x
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_UD_DVR)
TARGET_FS_DIR := $(dvr_rdk_PATH)/bin/ti810x
TARGET_FS     := $(dvr_rdk_BASE)/target/rfs_810x
TARGET_EXE_DIR := opt/dvr_rdk/ti810x
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_BCH_120_DVR)
TARGET_FS_DIR := $(dvr_rdk_PATH)/bin/ti810x
TARGET_FS     := $(dvr_rdk_BASE)/target/rfs_810x
TARGET_EXE_DIR := opt/dvr_rdk/ti810x
endif

ifeq ($(DVR_RDK_BOARD_TYPE),DM816X_UD_DVR)
ifeq ($(DEMOTYPE), )
#  DEMOTYPE := link_api_sd_demo
endif
endif

# set to TRUE to enable standalone RTSP demo
DEMO_RTSP_ENABLE := FALSE

DVR_RDK_BOARD := DVR_RDK_BOARD_TYPE
ifeq ($(DVR_RDK_BOARD_TYPE),DM816X_DVR)
  DVR_RDK_BOARD := ud816x_dvr
endif
ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_DVR)
  DVR_RDK_BOARD := ud810x_dvr
endif

ifeq ($(CORE), )
  CORE := m3vpss
endif

# Default platform
ifeq ($(PLATFORM), )
  PLATFORM := ti816x-evm
ifeq ($(DVR_RDK_BOARD_TYPE),DM814X_TI_EVM)
  PLATFORM := ti814x-evm
endif
ifeq ($(DVR_RDK_BOARD_TYPE),DM814X_BCH_DVR)
  PLATFORM := ti814x-evm
endif
ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_TI_EVM)
  PLATFORM := ti810x-evm
endif
ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_BCH_DVR)
  PLATFORM := ti810x-evm
endif
ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_UD_DVR)
  PLATFORM := ti810x-evm
endif
ifeq ($(DVR_RDK_BOARD_TYPE),DM810X_BCH_120_DVR)
  PLATFORM := ti810x-evm
endif
endif

###########################
# DDR_MEM and LINUX_MEM set.
###########################
# TI816X: 1G,256M; 2G,512M;
# TI814X: 512M,128M;
# TI810X: 256M,64M; 512M,128M; 512,192M; 512,256M;

ifeq ($(PLATFORM), ti816x-evm)
ifeq ($(DDR_MEM), )
ifeq ($(DVR_RDK_BOARD_TYPE),DM816X_TI_EVM)
  	DDR_MEM := DDR_MEM_1024M
ifeq ($(LINUX_MEM),)
	LINUX_MEM := LINUX_MEM_256M
#    LINUX_MEM := LINUX_MEM_128M
endif
else
  DDR_MEM := DDR_MEM_1024M
#	DDR_MEM := DDR_MEM_2048M
ifeq ($(LINUX_MEM),)
	LINUX_MEM := LINUX_MEM_256M
#    LINUX_MEM := LINUX_MEM_128M
endif
endif
endif
  VS_CARD := WITH_VS_CARD
#  VS_CARD := WITHOUT_VS_CARD
endif

ifeq ($(PLATFORM), ti814x-evm)
ifeq ($(DDR_MEM), )
  DDR_MEM := DDR_MEM_512M
endif
ifeq ($(LINUX_MEM),)
  LINUX_MEM := LINUX_MEM_128M
endif
  VS_CARD := WITH_VS_CARD
#  VS_CARD := WITHOUT_VS_CARD
endif

ifeq ($(PLATFORM), ti810x-evm)
ifeq ($(DDR_MEM), )
  DDR_MEM := DDR_MEM_512M
#  DDR_MEM := DDR_MEM_256M
endif
ifeq ($(LINUX_MEM),)
#  LINUX_MEM := LINUX_MEM_64M
  LINUX_MEM := LINUX_MEM_128M
#  LINUX_MEM := LINUX_MEM_192M
#  LINUX_MEM := LINUX_MEM_256M
endif
  VS_CARD := WITH_VS_CARD
#  VS_CARD := WITHOUT_VS_CARD
endif

##########################################################################
#Set String Format when use LINUX_MEM and DDR_MEM as suffix of filenames.
##########################################################################
#Prefix of size
DDR_SIZE_PREFIX :=
LINUX_SIZE_PREFIX :=
#Will be used as filename suffix.
DDR_SUFFIX := $(subst DDR_MEM_,$(DDR_SIZE_PREFIX),$(DDR_MEM))

# Default profile
ifeq ($(PROFILE_m3video), )
  PROFILE_m3video := release
#  PROFILE_m3video := debug
endif

ifeq ($(PROFILE_m3vpss), )
  PROFILE_m3vpss := release
#  PROFILE_m3vpss := debug
endif

ifneq ($(PLATFORM), ti810x-evm)
ifeq ($(PROFILE_c6xdsp), )
  PROFILE_c6xdsp := debug
endif
endif

# Default klockwork build flag
ifeq ($(KW_BUILD), )
  KW_BUILD := no
endif

USE_SYSLINK_NOTIFY=0

XDCPATH = $(bios_PATH)/packages;$(xdc_PATH)/packages;$(ipc_PATH)/packages;$(hdvpss_PATH)/packages;$(fc_PATH)/packages;$(dvr_rdk_PATH);$(syslink_PATH)/packages;$(xdais_PATH)/packages;$(edma3lld_PATH)/packages;



# Default klockwork build flag
ifeq ($(DISABLE_AUDIO), )
  DISABLE_AUDIO := no
endif

#Power Optimization based profile use for 810x-evm
810X_SAVE_POWER_MODE=no

#Device Collaterals
DEV_COLLATERALS  := $(TI_SW_ROOT)/device_collateral

TREAT_WARNINGS_AS_ERROR=yes

BUILD_BIOS6_FIRMWARE=yes

ifeq ($(PLATFORM),ti816x-evm)
SYSTEM_ETH_OFFLOAD_ENABLE=yes
SYSTEM_ETH_OFFLOAD_CORE_DSP=yes
endif

ifeq ($(PLATFORM),ti810x-evm)
SYSTEM_ETH_OFFLOAD_ENABLE=no
endif


DVR_RDK_ISS_LIB_PATH=$(dvr_rdk_PATH)/mcfw/src_bios6/alg/simcop/lib
DVR_RDK_ISS_INC_PATH=$(dvr_rdk_PATH)/mcfw/src_bios6/alg/simcop/inc

endif

RPE_BUILD_VARS = ipc_PATH="${ipc_PATH}" \
	bios_PATH="${bios_PATH}" \
	xdc_PATH="${xdc_PATH}" \
	xdais_PATH="${xdais_PATH}" \
	syslink_PATH="${syslink_PATH}" \
	kernel_PATH="${KERNELDIR}" \
	CODEGEN_PATH_A8="${CODEGEN_PATH_A8}" \
	CGT_ARM_PREFIX="${CSTOOL_PREFIX}" \
	CODEGEN_PATH_DSP="${CODEGEN_PATH_DSP}" \
	CODEGEN_PATH_DSPELF="${CODEGEN_PATH_DSP}" \
	ROOTDIR="${rpe_PATH}" \
	aaclcdec_PATH="${aaclcdec_PATH}" \
	aaclcenc_PATH="${aaclcenc_PATH}" 

include $(ROOTDIR)/makerules/build_config.mk
include $(ROOTDIR)/makerules/env.mk
include $(ROOTDIR)/makerules/platform.mk
include $(dvr_rdk_PATH)/component.mk

LINUX_SUFFIX :=$(shell cat ${CONFIG_BLD_XDC_m3}|sed -n 's/.*LINUX_SIZE\s*=\s*\([0-9]*\)\s*\*\s*MB/\1M/p')
LINUX_SUFFIX := $(subst ;,$(LINUX_SIZE_PREFIX),$(LINUX_SUFFIX))

export OS
export PLATFORM
export CORE
export PROFILE_m3vpss
export PROFILE_m3video
export PROFILE_c6xdsp
export CODEGEN_PATH_M3
export CODEGEN_PREFIX
export CODEGEN_PATH_A8
export CODEGEN_PATH_DSP
export bios_PATH
export xdc_PATH
export hdvpss_PATH
export dvr_rdk_PATH
export ipc_PATH
export fc_PATH
export xdais_PATH
export h264dec_DIR
export h264enc_DIR
export jpegdec_DIR
export mpeg4dec_DIR
export jpegenc_DIR
export mpeg2dec_DIR
export h264dec_PATH
export h264enc_PATH
export jpegdec_PATH
export mpeg4dec_PATH
export mpeg4enc_PATH
export mpeg4enc_DIR
export jpegenc_PATH
export mpeg2dec_PATH
export hdvicplib_PATH
export linuxdevkit_PATH
export edma3lld_PATH
export ROOTDIR
export XDCPATH
export KW_BUILD
export syslink_PATH
export KERNELDIR
export TARGET_FS_DIR
export TARGET_EXE_DIR
export UBOOTDIR
export DVR_RDK_BOARD_TYPE
export DVR_RDK_BOARD
export USE_SYSLINK_NOTIFY
export DEST_ROOT
export dvr_rdk_BASE
export TFTP_HOME
export LINUX_MEM
export DDR_MEM
export DISABLE_AUDIO 
export dvrapp_PATH
export nvrapp_PATH
export memcpy_neon_PATH
export live555_PATH
export qt_PATH
export 810X_SAVE_POWER_MODE
export TREAT_WARNINGS_AS_ERROR
export VS_CARD
export SC_SCRIPTS_BASE_DIR
export iss_PATH
export SYSTEM_VCOP_ENABLE
export SYSTEM_VCOP_VIDEOM3
export DVR_RDK_ISS_LIB_PATH
export DVR_RDK_ISS_INC_PATH
export DEMOTYPE
export rpe_PATH    
export RPE_BUILD_VARS
export aaclcdec_PATH    
export aaclcenc_PATH    
export mtdutils_PATH
export DDR_SUFFIX
export LINUX_SUFFIX
export TI_SW_ROOT
export DEMO_RTSP_ENABLE
export LSP_COLLATERALS
export DEV_COLLATERALS
export SYSTEM_ETH_OFFLOAD_ENABLE
export SYSTEM_ETH_OFFLOAD_CORE_DSP
export watermark_lib_PATH
