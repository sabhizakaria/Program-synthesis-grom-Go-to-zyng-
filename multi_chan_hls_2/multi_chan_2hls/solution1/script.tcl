############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project multi_chan_2hls
set_top communication
add_files com_chan_axis.h
add_files com_chan_axis.cpp
add_files -tb tb_com_chan_axis.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1" -flow_target vivado
set_part {xc7z045ffg900-2}
create_clock -period 10 -name default
#source "./multi_chan_2hls/solution1/directives.tcl"
csim_design -clean
csynth_design
cosim_design
export_design -format ip_catalog
