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

int traitement(AXI_STREAM* streamData, AXI_STREAM * chan){

	AXI_VALUE data;
	AXI_VALUE tmpData;
	while (!streamData->empty()){
		streamData->read(tmpData);
		data = tmpData;
		data.data = tmpData.data.to_int()*2;
		//printf("sending... : %d\n",data.data.to_int());
		chan->write(data);
	}
	return EXIT_SUCCESS;
}

int receive(AXI_STREAM* cha, AXI_STREAM* res){
	AXI_VALUE data;
	while (!cha->empty()){
		cha->read(data);
		//printf("Received : %d\n",data.data.to_int());
		res->write(data);
	}

	return EXIT_SUCCESS;
}

void read_chan(AXI_STREAM* channel){
	printf("Results : \n");
	AXI_VALUE data;
	while (!channel->empty()){
		channel->read(data);
		printf("data: %d\n",data.data.to_int());
	}
}

int initStream(AXI_STREAM * streamData){
	size_t i ;
	AXI_VALUE data;
	printf("Initialization : \n");
	for(i=0 ; i<NUM; i++ ){
		data.data = i;
		data.user = 1;
		data.last = (i == NUM-1);
		data.dest = 2;
		streamData->write(data);
		printf("data: %d\n",data.data.to_int());
	}

	return EXIT_SUCCESS;
}



int application(AXI_STREAM* streamData){
	#pragma HLS DATAFLOW
	#pragma HLS INTERFACE axis port=cha1

	int i , ret;
	AXI_STREAM chaB, chaC, buffer;
	// Initialisation des données
	initStream(streamData);
	printf("----------------------------Noeud A (traitement et envoie )----------------------------\n");
	// Envoie des données au noeud
	traitement(streamData, &chaB);
	printf("----------------------------Noeud B (reception et traitement )----------------------------\n");
	// Reception des données
	receive(&chaB,&buffer);
	traitement(&buffer, &chaC);
	printf("----------------------------Noeud C (consumer)----------------------------\n");
	receive(&chaC,&buffer);
	read_chan(&buffer);
	return EXIT_SUCCESS;

}
