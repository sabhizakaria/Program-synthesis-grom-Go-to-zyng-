#include "com_chan_axis.h"


// Note
// template<int D, int U, int TI, int TD>
// Struct ap_axis{
/*
	ap_int<D> data;
	ap_unit<D/8> keep;
	ap_uint<D/8> strb;
	ap_uint<U> user;
	ap_unit<1> last;
	ap_unit<TI> id;
	ap_unit<TD> dest;

*/



void axiStreamExample(AXIS_STREAM  axisSlave, AXIS_STREAM* axisMaster){

	int input = axisSlave.data.to_int();

	//Don't generate ap_ctrl ports in RTL
    #pragma HLS_INTERFACE ap_ctrl_none port=return
	//allow convertion of data array into FIFOs interface
    #pragma HLS DATAFLOW

	#pragma HLS INTERFACE axis port=axisSlave
	#pragma HLS INTERFACE axis port=axisMaster

	printf("Slave input %d \n",input);

	axisMaster->data = input*5;
	axisMaster->keep = axisSlave.keep;
	axisMaster->strb = axisSlave.strb;
	axisMaster->user = axisSlave.user;
	axisMaster->last = axisSlave.last;
	axisMaster->id   = axisSlave.id;
	axisMaster->dest = axisSlave.dest;

	printf("Master input %d \n",axisMaster->data.to_int());


}
