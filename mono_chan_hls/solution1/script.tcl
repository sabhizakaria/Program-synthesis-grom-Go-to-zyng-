############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project mono_chan_hls
set_top communication
add_files sources/com_chan_axis.cpp
add_files sources/com_chan_axis.h
add_files -tb sources/tb_com_chan_axis.cpp
open_solution "solution1" -flow_target vivado
set_part {xc7z045ffg900-2}
create_clock -period 10 -name default
#source "./mono_chan_hls/solution1/directives.tcl"
csim_design -clean
csynth_design
cosim_design
export_design -format ip_catalog
