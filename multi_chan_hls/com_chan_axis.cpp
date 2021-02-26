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

int send(AXI_STREAM* streamData, AXI_STREAM * chan){

	AXI_VALUE data;
	AXI_VALUE tmpData;
	while (!streamData->empty()){
		streamData->read(tmpData);
		printf("Received : %d\n",tmpData.data.to_int());
		data = tmpData;
		data.data = tmpData.data.to_int()*2;
		chan->write(data);
		printf("Send : %d\n",data.data.to_int());
	}
	return EXIT_SUCCESS;
}

int receive(AXI_STREAM* cha){
	AXI_VALUE data;
	while (!cha->empty()){
		cha->read(data);
		printf("Received : %d\n",data.data.to_int());
	}

	return EXIT_SUCCESS;
}

int initStream(AXI_STREAM * streamData){
	size_t i ;
	AXI_VALUE data;
	for(i=0 ; i<NUM; i++ ){
		data.data = i;
		data.user = 1;
		data.last = (i == NUM-1);
		data.dest = 2;
		streamData->write(data);
	}

	return EXIT_SUCCESS;
}



int communication(AXI_STREAM* streamData){
	#pragma HLS DATAFLOW
	#pragma HLS INTERFACE axis port=cha1

	int i , ret ;
	AXI_STREAM cha1, cha2;
	// Initialisation des donn�es
	ret = initStream(streamData);
	if (ret){
		perror("Stream init data error");
		return EXIT_FAILURE;
	}

	printf("----------------------------Noeud A (producer)----------------------------\n");
	// Envoie des donn�es
	ret = send(streamData, &cha1);
	if (ret){
		perror("Sending data error");
		return EXIT_FAILURE;
	}
	initStream(streamData);
	ret = send(streamData, &cha2);
	if (ret){
		perror("Sending data error");
		return EXIT_FAILURE;
	}
	printf("----------------------------Noeud B (consumer)----------------------------\n");
	// Reception des donn�es
	ret = receive(&cha1);
	if (ret){
		perror("receive data error");
		return EXIT_FAILURE;
	}

	printf("----------------------------Noeud C (consumer)----------------------------\n");
	ret = receive(&cha2);
	if (ret){
		perror("receive data error");
		return EXIT_FAILURE;
	}
	return EXIT_SUCCESS;

}
