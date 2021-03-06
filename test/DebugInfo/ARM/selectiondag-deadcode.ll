; RUN: llc -filetype=asm < %s | FileCheck %s
target triple = "thumbv7-apple-ios7.0.0"
%class.Matrix3.0.6.10 = type { [9 x float] }
define arm_aapcscc void @_Z9GetMatrixv(%class.Matrix3.0.6.10* noalias nocapture sret %agg.result) #0 {
  br i1 fcmp oeq (float fadd (float fadd (float fmul (float undef, float undef), float fmul (float undef, float undef)), float fmul (float undef, float undef)), float 0.000000e+00), label %_ZN7Vector39NormalizeEv.exit, label %1
  tail call arm_aapcscc void @_ZL4Sqrtd() #3
  br label %_ZN7Vector39NormalizeEv.exit
_ZN7Vector39NormalizeEv.exit:                     ; preds = %1, %0
  ; rdar://problem/15094721.
  ;
  ; When this (partially) dead use gets eliminated (and thus the def
  ; of the vreg holding %agg.result) the dbg_value becomes dangling
  ; and SelectionDAGISel crashes.  It should definitely not
  ; crash. Drop the dbg_value instead.
  ; CHECK-NOT: "matrix"
  tail call void @llvm.dbg.declare(metadata %class.Matrix3.0.6.10* %agg.result, metadata !45, metadata !MDExpression(DW_OP_deref))
  %2 = getelementptr inbounds %class.Matrix3.0.6.10, %class.Matrix3.0.6.10* %agg.result, i32 0, i32 0, i32 8
  ret void
}
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1
declare arm_aapcscc void @_ZL4Sqrtd() #2
!4 = !MDCompositeType(tag: DW_TAG_class_type, name: "Matrix3", line: 20, size: 288, align: 32, file: !5, identifier: "_ZTS7Matrix3")
!5 = !MDFile(filename: "test.ii", directory: "/Volumes/Data/radar/15094721")
!39 = !MDSubprogram(name: "GetMatrix", linkageName: "_Z9GetMatrixv", line: 32, isLocal: false, isDefinition: true, virtualIndex: 6, flags: DIFlagPrototyped, isOptimized: true, scopeLine: 32, file: !5, scope: !40, type: !41, function: void (%class.Matrix3.0.6.10*)* @_Z9GetMatrixv)
!40 = !MDFile(filename: "test.ii", directory: "/Volumes/Data/radar/15094721")
!41 = !MDSubroutineType(types: null)
!45 = !MDLocalVariable(tag: DW_TAG_auto_variable, name: "matrix", line: 35, scope: !39, file: !40, type: !4)
