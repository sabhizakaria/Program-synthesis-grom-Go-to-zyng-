#include "com_chan_axis.h"

int cData;
int sData = 2;
int main (){

	AXIS_STREAM producer;
	AXIS_STREAM consumer;
	axiStreamExample(&producer, &consumer);
	cData = consumer.data.to_int();
	if(cData != sData*5 ){
		printf("ERROR : mismatch between HW and SW results %d \n",cData);
		return EXIT_FAILURE;
	}
	printf("SUCCESS : match between HW and SW results \n");
	return EXIT_SUCCESS;
}
