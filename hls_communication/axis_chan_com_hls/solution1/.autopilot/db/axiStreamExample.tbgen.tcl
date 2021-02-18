set moduleName axiStreamExample
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type dataflow
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {axiStreamExample}
set C_modelType { void 0 }
set C_modelArgList {
	{ producer int 8 regular {axi_s 0 volatile  { producer Data } }  }
	{ consumer int 8 regular {axi_s 1 volatile  { consumer Data } }  }
}
set C_modelArgMapList {[ 
	{ "Name" : "producer", "interface" : "axis", "bitwidth" : 8, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "producer","cData": "char","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "consumer", "interface" : "axis", "bitwidth" : 8, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "consumer","cData": "char","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} ]}
# RTL Port declarations: 
set portNum 12
set portList { 
	{ producer_TDATA sc_in sc_lv 8 signal 0 } 
	{ consumer_TDATA sc_out sc_lv 8 signal 1 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ producer_TVALID sc_in sc_logic 1 invld 0 } 
	{ producer_TREADY sc_out sc_logic 1 inacc 0 } 
	{ consumer_TVALID sc_out sc_logic 1 outvld 1 } 
	{ consumer_TREADY sc_in sc_logic 1 outacc 1 } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
}
set NewPortList {[ 
	{ "name": "producer_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "producer", "role": "TDATA" }} , 
 	{ "name": "consumer_TDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "consumer", "role": "TDATA" }} , 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "producer_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "producer", "role": "TVALID" }} , 
 	{ "name": "producer_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "producer", "role": "TREADY" }} , 
 	{ "name": "consumer_TVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "consumer", "role": "TVALID" }} , 
 	{ "name": "consumer_TREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "outacc", "bundle":{"name": "consumer", "role": "TREADY" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "axiStreamExample",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Dataflow", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "1",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "56", "EstimateLatencyMax" : "56",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "1",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"InputProcess" : [
			{"ID" : "1", "Name" : "Loop_VITIS_LOOP_32_1_proc3_U0"}],
		"OutputProcess" : [
			{"ID" : "1", "Name" : "Loop_VITIS_LOOP_32_1_proc3_U0"}],
		"Port" : [
			{"Name" : "producer", "Type" : "Axis", "Direction" : "I",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "Loop_VITIS_LOOP_32_1_proc3_U0", "Port" : "producer"}]},
			{"Name" : "consumer", "Type" : "Axis", "Direction" : "O",
				"SubConnect" : [
					{"ID" : "1", "SubInstance" : "Loop_VITIS_LOOP_32_1_proc3_U0", "Port" : "consumer"}]}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.Loop_VITIS_LOOP_32_1_proc3_U0", "Parent" : "0", "Child" : ["2", "3", "4"],
		"CDFG" : "Loop_VITIS_LOOP_32_1_proc3",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "1", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "56", "EstimateLatencyMax" : "56",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "1",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "producer", "Type" : "Axis", "Direction" : "I",
				"BlockSignal" : [
					{"Name" : "producer_TDATA_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "consumer", "Type" : "Axis", "Direction" : "O",
				"BlockSignal" : [
					{"Name" : "consumer_TDATA_blk_n", "Type" : "RtlSignal"}]}]},
	{"ID" : "2", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_VITIS_LOOP_32_1_proc3_U0.mul_32s_3ns_32_2_1_U1", "Parent" : "1"},
	{"ID" : "3", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_VITIS_LOOP_32_1_proc3_U0.regslice_both_producer_U", "Parent" : "1"},
	{"ID" : "4", "Level" : "2", "Path" : "`AUTOTB_DUT_INST.Loop_VITIS_LOOP_32_1_proc3_U0.regslice_both_consumer_U", "Parent" : "1"}]}


set ArgLastReadFirstWriteLatency {
	axiStreamExample {
		producer {Type I LastRead 10 FirstWrite -1}
		consumer {Type O LastRead -1 FirstWrite 5}}
	Loop_VITIS_LOOP_32_1_proc3 {
		producer {Type I LastRead 10 FirstWrite -1}
		consumer {Type O LastRead -1 FirstWrite 5}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "56", "Max" : "56"}
	, {"Name" : "Interval", "Min" : "57", "Max" : "57"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	producer { axis {  { producer_TDATA in_data 0 8 }  { producer_TVALID in_vld 0 1 }  { producer_TREADY in_acc 1 1 } } }
	consumer { axis {  { consumer_TDATA out_data 1 8 }  { consumer_TVALID out_vld 1 1 }  { consumer_TREADY out_acc 0 1 } } }
}

set busDeadlockParameterList { 
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
