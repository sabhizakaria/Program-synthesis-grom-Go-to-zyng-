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



int communication(AXI_STREAM* streamData){
	#pragma HLS DATAFLOW
	#pragma HLS INTERFACE axis port=cha1

	int i , ret;
	AXI_STREAM chaB, chaC, buffer;
	// Initialisation des données
	ret = initStream(streamData);
	if (ret){
		perror("Stream init data error");
		return EXIT_FAILURE;
	}
	printf("----------------------------Noeud A (producer)----------------------------\n");
	// Envoie des données au noeud B

	ret = send(streamData, &chaB);
	if (ret){
		perror("Sending to B data error");
		return EXIT_FAILURE;
	}
	// La lecture des stream consomme les données ( passer par un tampon ou renitialiser les données ? )
	printf("----------------------------Noeud B (treatement)----------------------------\n");
	// Reception des données
	ret= receive(&chaB,&buffer);
	if (ret){
		perror("receive from A data error");
		return EXIT_FAILURE;
	}

	ret = send(&buffer, &chaC);
	if (ret){
		perror("Sending to B data error");
		return EXIT_FAILURE;
	}

	printf("----------------------------Noeud C (consumer)----------------------------\n");
	ret = receive(&chaC,&buffer);
	if (ret){
		perror("receive from A data error");
		return EXIT_FAILURE;
	}
	read_chan(&buffer);
	return EXIT_SUCCESS;

}
