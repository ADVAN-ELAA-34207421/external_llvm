; RUN: llc -enable-dwarf-directory -mtriple x86_64-apple-darwin10.0.0  < %s | FileCheck %s

; Radar 8884898
; CHECK: file	1 "simple.c"

declare i32 @printf(i8*, ...) nounwind

define i32 @main() nounwind {
  ret i32 0
}

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!12}

!1 = !MDFile(filename: "simple.c", directory: "/Users/manav/one/two")
!2 = !MDCompileUnit(language: DW_LANG_C89, producer: "LLVM build 00", isOptimized: true, emissionKind: 0, file: !10, enums: !11, retainedTypes: !11, subprograms: !9)
!5 = !MDBasicType(tag: DW_TAG_base_type, name: "int", size: 32, align: 32, encoding: DW_ATE_signed)
!6 = !MDSubprogram(name: "main", linkageName: "main", line: 9, isLocal: false, isDefinition: true, virtualIndex: 6, flags: DIFlagPrototyped, isOptimized: false, file: !10, scope: !1, type: !7, function: i32 ()* @main)
!7 = !MDSubroutineType(types: !8)
!8 = !{!5}
!9 = !{!6}
!10 = !MDFile(filename: "simple.c", directory: "/Users/manav/one/two")
!11 = !{}
!12 = !{i32 1, !"Debug Info Version", i32 3}
