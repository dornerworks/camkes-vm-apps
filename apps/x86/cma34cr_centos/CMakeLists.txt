#
# Copyright 2018, Data61
# Commonwealth Scientific and Industrial Research Organisation (CSIRO)
# ABN 41 687 119 230.
#
# This software may be distributed and modified according to the terms of
# the BSD 2-Clause license. Note that NO WARRANTY is provided.
# See "LICENSE_BSD2.txt" for details.
#
# @TAG(DATA61_BSD)
#

cmake_minimum_required(VERSION 3.8.2)

project(cma34cr_centos)

# Include CAmkES VM helper functions
include(${CAMKES_VM_HELPERS_PATH})

# Retrieve Init0 extra src files
file(GLOB init0_extra src/*.c)
# Declare VM component: Init0
DeclareCAmkESVM(Init0 EXTRA_SOURCES ${init0_extra} EXTRA_LIBS ethdrivers)

# Declare C162 Kernel
DecompressLinuxKernel(
    decompress_linux decompressed_kernel ${CMAKE_CURRENT_SOURCE_DIR}/centos_linux/bzimage
)
AddToFileServer("bzimage" ${decompressed_kernel} DEPENDS decompress_linux)

# Declare C162 Rootfs
AddToFileServer("rootfs.cpio" ${CMAKE_CURRENT_SOURCE_DIR}/centos_linux/rootfs.cpio)

# Provided by find_package(util_libs)
include(${LWIP_HELPERS})
# Declare lwipopts.h include
AddLWIPConfiguration(${CMAKE_CURRENT_SOURCE_DIR}/lwip_include)

# Initialise CAmkES Root Server with addition CPP includes
DeclareCAmkESVMRootServer(
    cma34cr_centos.camkes
    CPP_INCLUDES
    ${CAMKES_VM_DIR}/components/StringReverse/include
    ${CAMKES_VM_DIR}/components/Ethdriver/include
    configurations
)
