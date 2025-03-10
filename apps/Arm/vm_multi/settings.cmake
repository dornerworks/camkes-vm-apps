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

set(supported "exynos5422;qemu-arm-virt")
if(NOT "${PLATFORM}" IN_LIST supported)
    message(FATAL_ERROR "PLATFORM: ${PLATFORM} not supported.
         Supported: ${supported}")
endif()
set(LibUSB OFF CACHE BOOL "" FORCE)
set(VmPCISupport ON CACHE BOOL "" FORCE)
set(VmVirtioConsole ON CACHE BOOL "" FORCE)
set(VmVirtioNetArping OFF CACHE BOOL "" FORCE)
set(VmVirtioNetVirtqueue ON CACHE BOOL "" FORCE)
set(VmInitRdFile ON CACHE BOOL "" FORCE)
if("${PLATFORM}" STREQUAL "qemu-arm-virt")
    set(QEMU_MEMORY "2048")
    set(KernelArmCPU cortex-a53 CACHE STRING "" FORCE)
    set(qemu_sim_extra_args "-netdev tap,id=mynet0,ifname=tap0,script=no,downscript=no -device virtio-net,netdev=mynet0,mac=52:55:00:d1:55:01")
    set(KernelArmExportPCNTUser ON CACHE BOOL "" FORCE)
    set(KernelArmExportPTMRUser ON CACHE BOOL "" FORCE)
endif()
