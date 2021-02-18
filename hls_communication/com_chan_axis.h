#ifndef _AXI_STREAM_EXAMPLE_H
#define _AXI_STREAM_EXAMPLE_H

#include <stdlib.h>
#include "ap_axi_sdata.h"
#include "hls_stream.h"


typedef ap_axis<32,2,1,1> AXIS_STREAM;

void axiStreamExample (AXIS_STREAM axisSlave, AXIS_STREAM* axisMaster);
#endif
