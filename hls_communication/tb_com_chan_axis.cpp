#include "com_chan_axis.h"
int sData = 2 ;
int mData;

int main (){

	AXIS_STREAM axisSlave;
	AXIS_STREAM axisMaster;

	// Slave send data to master using AXI_STREAM Protocol

	axisSlave.data = sData;
	axisSlave.keep = 1;
	axisSlave.strb = 1;
	axisSlave.user = 1;
	axisSlave.last = 0;
	axisSlave.id = 0;
	axisSlave.dest = 1;

	axiStreamExample(axisSlave, &axisMaster);
	mData = axisMaster.data.to_int();

	if(mData != sData*5 ){
		printf("ERROR : mismatch between HW and SW results %d \n",mData);
		return EXIT_FAILURE;
	}
	printf("SUCCESS : match between HW and SW results \n");
	return EXIT_SUCCESS;
}
