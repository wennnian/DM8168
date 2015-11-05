# (c) Texas Instruments

include Rules.make

####################################
#                                  #
# DVR-RDK Top Level Build Targets  #
#                                  #
####################################

ifeq ($(BUILD_BIOS6_FIRMWARE),yes)
#############################################
# DVR-RDK Linux+BIOS         Build Targets  #
#############################################

dvr_rdk: dvr_rdk_linux dvr_rdk_bios6 fsupdate 
clean: dvr_rdk_linux_clean dvr_rdk_bios6_clean

else
#############################################
# DVR-RDK Linux ONLY         Build Targets  #
#############################################

dvr_rdk: dvr_rdk_linux fsupdate
clean: dvr_rdk_linux_clean 

endif

all: clean dvr_rdk



###############################
#                             #
# System Build      Targets   #
#                             #
###############################

sys:  uboot linux_deps syslink dvr_rdk

sys_clean: clean syslink_clean linux_deps_clean uboot_clean

sys_all: sys_clean sys


##########################################
#                                        #
# DVR-RDK Linux side Build Targets       #
# (excluding Linux Kernel Dependancies)  #
#                                        #
##########################################

dvr_rdk_linux:
	$(MAKE) -fMAKEFILE.MK -C$(dvr_rdk_PATH)/mcfw/src_linux
	$(MAKE) -fMAKEFILE.MK -C$(dvr_rdk_PATH)/demos

dvr_rdk_linux_clean:
	$(MAKE) -fMAKEFILE.MK -C$(dvr_rdk_PATH)/mcfw/src_linux clean
	$(MAKE) -fMAKEFILE.MK -C$(dvr_rdk_PATH)/demos clean

dvr_rdk_linux_all: dvr_rdk_linux_clean dvr_rdk_linux


#################################################
#                                               #
# DVR-RDK Linux Kernel Module   Build Targets   #
#                                               #
#################################################

dvr_rdk_linux_kermod:
	$(MAKE) -fMAKEFILE.MK -C$(dvr_rdk_PATH)/mcfw/src_linux kermod

dvr_rdk_linux_kermod_clean:
	$(MAKE) -fMAKEFILE.MK -C$(dvr_rdk_PATH)/mcfw/src_linux kermod_clean

dvr_rdk_linux_kermod_all: dvr_rdk_linux_kermod_clean dvr_rdk_linux_kermod


####################################
#                                  #
# DVR-RDK BIOS side Build Targets  #
#                                  #
####################################

dvr_rdk_bios6: hdvpss 
	$(MAKE) -fMAKEFILE.MK -C $(dvr_rdk_PATH)/mcfw/src_bios6 $(TARGET)

dvr_rdk_bios6_clean: hdvpss_clean
	$(MAKE) -fMAKEFILE.MK -C $(dvr_rdk_PATH)/mcfw/src_bios6 clean

dvr_rdk_bios6_all: dvr_rdk_bios6_clean dvr_rdk_bios6


####################################
#                                  #
# DVR-RDK Algorithm Build Targets  #
#                                  #
####################################

dvr_rdk_bios6_algs: 
	rm -rf build/lib/
	rm -rf build/obj/
	$(MAKE) -fMAKEFILE.MK -C $(dvr_rdk_PATH)/mcfw/src_bios6/alg/scd


######################################
#                                    #
# DVR Qt Application Build Targets   #
#                                    #
######################################

dvrlib:
	$(MAKE) -fMAKEFILE.MK -C $(dvr_rdk_PATH)/mcfw/src_linux
	$(MAKE) -fMAKEFILE.MK -C $(dvrapp_PATH)/app

dvrlib_clean:
	$(MAKE) -fMAKEFILE.MK -C $(dvrapp_PATH)/app clean

dvrgui:
ifeq (,$(qt_PATH))
	@echo -e "\n [info] dvrgui need path(qt_PATH) for QT4.8.1 ---\n"
else
	cd $(dvrapp_PATH)/dvrgui; sh qmake.sh;
	$(MAKE) -fMAKEFILE.MK -C $(dvrapp_PATH)/dvrgui
endif

dvrgui_clean:
	$(MAKE) -fMAKEFILE.MK -C $(dvrapp_PATH)/dvrgui clean

dvrapp: dvrlib dvrgui fsupdate
	@echo -e "\n--- $(MAKE) dvrapp done! (`date +'%H:%M:%S'`)---\n"

dvrapp_clean: dvrlib_clean dvrgui_clean
dvrapp_all: dvrapp_clean dvrapp

######################################
#                                    #
# NVR Qt Application Build Targets   #
#                                    #
######################################

nvrlib:
	$(MAKE) -fMAKEFILE.MK -C $(dvr_rdk_PATH)/mcfw/src_linux
	$(MAKE) -fMAKEFILE.MK -C $(nvrapp_PATH)/app

nvrlib_clean:
	$(MAKE) -fMAKEFILE.MK -C $(nvrapp_PATH)/app clean

nvrgui:
ifeq (,$(qt_PATH))
	@echo -e "\n [info] nvrgui need path(qt_PATH) for QT4.8.1 ---\n"
else
	cd $(nvrapp_PATH)/dvrgui; sh qmake.sh;
	$(MAKE) -fMAKEFILE.MK -C $(nvrapp_PATH)/dvrgui
endif

nvrgui_clean:
	$(MAKE) -fMAKEFILE.MK -C $(nvrapp_PATH)/dvrgui clean

nvrapp: nvrlib nvrgui fsupdate
	@echo -e "\n--- $(MAKE) nvrapp done! (`date +'%H:%M:%S'`)---\n"

nvrapp_clean: nvrlib_clean nvrgui_clean
nvrapp_all: nvrapp_clean nvrapp

live555:
	$(MAKE) -fmakefile -C $(memcpy_neon_PATH)
	$(MAKE) -fMakefile -C $(live555_PATH)/BasicUsageEnvironment
	$(MAKE) -fMakefile -C $(live555_PATH)/liveMedia
	$(MAKE) -fMakefile -C $(live555_PATH)/UsageEnvironment
	$(MAKE) -fMakefile -C $(live555_PATH)/groupsock
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_client

live555_clean:
	$(MAKE) -fmakefile -C $(memcpy_neon_PATH) clean
	$(MAKE) -fMakefile -C $(live555_PATH)/BasicUsageEnvironment clean
	$(MAKE) -fMakefile -C $(live555_PATH)/liveMedia clean
	$(MAKE) -fMakefile -C $(live555_PATH)/UsageEnvironment clean
	$(MAKE) -fMakefile -C $(live555_PATH)/groupsock clean
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_client clean

live555_all: live555_clean live555

wisstreamer_dvr:  
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer/netra_interface
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer

wisstreamer_dvr_clean: 
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer/netra_interface clean
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer clean

wisstreamer_dvr_all: wisstreamer_dvr_clean wisstreamer_dvr

wisstreamer_nvr:  
ifeq ($(PLATFORM),ti816x-evm)
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer_nvr
else
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer/netra_interface
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer
endif

wisstreamer_nvr_clean: 
ifeq ($(PLATFORM),ti816x-evm)
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer_nvr clean
else
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer/netra_interface clean
	$(MAKE) -fMakefile -C $(live555_PATH)/netra_streamer clean
endif	

wisstreamer_nvr_all: wisstreamer_nvr_clean wisstreamer_nvr


#########################
#                       #
# HDVPSS Build Targets  #
#                       #
#########################

hdvpss:
	$(MAKE) -C ./makerules -fbuild_hdvpss.mk hdvpss

hdvpss_clean:
	$(MAKE) -C ./makerules -fbuild_hdvpss.mk hdvpss_clean

hdvpss_all: hdvpss_clean hdvpss


#########################
#                       #
# RPE    Build Targets  #
#                       #
#########################

rpe:
	$(MAKE) -C $(rpe_PATH) $(RPE_BUILD_VARS) 

rpe_clean:
	$(MAKE) -C $(rpe_PATH) $(RPE_BUILD_VARS) clean

rpe_all: rpe_clean rpe


#########################
#                       #
# ISS    Build Targets  #
#                       #
#########################

iss:
	$(MAKE) -C ./makerules -f build_iss.mk iss 
	$(MAKE) -C ./makerules -f build_iss.mk iss_install

iss_install:
	$(MAKE) -C ./makerules -f build_iss.mk iss_install 

iss_clean:
	$(MAKE) -C ./makerules -f build_iss.mk iss_clean 

iss_all: iss_clean iss


##############################################
#							                 #
# Linux Kernel and Dependant  Build Targets  #
#                                            #
############################################## 

linux_deps: lsp syslink_kermod dvr_rdk_linux_kermod

linux_deps_clean: dvr_rdk_linux_kermod_clean syslink_kermod_clean lsp_clean 

linux_deps_all: linux_deps_clean linux_deps

#########################
#                       #
# UBOOT  Build Targets  #
#                       #
#########################

uboot:
	$(MAKE) -C ./makerules -f build_uboot.mk uboot

uboot_clean:
	$(MAKE) -C ./makerules -f build_uboot.mk uboot_clean 
	
uboot_all: uboot_clean uboot


################################
#                              #
# Linux Kernel  Build Targets  #
#                              #
################################

lsp_config:
	$(MAKE) -C ./makerules -f build_lsp.mk lsp_config

lsp_menuconfig:
	$(MAKE) -C ./makerules -f build_lsp.mk lsp_menuconfig

lsp:
	$(MAKE) -C ./makerules -f build_lsp.mk lsp

lsp_clean:
	$(MAKE) -C ./makerules -f build_lsp.mk lsp_clean 

lsp_all: lsp_clean lsp


################################
#                              #
# Syslink  Build Targets       #
#                              #
################################

syslink: 
	$(MAKE) -C ./makerules -f build_syslink.mk syslink_rtos
	$(MAKE) -C ./makerules -f build_syslink.mk syslink_linux

syslink_clean:
	$(MAKE) -C ./makerules -f build_syslink.mk syslink_clean

syslink_info:
	$(MAKE) -C ./makerules -f build_syslink.mk syslink_info

syslink_all: syslink_clean syslink


##############################################
#                                            #
# Syslink  Kernel Module Build Targets       #
#                                            #
##############################################

syslink_kermod:
	$(MAKE) -C ./makerules -f build_syslink.mk syslink_kermod

syslink_kermod_clean:
	$(MAKE) -C ./makerules -f build_syslink.mk syslink_kermod_clean


################################
#                              #
# JFFS/UBIFS  Build Targets    #
#                              #
################################

# Not supported
#jffs2_128:
#	$(mtdutils_PATH)/sbin/mkfs.jffs2 -lqn -e 128 -r $(TARGET_FS) -o  $(TFTP_HOME)/rfs_128_$(DVR_RDK_BOARD_TYPE).jffs2
#jffs2_256:
#	$(mtdutils_PATH)/sbin/mkfs.jffs2 -lqn -e 256 -r $(TARGET_FS) -o  $(TFTP_HOME)/rfs_256_$(DVR_RDK_BOARD_TYPE).jffs2

ubifs_128:
	$(mtdutils_PATH)/sbin/mkfs.ubifs -r $(TARGET_FS) -F -o ubifs.img -m 2048 -e 126976 -c 1580
	$(mtdutils_PATH)/sbin/ubinize -o $(TFTP_HOME)/ubi_128_$(DVR_RDK_BOARD_TYPE).img -m 2048 -p 128KiB -s 512 -O 2048 $(dvr_rdk_PATH)/makerules/ubinize.cfg
	rm -rf ubifs.img

# Not supported
# ubifs_256:
#	$(mtdutils_PATH)/sbin/mkfs.ubifs -r $(TARGET_FS) -F -o ubifs.img -m 2048 -e 258048 -c 788
#	$(mtdutils_PATH)/sbin/ubinize -o $(TFTP_HOME)/ubi_256_$(DVR_RDK_BOARD_TYPE).img -m 2048 -p 256KiB -s 512 -O 2048 $(dvr_rdk_PATH)/makerules/ubinize_256.cfg
#	rm -rf ubifs.img

fs_compress:
	@echo "# --------- Compressing firmware ----------"
	-mkdir -p firmware
	rm firmware/* -rf
	cp -R $(TARGET_FS)/$(TARGET_EXE_DIR)/firmware/* firmware
	tar --lzma -cvpf $(TARGET_FS)/$(TARGET_EXE_DIR)/_firmware.tar.lzma firmware/
	rm $(TARGET_FS)/$(TARGET_EXE_DIR)/firmware/ -rf
	chmod 777 $(TARGET_FS)/$(TARGET_EXE_DIR)
	rm firmware -rf
	
###############################
#                             #
# Filesytem Update  Targets   #
#                             #
###############################

fsupdate:
	@echo "# "
	@echo "# PLATFORM     = $(PLATFORM)"
	@echo "# DDR_MEM      = $(DDR_MEM)"
	@echo "# LINUX_MEM    = $(LINUX_MEM)"
	@echo "# DDR_SUFFIX   = $(DDR_SUFFIX)"
	@echo "# LINUX_SUFFIX = $(LINUX_SUFFIX)"
	@echo "# "
	@echo "# -------- Copying binaries to [ $(TARGET_FS) ] --------"
	-mkdir -p $(TARGET_FS)/$(TARGET_EXE_DIR)
	rm -rf $(TARGET_FS)/$(TARGET_EXE_DIR)/*
	cp -R $(TARGET_FS_DIR)/* $(TARGET_FS)/$(TARGET_EXE_DIR)/.
	chmod 755 $(TARGET_FS)/$(TARGET_EXE_DIR)/*.sh
	$(STRIP470) $(TARGET_FS)/$(TARGET_EXE_DIR)/firmware/dvr_rdk_fw_m3video_$(DDR_SUFFIX)_$(LINUX_SUFFIX).xem3
	$(STRIP470) $(TARGET_FS)/$(TARGET_EXE_DIR)/firmware/dvr_rdk_fw_m3vpss_$(DDR_SUFFIX)_$(LINUX_SUFFIX).xem3
ifeq ($(PLATFORM),ti816x-evm)
	$(STRIP6x)  $(TARGET_FS)/opt/dvr_rdk/ti816x/firmware/dvr_rdk_fw_c6xdsp_$(DDR_SUFFIX)_$(LINUX_SUFFIX).xe674
endif
ifeq ($(PLATFORM),ti814x-evm)
	$(STRIP6x)  $(TARGET_FS)/opt/dvr_rdk/ti814x/firmware/dvr_rdk_fw_c6xdsp_$(DDR_SUFFIX)_$(LINUX_SUFFIX).xe674
endif
	chmod 755   $(TARGET_FS)/$(TARGET_EXE_DIR)/firmware/*.*
	$(STRIP_ALL_ARM) $(TARGET_FS)/$(TARGET_EXE_DIR)/bin/*.* 
	$(STRIP_DEBUG_ARM) $(TARGET_FS)/$(TARGET_EXE_DIR)/kermod/*.* 
	chmod 755   $(TARGET_FS)/$(TARGET_EXE_DIR)/bin/*.*
	@echo "# -------- Build Completed for $(DVR_RDK_BOARD_TYPE) -- ( @ Time `date +'%H:%M:%S'`) ---"
		

###############################
#                             #
# Misc              Targets   #
#                             #
###############################

nfsreset:
	/usr/sbin/exportfs -av
	/etc/init.d/nfs-kernel-server restart


###############################
#                             #
# Code Checker      Targets   #
#                             #
###############################

DIR=mcfw

sc_indent: 
	$(SC_SCRIPTS_BASE_DIR)/SCIndent_RDK.pl --dir $(DIR)        

sc_check:
	$(SC_SCRIPTS_BASE_DIR)/SCCheckers_RDK.pl --dir $(DIR)

sc_insert:
	$(SC_SCRIPTS_BASE_DIR)/SCInsert_RDK.pl --dir $(DIR)


###############################
#                             #
# Release Packaging Targets   #
#                             #
###############################

copy_ti_tools_common:
	$(MAKE) -C ./makerules -f build_copy_ti_tools.mk copy_ti_tools_common

copy_ti_tools_specific:
	$(MAKE) -C ./makerules -f build_copy_ti_tools.mk copy_ti_tools_specific

strip_clean_ti_tools:
	$(MAKE) -C ./makerules -f build_copy_ti_tools.mk strip_clean_ti_tools

strip_xdais:
	$(MAKE) -C ./makerules -f build_copy_ti_tools.mk strip_xdais

strip_syslink:
	$(MAKE) -C ./makerules -f build_copy_ti_tools.mk strip_syslink

strip_ipc:
	$(MAKE) -C ./makerules -f build_copy_ti_tools.mk strip_ipc

strip_codecs:
	$(MAKE) -C ./makerules -f build_copy_ti_tools.mk strip_codecs

