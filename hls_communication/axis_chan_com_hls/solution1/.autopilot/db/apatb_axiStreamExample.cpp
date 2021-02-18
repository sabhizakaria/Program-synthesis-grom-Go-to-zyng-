#include <systemc>
#include <iostream>
#include <cstdlib>
#include <cstddef>
#include <stdint.h>
#include "SysCFileHandler.h"
#include "ap_int.h"
#include "ap_fixed.h"
#include <complex>
#include <stdbool.h>
#include "autopilot_cbe.h"
#include "hls_stream.h"
#include "hls_half.h"
#include "hls_signal_handler.h"

using namespace std;
using namespace sc_core;
using namespace sc_dt;

// wrapc file define:
#define AUTOTB_TVIN_producer "../tv/cdatafile/c.axiStreamExample.autotvin_producer.dat"
#define AUTOTB_TVOUT_producer "../tv/cdatafile/c.axiStreamExample.autotvout_producer.dat"
// wrapc file define:
#define AUTOTB_TVIN_consumer "../tv/cdatafile/c.axiStreamExample.autotvin_consumer.dat"
#define AUTOTB_TVOUT_consumer "../tv/cdatafile/c.axiStreamExample.autotvout_consumer.dat"

#define INTER_TCL "../tv/cdatafile/ref.tcl"

// tvout file define:
#define AUTOTB_TVOUT_PC_producer "../tv/rtldatafile/rtl.axiStreamExample.autotvout_producer.dat"
// tvout file define:
#define AUTOTB_TVOUT_PC_consumer "../tv/rtldatafile/rtl.axiStreamExample.autotvout_consumer.dat"

class INTER_TCL_FILE {
  public:
INTER_TCL_FILE(const char* name) {
  mName = name; 
  producer_depth = 0;
  consumer_depth = 0;
  trans_num =0;
}
~INTER_TCL_FILE() {
  mFile.open(mName);
  if (!mFile.good()) {
    cout << "Failed to open file ref.tcl" << endl;
    exit (1); 
  }
  string total_list = get_depth_list();
  mFile << "set depth_list {\n";
  mFile << total_list;
  mFile << "}\n";
  mFile << "set trans_num "<<trans_num<<endl;
  mFile.close();
}
string get_depth_list () {
  stringstream total_list;
  total_list << "{producer " << producer_depth << "}\n";
  total_list << "{consumer " << consumer_depth << "}\n";
  return total_list.str();
}
void set_num (int num , int* class_num) {
  (*class_num) = (*class_num) > num ? (*class_num) : num;
}
void set_string(std::string list, std::string* class_list) {
  (*class_list) = list;
}
  public:
    int producer_depth;
    int consumer_depth;
    int trans_num;
  private:
    ofstream mFile;
    const char* mName;
};

static void RTLOutputCheckAndReplacement(std::string &AESL_token, std::string PortName) {
  bool no_x = false;
  bool err = false;

  no_x = false;
  // search and replace 'X' with '0' from the 3rd char of token
  while (!no_x) {
    size_t x_found = AESL_token.find('X', 0);
    if (x_found != string::npos) {
      if (!err) { 
        cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'X' on port" 
             << PortName << ", possible cause: There are uninitialized variables in the C design."
             << endl; 
        err = true;
      }
      AESL_token.replace(x_found, 1, "0");
    } else
      no_x = true;
  }
  no_x = false;
  // search and replace 'x' with '0' from the 3rd char of token
  while (!no_x) {
    size_t x_found = AESL_token.find('x', 2);
    if (x_found != string::npos) {
      if (!err) { 
        cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'x' on port" 
             << PortName << ", possible cause: There are uninitialized variables in the C design."
             << endl; 
        err = true;
      }
      AESL_token.replace(x_found, 1, "0");
    } else
      no_x = true;
  }
}
extern "C" void axiStreamExample_hw_stub_wrapper(volatile void *, volatile void *);

extern "C" void apatb_axiStreamExample_hw(volatile void * __xlx_apatb_param_producer, volatile void * __xlx_apatb_param_consumer) {
  refine_signal_handler();
  fstream wrapc_switch_file_token;
  wrapc_switch_file_token.open(".hls_cosim_wrapc_switch.log");
  int AESL_i;
  if (wrapc_switch_file_token.good())
  {

    CodeState = ENTER_WRAPC_PC;
    static unsigned AESL_transaction_pc = 0;
    string AESL_token;
    string AESL_num;{
      static ifstream rtl_tv_out_file;
      if (!rtl_tv_out_file.is_open()) {
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_producer);
        if (rtl_tv_out_file.good()) {
          rtl_tv_out_file >> AESL_token;
          if (AESL_token != "[[[runtime]]]")
            exit(1);
        }
      }
  
      if (rtl_tv_out_file.good()) {
        rtl_tv_out_file >> AESL_token; 
        rtl_tv_out_file >> AESL_num;  // transaction number
        if (AESL_token != "[[transaction]]") {
          cerr << "Unexpected token: " << AESL_token << endl;
          exit(1);
        }
        if (atoi(AESL_num.c_str()) == AESL_transaction_pc) {
          std::vector<sc_bv<8> > producer_pc_buffer(60);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "producer");
  
            // push token into output port buffer
            if (AESL_token != "") {
              producer_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {{
		    int i = 0;
            for (int j = 0, e = 60; j < e; j += 1, ++i) {
            ((char*)__xlx_apatb_param_producer)[j] = producer_pc_buffer[i].to_int64();
          }}}
        } // end transaction
      } // end file is good
    } // end post check logic bolck
  {
      static ifstream rtl_tv_out_file;
      if (!rtl_tv_out_file.is_open()) {
        rtl_tv_out_file.open(AUTOTB_TVOUT_PC_consumer);
        if (rtl_tv_out_file.good()) {
          rtl_tv_out_file >> AESL_token;
          if (AESL_token != "[[[runtime]]]")
            exit(1);
        }
      }
  
      if (rtl_tv_out_file.good()) {
        rtl_tv_out_file >> AESL_token; 
        rtl_tv_out_file >> AESL_num;  // transaction number
        if (AESL_token != "[[transaction]]") {
          cerr << "Unexpected token: " << AESL_token << endl;
          exit(1);
        }
        if (atoi(AESL_num.c_str()) == AESL_transaction_pc) {
          std::vector<sc_bv<8> > consumer_pc_buffer(60);
          int i = 0;

          rtl_tv_out_file >> AESL_token; //data
          while (AESL_token != "[[/transaction]]"){

            RTLOutputCheckAndReplacement(AESL_token, "consumer");
  
            // push token into output port buffer
            if (AESL_token != "") {
              consumer_pc_buffer[i] = AESL_token.c_str();;
              i++;
            }
  
            rtl_tv_out_file >> AESL_token; //data or [[/transaction]]
            if (AESL_token == "[[[/runtime]]]" || rtl_tv_out_file.eof())
              exit(1);
          }
          if (i > 0) {{
		    int i = 0;
            for (int j = 0, e = 60; j < e; j += 1, ++i) {
            ((char*)__xlx_apatb_param_consumer)[j] = consumer_pc_buffer[i].to_int64();
          }}}
        } // end transaction
      } // end file is good
    } // end post check logic bolck
  
    AESL_transaction_pc++;
    return ;
  }
static unsigned AESL_transaction;
static AESL_FILE_HANDLER aesl_fh;
static INTER_TCL_FILE tcl_file(INTER_TCL);
std::vector<char> __xlx_sprintf_buffer(1024);
CodeState = ENTER_WRAPC;
//producer
aesl_fh.touch(AUTOTB_TVIN_producer);
aesl_fh.touch(AUTOTB_TVOUT_producer);
//consumer
aesl_fh.touch(AUTOTB_TVIN_consumer);
aesl_fh.touch(AUTOTB_TVOUT_consumer);
CodeState = DUMP_INPUTS;
// print producer Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_producer, __xlx_sprintf_buffer.data());
    if (__xlx_apatb_param_producer) {
    for (int j = 0  - 0, e = 60 - 0; j != e; ++j) {
sc_bv<8> __xlx_tmp_lv = ((char*)__xlx_apatb_param_producer)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_producer, __xlx_sprintf_buffer.data()); 
      }
  }

  tcl_file.set_num(60, &tcl_file.producer_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_producer, __xlx_sprintf_buffer.data());
}
// print consumer Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVIN_consumer, __xlx_sprintf_buffer.data());
    if (__xlx_apatb_param_consumer) {
    for (int j = 0  - 0, e = 60 - 0; j != e; ++j) {
sc_bv<8> __xlx_tmp_lv = ((char*)__xlx_apatb_param_consumer)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVIN_consumer, __xlx_sprintf_buffer.data()); 
      }
  }

  tcl_file.set_num(60, &tcl_file.consumer_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVIN_consumer, __xlx_sprintf_buffer.data());
}
CodeState = CALL_C_DUT;
axiStreamExample_hw_stub_wrapper(__xlx_apatb_param_producer, __xlx_apatb_param_consumer);
CodeState = DUMP_OUTPUTS;
// print producer Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_producer, __xlx_sprintf_buffer.data());
    if (__xlx_apatb_param_producer) {
    for (int j = 0  - 0, e = 60 - 0; j != e; ++j) {
sc_bv<8> __xlx_tmp_lv = ((char*)__xlx_apatb_param_producer)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_producer, __xlx_sprintf_buffer.data()); 
      }
  }

  tcl_file.set_num(60, &tcl_file.producer_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_producer, __xlx_sprintf_buffer.data());
}
// print consumer Transactions
{
  sprintf(__xlx_sprintf_buffer.data(), "[[transaction]] %d\n", AESL_transaction);
  aesl_fh.write(AUTOTB_TVOUT_consumer, __xlx_sprintf_buffer.data());
    if (__xlx_apatb_param_consumer) {
    for (int j = 0  - 0, e = 60 - 0; j != e; ++j) {
sc_bv<8> __xlx_tmp_lv = ((char*)__xlx_apatb_param_consumer)[j];

    sprintf(__xlx_sprintf_buffer.data(), "%s\n", __xlx_tmp_lv.to_string(SC_HEX).c_str());
    aesl_fh.write(AUTOTB_TVOUT_consumer, __xlx_sprintf_buffer.data()); 
      }
  }

  tcl_file.set_num(60, &tcl_file.consumer_depth);
  sprintf(__xlx_sprintf_buffer.data(), "[[/transaction]] \n");
  aesl_fh.write(AUTOTB_TVOUT_consumer, __xlx_sprintf_buffer.data());
}
CodeState = DELETE_CHAR_BUFFERS;
AESL_transaction++;
tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
}
