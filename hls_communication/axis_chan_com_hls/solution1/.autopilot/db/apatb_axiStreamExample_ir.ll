; ModuleID = 'C:/Users/Zak/Desktop/master_2/projet/Program-synthesis-grom-Go-to-zyng-/hls_communication/axis_chan_com_hls/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.hls::axis" = type { %struct.ap_int, %struct.ap_uint, %struct.ap_uint, %struct.ap_uint.2, %struct.ap_uint.5, %struct.ap_uint.5, %struct.ap_uint.5 }
%struct.ap_int = type { %struct.ap_int_base }
%struct.ap_int_base = type { %struct.ssdm_int }
%struct.ssdm_int = type { i32 }
%struct.ap_uint = type { %struct.ap_int_base.0 }
%struct.ap_int_base.0 = type { %struct.ssdm_int.1 }
%struct.ssdm_int.1 = type { i4 }
%struct.ap_uint.2 = type { %struct.ap_int_base.3 }
%struct.ap_int_base.3 = type { %struct.ssdm_int.4 }
%struct.ssdm_int.4 = type { i2 }
%struct.ap_uint.5 = type { %struct.ap_int_base.6 }
%struct.ap_int_base.6 = type { %struct.ssdm_int.7 }
%struct.ssdm_int.7 = type { i1 }

; Function Attrs: noinline
define void @apatb_axiStreamExample_ir(%"struct.hls::axis"* %producer, %"struct.hls::axis"* %consumer) local_unnamed_addr #0 {
entry:
  %producer_copy = alloca [5 x %"struct.hls::axis"], align 512
  %consumer_copy = alloca [5 x %"struct.hls::axis"], align 512
  %0 = bitcast %"struct.hls::axis"* %producer to [5 x %"struct.hls::axis"]*
  %1 = bitcast %"struct.hls::axis"* %consumer to [5 x %"struct.hls::axis"]*
  call fastcc void @copy_in([5 x %"struct.hls::axis"]* %0, [5 x %"struct.hls::axis"]* nonnull align 512 %producer_copy, [5 x %"struct.hls::axis"]* %1, [5 x %"struct.hls::axis"]* nonnull align 512 %consumer_copy)
  %2 = getelementptr inbounds [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %producer_copy, i32 0, i32 0
  %3 = getelementptr inbounds [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %consumer_copy, i32 0, i32 0
  call void @apatb_axiStreamExample_hw(%"struct.hls::axis"* %2, %"struct.hls::axis"* %3)
  call fastcc void @copy_out([5 x %"struct.hls::axis"]* %0, [5 x %"struct.hls::axis"]* nonnull align 512 %producer_copy, [5 x %"struct.hls::axis"]* %1, [5 x %"struct.hls::axis"]* nonnull align 512 %consumer_copy)
  ret void
}

; Function Attrs: noinline
define internal fastcc void @copy_in([5 x %"struct.hls::axis"]*, [5 x %"struct.hls::axis"]* noalias align 512, [5 x %"struct.hls::axis"]*, [5 x %"struct.hls::axis"]* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a5struct.hls::axis"([5 x %"struct.hls::axis"]* align 512 %1, [5 x %"struct.hls::axis"]* %0)
  call fastcc void @"onebyonecpy_hls.p0a5struct.hls::axis"([5 x %"struct.hls::axis"]* align 512 %3, [5 x %"struct.hls::axis"]* %2)
  ret void
}

; Function Attrs: noinline
define internal fastcc void @"onebyonecpy_hls.p0a5struct.hls::axis"([5 x %"struct.hls::axis"]* noalias align 512, [5 x %"struct.hls::axis"]* noalias) unnamed_addr #2 {
entry:
  %2 = icmp eq [5 x %"struct.hls::axis"]* %0, null
  %3 = icmp eq [5 x %"struct.hls::axis"]* %1, null
  %4 = or i1 %2, %3
  br i1 %4, label %ret, label %copy

copy:                                             ; preds = %entry
  br label %for.loop

for.loop:                                         ; preds = %for.loop.head, %copy
  %for.loop.idx71 = phi i64 [ 0, %copy ], [ %for.loop.idx.next, %for.loop.head ]
  %src.addr.01 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 0
  %dst.addr.02 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 0
  %5 = bitcast %struct.ap_int* %src.addr.01 to i8*
  %6 = call i1 @fpga_fifo_exist_4(i8* %5)
  br i1 %6, label %7, label %8

; <label>:7:                                      ; preds = %for.loop
  call fastcc void @streamcpy_hls.p0struct.ap_int(%struct.ap_int* %dst.addr.02, %struct.ap_int* %src.addr.01)
  br label %19

; <label>:8:                                      ; preds = %for.loop
  %src.addr.0.03 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 0, i32 0
  %dst.addr.0.04 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 0, i32 0
  %9 = bitcast %struct.ap_int_base* %src.addr.0.03 to i8*
  %10 = call i1 @fpga_fifo_exist_4(i8* %9)
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %8
  call fastcc void @streamcpy_hls.p0struct.ap_int_base(%struct.ap_int_base* %dst.addr.0.04, %struct.ap_int_base* %src.addr.0.03)
  br label %19

; <label>:12:                                     ; preds = %8
  %src.addr.0.0.05 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 0, i32 0, i32 0
  %13 = bitcast %struct.ssdm_int* %src.addr.0.0.05 to i8*
  %14 = call i1 @fpga_fifo_exist_4(i8* %13)
  br i1 %14, label %15, label %16

; <label>:15:                                     ; preds = %12
  call fastcc void @streamcpy_hls.p0struct.ssdm_int(%struct.ssdm_int* %dst.addr.0.0.06, %struct.ssdm_int* %src.addr.0.0.05)
  br label %19

; <label>:16:                                     ; preds = %12
  %dst.addr.0.0.0.08.gep57 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 0, i32 0, i32 0, i32 0
  %17 = bitcast i32* %dst.addr.0.0.0.08.gep57 to i8*
  %src.addr.0.0.0.07.gep58 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 0, i32 0, i32 0, i32 0
  %18 = bitcast i32* %src.addr.0.0.0.07.gep58 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %17, i8* align 1 %18, i64 4, i1 false)
  br label %19

; <label>:19:                                     ; preds = %16, %15, %11, %7
  %src.addr.19 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 1
  %dst.addr.110 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 1
  %20 = bitcast %struct.ap_uint* %src.addr.19 to i8*
  %21 = call i1 @fpga_fifo_exist_1(i8* %20)
  br i1 %21, label %22, label %23

; <label>:22:                                     ; preds = %19
  call fastcc void @streamcpy_hls.p0struct.ap_uint(%struct.ap_uint* %dst.addr.110, %struct.ap_uint* %src.addr.19)
  br label %34

; <label>:23:                                     ; preds = %19
  %src.addr.1.011 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 1, i32 0
  %dst.addr.1.012 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 1, i32 0
  %24 = bitcast %struct.ap_int_base.0* %src.addr.1.011 to i8*
  %25 = call i1 @fpga_fifo_exist_1(i8* %24)
  br i1 %25, label %26, label %27

; <label>:26:                                     ; preds = %23
  call fastcc void @streamcpy_hls.p0struct.ap_int_base.0(%struct.ap_int_base.0* %dst.addr.1.012, %struct.ap_int_base.0* %src.addr.1.011)
  br label %34

; <label>:27:                                     ; preds = %23
  %src.addr.1.0.013 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 1, i32 0, i32 0
  %dst.addr.1.0.014 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 1, i32 0, i32 0
  %28 = bitcast %struct.ssdm_int.1* %src.addr.1.0.013 to i8*
  %29 = call i1 @fpga_fifo_exist_1(i8* %28)
  br i1 %29, label %30, label %31

; <label>:30:                                     ; preds = %27
  call fastcc void @streamcpy_hls.p0struct.ssdm_int.1(%struct.ssdm_int.1* %dst.addr.1.0.014, %struct.ssdm_int.1* %src.addr.1.0.013)
  br label %34

; <label>:31:                                     ; preds = %27
  %dst.addr.1.0.0.016.gep59 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 1, i32 0, i32 0, i32 0
  %32 = bitcast i4* %dst.addr.1.0.0.016.gep59 to i8*
  %src.addr.1.0.0.015.gep60 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 1, i32 0, i32 0, i32 0
  %33 = bitcast i4* %src.addr.1.0.0.015.gep60 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %32, i8* align 1 %33, i64 1, i1 false)
  br label %34

; <label>:34:                                     ; preds = %31, %30, %26, %22
  %src.addr.217 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 2
  %dst.addr.218 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 2
  %35 = bitcast %struct.ap_uint* %src.addr.217 to i8*
  %36 = call i1 @fpga_fifo_exist_1(i8* %35)
  br i1 %36, label %37, label %38

; <label>:37:                                     ; preds = %34
  call fastcc void @streamcpy_hls.p0struct.ap_uint(%struct.ap_uint* %dst.addr.218, %struct.ap_uint* %src.addr.217)
  br label %49

; <label>:38:                                     ; preds = %34
  %src.addr.2.019 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 2, i32 0
  %dst.addr.2.020 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 2, i32 0
  %39 = bitcast %struct.ap_int_base.0* %src.addr.2.019 to i8*
  %40 = call i1 @fpga_fifo_exist_1(i8* %39)
  br i1 %40, label %41, label %42

; <label>:41:                                     ; preds = %38
  call fastcc void @streamcpy_hls.p0struct.ap_int_base.0(%struct.ap_int_base.0* %dst.addr.2.020, %struct.ap_int_base.0* %src.addr.2.019)
  br label %49

; <label>:42:                                     ; preds = %38
  %src.addr.2.0.021 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 2, i32 0, i32 0
  %dst.addr.2.0.022 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 2, i32 0, i32 0
  %43 = bitcast %struct.ssdm_int.1* %src.addr.2.0.021 to i8*
  %44 = call i1 @fpga_fifo_exist_1(i8* %43)
  br i1 %44, label %45, label %46

; <label>:45:                                     ; preds = %42
  call fastcc void @streamcpy_hls.p0struct.ssdm_int.1(%struct.ssdm_int.1* %dst.addr.2.0.022, %struct.ssdm_int.1* %src.addr.2.0.021)
  br label %49

; <label>:46:                                     ; preds = %42
  %dst.addr.2.0.0.024.gep61 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 2, i32 0, i32 0, i32 0
  %47 = bitcast i4* %dst.addr.2.0.0.024.gep61 to i8*
  %src.addr.2.0.0.023.gep62 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 2, i32 0, i32 0, i32 0
  %48 = bitcast i4* %src.addr.2.0.0.023.gep62 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %47, i8* align 1 %48, i64 1, i1 false)
  br label %49

; <label>:49:                                     ; preds = %46, %45, %41, %37
  %src.addr.325 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 3
  %dst.addr.326 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 3
  %50 = bitcast %struct.ap_uint.2* %src.addr.325 to i8*
  %51 = call i1 @fpga_fifo_exist_1(i8* %50)
  br i1 %51, label %52, label %53

; <label>:52:                                     ; preds = %49
  call fastcc void @streamcpy_hls.p0struct.ap_uint.2(%struct.ap_uint.2* %dst.addr.326, %struct.ap_uint.2* %src.addr.325)
  br label %64

; <label>:53:                                     ; preds = %49
  %src.addr.3.027 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 3, i32 0
  %dst.addr.3.028 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 3, i32 0
  %54 = bitcast %struct.ap_int_base.3* %src.addr.3.027 to i8*
  %55 = call i1 @fpga_fifo_exist_1(i8* %54)
  br i1 %55, label %56, label %57

; <label>:56:                                     ; preds = %53
  call fastcc void @streamcpy_hls.p0struct.ap_int_base.3(%struct.ap_int_base.3* %dst.addr.3.028, %struct.ap_int_base.3* %src.addr.3.027)
  br label %64

; <label>:57:                                     ; preds = %53
  %src.addr.3.0.029 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 3, i32 0, i32 0
  %dst.addr.3.0.030 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 3, i32 0, i32 0
  %58 = bitcast %struct.ssdm_int.4* %src.addr.3.0.029 to i8*
  %59 = call i1 @fpga_fifo_exist_1(i8* %58)
  br i1 %59, label %60, label %61

; <label>:60:                                     ; preds = %57
  call fastcc void @streamcpy_hls.p0struct.ssdm_int.4(%struct.ssdm_int.4* %dst.addr.3.0.030, %struct.ssdm_int.4* %src.addr.3.0.029)
  br label %64

; <label>:61:                                     ; preds = %57
  %dst.addr.3.0.0.032.gep63 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 3, i32 0, i32 0, i32 0
  %62 = bitcast i2* %dst.addr.3.0.0.032.gep63 to i8*
  %src.addr.3.0.0.031.gep64 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 3, i32 0, i32 0, i32 0
  %63 = bitcast i2* %src.addr.3.0.0.031.gep64 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %62, i8* align 1 %63, i64 1, i1 false)
  br label %64

; <label>:64:                                     ; preds = %61, %60, %56, %52
  %src.addr.433 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 4
  %dst.addr.434 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 4
  %65 = bitcast %struct.ap_uint.5* %src.addr.433 to i8*
  %66 = call i1 @fpga_fifo_exist_1(i8* %65)
  br i1 %66, label %67, label %68

; <label>:67:                                     ; preds = %64
  call fastcc void @streamcpy_hls.p0struct.ap_uint.5(%struct.ap_uint.5* %dst.addr.434, %struct.ap_uint.5* %src.addr.433)
  br label %79

; <label>:68:                                     ; preds = %64
  %src.addr.4.035 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 4, i32 0
  %dst.addr.4.036 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 4, i32 0
  %69 = bitcast %struct.ap_int_base.6* %src.addr.4.035 to i8*
  %70 = call i1 @fpga_fifo_exist_1(i8* %69)
  br i1 %70, label %71, label %72

; <label>:71:                                     ; preds = %68
  call fastcc void @streamcpy_hls.p0struct.ap_int_base.6(%struct.ap_int_base.6* %dst.addr.4.036, %struct.ap_int_base.6* %src.addr.4.035)
  br label %79

; <label>:72:                                     ; preds = %68
  %src.addr.4.0.037 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 4, i32 0, i32 0
  %dst.addr.4.0.038 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 4, i32 0, i32 0
  %73 = bitcast %struct.ssdm_int.7* %src.addr.4.0.037 to i8*
  %74 = call i1 @fpga_fifo_exist_1(i8* %73)
  br i1 %74, label %75, label %76

; <label>:75:                                     ; preds = %72
  call fastcc void @streamcpy_hls.p0struct.ssdm_int.7(%struct.ssdm_int.7* %dst.addr.4.0.038, %struct.ssdm_int.7* %src.addr.4.0.037)
  br label %79

; <label>:76:                                     ; preds = %72
  %dst.addr.4.0.0.040.gep65 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 4, i32 0, i32 0, i32 0
  %77 = bitcast i1* %dst.addr.4.0.0.040.gep65 to i8*
  %src.addr.4.0.0.039.gep66 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 4, i32 0, i32 0, i32 0
  %78 = bitcast i1* %src.addr.4.0.0.039.gep66 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %77, i8* align 1 %78, i64 1, i1 false)
  br label %79

; <label>:79:                                     ; preds = %76, %75, %71, %67
  %src.addr.541 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 5
  %dst.addr.542 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 5
  %80 = bitcast %struct.ap_uint.5* %src.addr.541 to i8*
  %81 = call i1 @fpga_fifo_exist_1(i8* %80)
  br i1 %81, label %82, label %83

; <label>:82:                                     ; preds = %79
  call fastcc void @streamcpy_hls.p0struct.ap_uint.5(%struct.ap_uint.5* %dst.addr.542, %struct.ap_uint.5* %src.addr.541)
  br label %94

; <label>:83:                                     ; preds = %79
  %src.addr.5.043 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 5, i32 0
  %dst.addr.5.044 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 5, i32 0
  %84 = bitcast %struct.ap_int_base.6* %src.addr.5.043 to i8*
  %85 = call i1 @fpga_fifo_exist_1(i8* %84)
  br i1 %85, label %86, label %87

; <label>:86:                                     ; preds = %83
  call fastcc void @streamcpy_hls.p0struct.ap_int_base.6(%struct.ap_int_base.6* %dst.addr.5.044, %struct.ap_int_base.6* %src.addr.5.043)
  br label %94

; <label>:87:                                     ; preds = %83
  %src.addr.5.0.045 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 5, i32 0, i32 0
  %dst.addr.5.0.046 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 5, i32 0, i32 0
  %88 = bitcast %struct.ssdm_int.7* %src.addr.5.0.045 to i8*
  %89 = call i1 @fpga_fifo_exist_1(i8* %88)
  br i1 %89, label %90, label %91

; <label>:90:                                     ; preds = %87
  call fastcc void @streamcpy_hls.p0struct.ssdm_int.7(%struct.ssdm_int.7* %dst.addr.5.0.046, %struct.ssdm_int.7* %src.addr.5.0.045)
  br label %94

; <label>:91:                                     ; preds = %87
  %dst.addr.5.0.0.048.gep67 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 5, i32 0, i32 0, i32 0
  %92 = bitcast i1* %dst.addr.5.0.0.048.gep67 to i8*
  %src.addr.5.0.0.047.gep68 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 5, i32 0, i32 0, i32 0
  %93 = bitcast i1* %src.addr.5.0.0.047.gep68 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %92, i8* align 1 %93, i64 1, i1 false)
  br label %94

; <label>:94:                                     ; preds = %91, %90, %86, %82
  %src.addr.649 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 6
  %dst.addr.650 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 6
  %95 = bitcast %struct.ap_uint.5* %src.addr.649 to i8*
  %96 = call i1 @fpga_fifo_exist_1(i8* %95)
  br i1 %96, label %97, label %98

; <label>:97:                                     ; preds = %94
  call fastcc void @streamcpy_hls.p0struct.ap_uint.5(%struct.ap_uint.5* %dst.addr.650, %struct.ap_uint.5* %src.addr.649)
  br label %for.loop.head

; <label>:98:                                     ; preds = %94
  %src.addr.6.051 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 6, i32 0
  %dst.addr.6.052 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 6, i32 0
  %99 = bitcast %struct.ap_int_base.6* %src.addr.6.051 to i8*
  %100 = call i1 @fpga_fifo_exist_1(i8* %99)
  br i1 %100, label %101, label %102

; <label>:101:                                    ; preds = %98
  call fastcc void @streamcpy_hls.p0struct.ap_int_base.6(%struct.ap_int_base.6* %dst.addr.6.052, %struct.ap_int_base.6* %src.addr.6.051)
  br label %for.loop.head

; <label>:102:                                    ; preds = %98
  %src.addr.6.0.053 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 6, i32 0, i32 0
  %dst.addr.6.0.054 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 6, i32 0, i32 0
  %103 = bitcast %struct.ssdm_int.7* %src.addr.6.0.053 to i8*
  %104 = call i1 @fpga_fifo_exist_1(i8* %103)
  br i1 %104, label %105, label %106

; <label>:105:                                    ; preds = %102
  call fastcc void @streamcpy_hls.p0struct.ssdm_int.7(%struct.ssdm_int.7* %dst.addr.6.0.054, %struct.ssdm_int.7* %src.addr.6.0.053)
  br label %for.loop.head

; <label>:106:                                    ; preds = %102
  %dst.addr.6.0.0.056.gep69 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %0, i64 0, i64 %for.loop.idx71, i32 6, i32 0, i32 0, i32 0
  %107 = bitcast i1* %dst.addr.6.0.0.056.gep69 to i8*
  %src.addr.6.0.0.055.gep70 = getelementptr [5 x %"struct.hls::axis"], [5 x %"struct.hls::axis"]* %1, i64 0, i64 %for.loop.idx71, i32 6, i32 0, i32 0, i32 0
  %108 = bitcast i1* %src.addr.6.0.0.055.gep70 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %107, i8* align 1 %108, i64 1, i1 false)
  br label %for.loop.head

for.loop.head:                                    ; preds = %106, %105, %101, %97
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx71, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, 5
  br i1 %exitcond, label %for.loop, label %ret

ret:                                              ; preds = %for.loop.head, %entry
  ret void
}

declare i1 @fpga_fifo_exist_4(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_int(%struct.ap_int* noalias nocapture, %struct.ap_int* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_int
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_int* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_4(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_int* %2 to i8*
  %6 = bitcast %struct.ap_int* %1 to i8*
  call void @fpga_fifo_pop_4(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_int, %struct.ap_int* %2
  %8 = bitcast %struct.ap_int* %2 to i8*
  %9 = bitcast %struct.ap_int* %0 to i8*
  call void @fpga_fifo_push_4(i8* %8, i8* %9)
  br label %empty, !llvm.loop !5

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_int* %1 to i8*
  %11 = bitcast %struct.ap_int* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 4, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #4

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_int_base(%struct.ap_int_base* noalias nocapture, %struct.ap_int_base* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_int_base
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_int_base* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_4(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_int_base* %2 to i8*
  %6 = bitcast %struct.ap_int_base* %1 to i8*
  call void @fpga_fifo_pop_4(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_int_base, %struct.ap_int_base* %2
  %8 = bitcast %struct.ap_int_base* %2 to i8*
  %9 = bitcast %struct.ap_int_base* %0 to i8*
  call void @fpga_fifo_push_4(i8* %8, i8* %9)
  br label %empty, !llvm.loop !7

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_int_base* %1 to i8*
  %11 = bitcast %struct.ap_int_base* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 4, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ssdm_int(%struct.ssdm_int* noalias nocapture, %struct.ssdm_int* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ssdm_int
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ssdm_int* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_4(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ssdm_int* %2 to i8*
  %6 = bitcast %struct.ssdm_int* %1 to i8*
  call void @fpga_fifo_pop_4(i8* %5, i8* %6)
  %7 = load volatile %struct.ssdm_int, %struct.ssdm_int* %2
  %8 = bitcast %struct.ssdm_int* %2 to i8*
  %9 = bitcast %struct.ssdm_int* %0 to i8*
  call void @fpga_fifo_push_4(i8* %8, i8* %9)
  br label %empty, !llvm.loop !8

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ssdm_int* %1 to i8*
  %11 = bitcast %struct.ssdm_int* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 4, i1 false)
  ret void
}

declare i1 @fpga_fifo_exist_1(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_uint(%struct.ap_uint* noalias nocapture, %struct.ap_uint* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_uint
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_uint* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_uint* %2 to i8*
  %6 = bitcast %struct.ap_uint* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_uint, %struct.ap_uint* %2
  %8 = bitcast %struct.ap_uint* %2 to i8*
  %9 = bitcast %struct.ap_uint* %0 to i8*
  call void @fpga_fifo_push_1(i8* %8, i8* %9)
  br label %empty, !llvm.loop !9

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_uint* %1 to i8*
  %11 = bitcast %struct.ap_uint* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 1, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_int_base.0(%struct.ap_int_base.0* noalias nocapture, %struct.ap_int_base.0* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_int_base.0
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_int_base.0* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_int_base.0* %2 to i8*
  %6 = bitcast %struct.ap_int_base.0* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_int_base.0, %struct.ap_int_base.0* %2
  %8 = bitcast %struct.ap_int_base.0* %2 to i8*
  %9 = bitcast %struct.ap_int_base.0* %0 to i8*
  call void @fpga_fifo_push_1(i8* %8, i8* %9)
  br label %empty, !llvm.loop !10

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_int_base.0* %1 to i8*
  %11 = bitcast %struct.ap_int_base.0* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 1, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ssdm_int.1(%struct.ssdm_int.1* noalias nocapture, %struct.ssdm_int.1* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ssdm_int.1
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ssdm_int.1* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ssdm_int.1* %2 to i8*
  %6 = bitcast %struct.ssdm_int.1* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %5, i8* %6)
  %7 = load volatile %struct.ssdm_int.1, %struct.ssdm_int.1* %2
  %8 = bitcast %struct.ssdm_int.1* %2 to i8*
  %9 = bitcast %struct.ssdm_int.1* %0 to i8*
  call void @fpga_fifo_push_1(i8* %8, i8* %9)
  br label %empty, !llvm.loop !11

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ssdm_int.1* %1 to i8*
  %11 = bitcast %struct.ssdm_int.1* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 1, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_uint.2(%struct.ap_uint.2* noalias nocapture, %struct.ap_uint.2* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_uint.2
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_uint.2* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_uint.2* %2 to i8*
  %6 = bitcast %struct.ap_uint.2* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_uint.2, %struct.ap_uint.2* %2
  %8 = bitcast %struct.ap_uint.2* %2 to i8*
  %9 = bitcast %struct.ap_uint.2* %0 to i8*
  call void @fpga_fifo_push_1(i8* %8, i8* %9)
  br label %empty, !llvm.loop !12

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_uint.2* %1 to i8*
  %11 = bitcast %struct.ap_uint.2* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 1, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_int_base.3(%struct.ap_int_base.3* noalias nocapture, %struct.ap_int_base.3* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_int_base.3
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_int_base.3* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_int_base.3* %2 to i8*
  %6 = bitcast %struct.ap_int_base.3* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_int_base.3, %struct.ap_int_base.3* %2
  %8 = bitcast %struct.ap_int_base.3* %2 to i8*
  %9 = bitcast %struct.ap_int_base.3* %0 to i8*
  call void @fpga_fifo_push_1(i8* %8, i8* %9)
  br label %empty, !llvm.loop !13

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_int_base.3* %1 to i8*
  %11 = bitcast %struct.ap_int_base.3* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 1, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ssdm_int.4(%struct.ssdm_int.4* noalias nocapture, %struct.ssdm_int.4* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ssdm_int.4
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ssdm_int.4* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ssdm_int.4* %2 to i8*
  %6 = bitcast %struct.ssdm_int.4* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %5, i8* %6)
  %7 = load volatile %struct.ssdm_int.4, %struct.ssdm_int.4* %2
  %8 = bitcast %struct.ssdm_int.4* %2 to i8*
  %9 = bitcast %struct.ssdm_int.4* %0 to i8*
  call void @fpga_fifo_push_1(i8* %8, i8* %9)
  br label %empty, !llvm.loop !14

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ssdm_int.4* %1 to i8*
  %11 = bitcast %struct.ssdm_int.4* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 1, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_uint.5(%struct.ap_uint.5* noalias nocapture, %struct.ap_uint.5* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_uint.5
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_uint.5* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_uint.5* %2 to i8*
  %6 = bitcast %struct.ap_uint.5* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_uint.5, %struct.ap_uint.5* %2
  %8 = bitcast %struct.ap_uint.5* %2 to i8*
  %9 = bitcast %struct.ap_uint.5* %0 to i8*
  call void @fpga_fifo_push_1(i8* %8, i8* %9)
  br label %empty, !llvm.loop !15

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_uint.5* %1 to i8*
  %11 = bitcast %struct.ap_uint.5* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 1, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ap_int_base.6(%struct.ap_int_base.6* noalias nocapture, %struct.ap_int_base.6* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ap_int_base.6
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ap_int_base.6* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ap_int_base.6* %2 to i8*
  %6 = bitcast %struct.ap_int_base.6* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %5, i8* %6)
  %7 = load volatile %struct.ap_int_base.6, %struct.ap_int_base.6* %2
  %8 = bitcast %struct.ap_int_base.6* %2 to i8*
  %9 = bitcast %struct.ap_int_base.6* %0 to i8*
  call void @fpga_fifo_push_1(i8* %8, i8* %9)
  br label %empty, !llvm.loop !16

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ap_int_base.6* %1 to i8*
  %11 = bitcast %struct.ap_int_base.6* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 1, i1 false)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @streamcpy_hls.p0struct.ssdm_int.7(%struct.ssdm_int.7* noalias nocapture, %struct.ssdm_int.7* noalias nocapture) unnamed_addr #3 {
entry:
  %2 = alloca %struct.ssdm_int.7
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %struct.ssdm_int.7* %1 to i8*
  %4 = call i1 @fpga_fifo_not_empty_1(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %struct.ssdm_int.7* %2 to i8*
  %6 = bitcast %struct.ssdm_int.7* %1 to i8*
  call void @fpga_fifo_pop_1(i8* %5, i8* %6)
  %7 = load volatile %struct.ssdm_int.7, %struct.ssdm_int.7* %2
  %8 = bitcast %struct.ssdm_int.7* %2 to i8*
  %9 = bitcast %struct.ssdm_int.7* %0 to i8*
  call void @fpga_fifo_push_1(i8* %8, i8* %9)
  br label %empty, !llvm.loop !17

ret:                                              ; preds = %empty
  %10 = bitcast %struct.ssdm_int.7* %1 to i8*
  %11 = bitcast %struct.ssdm_int.7* %0 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %11, i8* align 1 %10, i64 1, i1 false)
  ret void
}

; Function Attrs: noinline
define internal fastcc void @copy_out([5 x %"struct.hls::axis"]*, [5 x %"struct.hls::axis"]* noalias align 512, [5 x %"struct.hls::axis"]*, [5 x %"struct.hls::axis"]* noalias align 512) unnamed_addr #5 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a5struct.hls::axis"([5 x %"struct.hls::axis"]* %0, [5 x %"struct.hls::axis"]* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0a5struct.hls::axis"([5 x %"struct.hls::axis"]* %2, [5 x %"struct.hls::axis"]* align 512 %3)
  ret void
}

declare void @apatb_axiStreamExample_hw(%"struct.hls::axis"*, %"struct.hls::axis"*)

define void @axiStreamExample_hw_stub_wrapper(%"struct.hls::axis"*, %"struct.hls::axis"*) #6 {
entry:
  %2 = bitcast %"struct.hls::axis"* %0 to [5 x %"struct.hls::axis"]*
  %3 = bitcast %"struct.hls::axis"* %1 to [5 x %"struct.hls::axis"]*
  call void @copy_out([5 x %"struct.hls::axis"]* null, [5 x %"struct.hls::axis"]* %2, [5 x %"struct.hls::axis"]* null, [5 x %"struct.hls::axis"]* %3)
  %4 = bitcast [5 x %"struct.hls::axis"]* %2 to %"struct.hls::axis"*
  %5 = bitcast [5 x %"struct.hls::axis"]* %3 to %"struct.hls::axis"*
  call void @axiStreamExample_hw_stub(%"struct.hls::axis"* %4, %"struct.hls::axis"* %5)
  call void @copy_in([5 x %"struct.hls::axis"]* null, [5 x %"struct.hls::axis"]* %2, [5 x %"struct.hls::axis"]* null, [5 x %"struct.hls::axis"]* %3)
  ret void
}

declare void @axiStreamExample_hw_stub(%"struct.hls::axis"*, %"struct.hls::axis"*)

declare i1 @fpga_fifo_not_empty_4(i8*)

declare i1 @fpga_fifo_not_empty_1(i8*)

declare void @fpga_fifo_pop_4(i8*, i8*)

declare void @fpga_fifo_pop_1(i8*, i8*)

declare void @fpga_fifo_push_4(i8*, i8*)

declare void @fpga_fifo_push_1(i8*, i8*)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { noinline "fpga.wrapper.func"="copyin" }
attributes #2 = { noinline "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline "fpga.wrapper.func"="streamcpy_hls" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { noinline "fpga.wrapper.func"="copyout" }
attributes #6 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.rotate.disable"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
!10 = distinct !{!10, !6}
!11 = distinct !{!11, !6}
!12 = distinct !{!12, !6}
!13 = distinct !{!13, !6}
!14 = distinct !{!14, !6}
!15 = distinct !{!15, !6}
!16 = distinct !{!16, !6}
!17 = distinct !{!17, !6}
