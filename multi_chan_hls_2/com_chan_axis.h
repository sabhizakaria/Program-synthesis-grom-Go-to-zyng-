#ifndef _AXI_STREAM_EXAMPLE_H
#define _AXI_STREAM_EXAMPLE_H

#include <stdlib.h>
#include "ap_axi_sdata.h"
#include "hls_stream.h"

typedef ap_axis<32,2,1,1> AXI_VALUE;
typedef hls::stream <AXI_VALUE> AXI_STREAM;

#define NUM 10

void read_chan(AXI_STREAM* channel);
int initStream(AXI_STREAM* streamData);
int traitement(AXI_STREAM* streamData, AXI_STREAM* chan);
int receive(AXI_STREAM* cha, AXI_STREAM* data);
int application(AXI_STREAM*  cha1);

#endif
