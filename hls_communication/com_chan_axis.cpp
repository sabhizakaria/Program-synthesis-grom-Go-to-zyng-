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
int s_data = 2 ;
void producer(AXIS_STREAM* output){
	//Don't generate ap_ctrl ports in RTL
	//#pragma HLS_INTERFACE ap_ctrl_none port=return

	//allow pipline in case of loop
	//#pragma HLS DATAFLOW

	#pragma HLS INTERFACE axis port=output
	output->data = s_data;
	output->keep = 1;
	output->strb = 1;
	output->user = 1;
	output->last = 0;
	output->id = 0;
	output->dest = 1;

	int send = output->data.to_int();
	printf("producer send :%d\n",send);
}

void consumer(AXIS_STREAM* input){
	//Don't generate ap_ctrl ports in RTL
    //#pragma HLS_INTERFACE ap_ctrl_none port=return

	//allow pipline in case of loop
	//#pragma HLS DATAFLOW

	#pragma HLS INTERFACE axis port=input
	int received = input->data.to_int();
	printf("consumer received :%d\n",received);

}



void axiStreamExample(AXIS_STREAM*  output, AXIS_STREAM* input){


	int i ;
	//Don't generate ap_ctrl ports in RTL
    //#pragma HLS_INTERFACE ap_ctrl_none port=return

	//allow pipline in case of loop
    #pragma HLS DATAFLOW
	#pragma HLS INTERFACE axis port=output
	#pragma HLS INTERFACE axis port=input

	// generate data
	producer(output);
	printf("producer : %d\n",output->data.to_int());
	// send data through the bus
	input->data = output->data.to_int()*5;
	input->keep = output->keep;
	input->strb = output->strb;
	input->user = output->user;
	input->last = output->last;
	input->id   = output->id;
	input->dest = output->dest;

	// receive data from the bus
	consumer(input);


}
