; ModuleID = 'example.4hello.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"%d \0A\00", align 1
@.str2 = private unnamed_addr constant [11 x i8] c"(x+1)^4 = \00", align 1
@.str3 = private unnamed_addr constant [11 x i8] c"(x-1)^4 = \00", align 1
@global_variable = common global i32 0, align 4

; Function Attrs: nounwind uwtable
define void @pop_direct_branch() #0 {
  call void asm sideeffect "popq %rbp\0A\09addq $$8, %rsp\0A\09leave\0A\09movq (%rsp), %rax\0A\09addq $$8, %rsp\0A\09jmp *%rax\0A\09", "~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !1
  ret void
}

; Function Attrs: nounwind uwtable
define void @scan_int(i32* %x) #0 {
  %1 = alloca i32*, align 8
  store i32* %x, i32** %1, align 8
  %2 = load i32** %1, align 8
  %3 = call i32 (i8*, ...)* @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %2)
  ret void
}

declare i32 @__isoc99_scanf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define i32 @pow2(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  ret i32 %4
}

; Function Attrs: nounwind uwtable
define i32 @pow3(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  %5 = load i32* %1, align 4
  %6 = mul nsw i32 %4, %5
  ret i32 %6
}

; Function Attrs: nounwind uwtable
define void @pow4(i32* %x) #0 {
  %1 = alloca i32*, align 8
  %p2 = alloca i32, align 4
  store i32* %x, i32** %1, align 8
  %2 = load i32** %1, align 8
  %3 = load i32* %2, align 4
  %4 = call i32 @pow21(i32 %3)
  store i32 %4, i32* %p2, align 4
  %5 = load i32* @global_variable, align 4
  store i32 %5, i32* %p2, align 4
  %6 = load i32* %p2, align 4
  %7 = load i32* %p2, align 4
  %8 = mul nsw i32 %6, %7
  %9 = load i32** %1, align 8
  store i32 %8, i32* %9, align 4
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @polynomial(i32 %y) #0 {
  %1 = alloca i32, align 4
  %p2 = alloca i32, align 4
  %p3 = alloca i32, align 4
  %p4 = alloca i32, align 4
  store i32 %y, i32* %1, align 4
  %2 = load i32* %1, align 4
  store i32 %2, i32* %p4, align 4
  %3 = load i32* %1, align 4
  %4 = call i32 @pow22(i32 %3)
  store i32 %4, i32* %p2, align 4
  %5 = load i32* @global_variable, align 4
  store i32 %5, i32* %p2, align 4
  %6 = load i32* %1, align 4
  %7 = call i32 @pow33(i32 %6)
  store i32 %7, i32* %p3, align 4
  %8 = load i32* @global_variable, align 4
  store i32 %8, i32* %p3, align 4
  call void @pow44(i32* %p4)
  %9 = load i32* %p4, align 4
  %10 = load i32* %p3, align 4
  %11 = mul nsw i32 4, %10
  %12 = add nsw i32 %9, %11
  %13 = load i32* %p2, align 4
  %14 = mul nsw i32 6, %13
  %15 = add nsw i32 %12, %14
  %16 = load i32* %1, align 4
  %17 = mul nsw i32 4, %16
  %18 = add nsw i32 %15, %17
  %19 = add nsw i32 %18, 1
  ret i32 %19
}

; Function Attrs: nounwind uwtable
define i32 @second_polynomial(i32 %x) #0 {
  %1 = alloca i32, align 4
  %p = alloca i32, align 4
  %p3 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 @pow35(i32 %2)
  store i32 %3, i32* %p3, align 4
  %4 = load i32* @global_variable, align 4
  store i32 %4, i32* %p3, align 4
  %5 = load i32* %1, align 4
  %6 = call i32 @polynomial6(i32 %5)
  store i32 %6, i32* %p, align 4
  %7 = load i32* @global_variable, align 4
  store i32 %7, i32* %p, align 4
  %8 = load i32* %p, align 4
  %9 = load i32* %p3, align 4
  %10 = mul nsw i32 8, %9
  %11 = sub nsw i32 %8, %10
  %12 = load i32* %1, align 4
  %13 = mul nsw i32 8, %12
  %14 = sub nsw i32 %11, %13
  ret i32 %14
}

; Function Attrs: nounwind uwtable
define void @print_int(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i32 0, i32 0), i32 %2)
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %a = alloca i32, align 4
  %p = alloca i32, align 4
  store i32 0, i32* %1
  call void @scan_int(i32* %a)
  %2 = load i32* %a, align 4
  %3 = call i32 @polynomial7(i32 %2)
  store i32 %3, i32* %p, align 4
  %4 = load i32* @global_variable, align 4
  store i32 %4, i32* %p, align 4
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str2, i32 0, i32 0))
  %6 = load i32* %p, align 4
  call void @print_int8(i32 %6)
  %7 = load i32* %a, align 4
  %8 = call i32 @second_polynomial(i32 %7)
  store i32 %8, i32* %p, align 4
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str3, i32 0, i32 0))
  %10 = load i32* %p, align 4
  call void @print_int9(i32 %10)
  ret i32 0
}

; Function Attrs: nounwind uwtable
define internal i32 @pow21(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  store i32 %4, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %4
}

; Function Attrs: nounwind uwtable
define internal i32 @pow22(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  store i32 %4, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %4
}

; Function Attrs: nounwind uwtable
define internal i32 @pow33(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  %5 = load i32* %1, align 4
  %6 = mul nsw i32 %4, %5
  store i32 %6, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %6
}

; Function Attrs: nounwind uwtable
define internal void @pow44(i32* %x) #0 {
  %1 = alloca i32*, align 8
  %p2 = alloca i32, align 4
  store i32* %x, i32** %1, align 8
  %2 = load i32** %1, align 8
  %3 = load i32* %2, align 4
  %4 = call i32 @pow2110(i32 %3)
  store i32 %4, i32* %p2, align 4
  %5 = load i32* @global_variable, align 4
  store i32 %5, i32* %p2, align 4
  %6 = load i32* %p2, align 4
  %7 = load i32* %p2, align 4
  %8 = mul nsw i32 %6, %7
  %9 = load i32** %1, align 8
  store i32 %8, i32* %9, align 4
  call void @pop_direct_branch()
  ret void
}

; Function Attrs: nounwind uwtable
define internal i32 @pow35(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  %5 = load i32* %1, align 4
  %6 = mul nsw i32 %4, %5
  store i32 %6, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %6
}

; Function Attrs: nounwind uwtable
define internal i32 @polynomial6(i32 %y) #0 {
  %1 = alloca i32, align 4
  %p2 = alloca i32, align 4
  %p3 = alloca i32, align 4
  %p4 = alloca i32, align 4
  store i32 %y, i32* %1, align 4
  %2 = load i32* %1, align 4
  store i32 %2, i32* %p4, align 4
  %3 = load i32* %1, align 4
  %4 = call i32 @pow2211(i32 %3)
  store i32 %4, i32* %p2, align 4
  %5 = load i32* @global_variable, align 4
  store i32 %5, i32* %p2, align 4
  %6 = load i32* %1, align 4
  %7 = call i32 @pow3312(i32 %6)
  store i32 %7, i32* %p3, align 4
  %8 = load i32* @global_variable, align 4
  store i32 %8, i32* %p3, align 4
  call void @pow4413(i32* %p4)
  %9 = load i32* %p4, align 4
  %10 = load i32* %p3, align 4
  %11 = mul nsw i32 4, %10
  %12 = add nsw i32 %9, %11
  %13 = load i32* %p2, align 4
  %14 = mul nsw i32 6, %13
  %15 = add nsw i32 %12, %14
  %16 = load i32* %1, align 4
  %17 = mul nsw i32 4, %16
  %18 = add nsw i32 %15, %17
  %19 = add nsw i32 %18, 1
  store i32 %19, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %19
}

; Function Attrs: nounwind uwtable
define internal i32 @polynomial7(i32 %y) #0 {
  %1 = alloca i32, align 4
  %p2 = alloca i32, align 4
  %p3 = alloca i32, align 4
  %p4 = alloca i32, align 4
  store i32 %y, i32* %1, align 4
  %2 = load i32* %1, align 4
  store i32 %2, i32* %p4, align 4
  %3 = load i32* %1, align 4
  %4 = call i32 @pow2214(i32 %3)
  store i32 %4, i32* %p2, align 4
  %5 = load i32* @global_variable, align 4
  store i32 %5, i32* %p2, align 4
  %6 = load i32* %1, align 4
  %7 = call i32 @pow3315(i32 %6)
  store i32 %7, i32* %p3, align 4
  %8 = load i32* @global_variable, align 4
  store i32 %8, i32* %p3, align 4
  call void @pow4416(i32* %p4)
  %9 = load i32* %p4, align 4
  %10 = load i32* %p3, align 4
  %11 = mul nsw i32 4, %10
  %12 = add nsw i32 %9, %11
  %13 = load i32* %p2, align 4
  %14 = mul nsw i32 6, %13
  %15 = add nsw i32 %12, %14
  %16 = load i32* %1, align 4
  %17 = mul nsw i32 4, %16
  %18 = add nsw i32 %15, %17
  %19 = add nsw i32 %18, 1
  store i32 %19, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %19
}

; Function Attrs: nounwind uwtable
define internal void @print_int8(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i32 0, i32 0), i32 %2)
  call void @pop_direct_branch()
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @print_int9(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str1, i32 0, i32 0), i32 %2)
  call void @pop_direct_branch()
  ret void
}

; Function Attrs: nounwind uwtable
define internal i32 @pow2110(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  store i32 %4, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %4
}

; Function Attrs: nounwind uwtable
define internal i32 @pow2211(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  store i32 %4, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %4
}

; Function Attrs: nounwind uwtable
define internal i32 @pow3312(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  %5 = load i32* %1, align 4
  %6 = mul nsw i32 %4, %5
  store i32 %6, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %6
}

; Function Attrs: nounwind uwtable
define internal void @pow4413(i32* %x) #0 {
  %1 = alloca i32*, align 8
  %p2 = alloca i32, align 4
  store i32* %x, i32** %1, align 8
  %2 = load i32** %1, align 8
  %3 = load i32* %2, align 4
  %4 = call i32 @pow211017(i32 %3)
  store i32 %4, i32* %p2, align 4
  %5 = load i32* @global_variable, align 4
  store i32 %5, i32* %p2, align 4
  %6 = load i32* %p2, align 4
  %7 = load i32* %p2, align 4
  %8 = mul nsw i32 %6, %7
  %9 = load i32** %1, align 8
  store i32 %8, i32* %9, align 4
  call void @pop_direct_branch()
  ret void
}

; Function Attrs: nounwind uwtable
define internal i32 @pow2214(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  store i32 %4, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %4
}

; Function Attrs: nounwind uwtable
define internal i32 @pow3315(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  %5 = load i32* %1, align 4
  %6 = mul nsw i32 %4, %5
  store i32 %6, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %6
}

; Function Attrs: nounwind uwtable
define internal void @pow4416(i32* %x) #0 {
  %1 = alloca i32*, align 8
  %p2 = alloca i32, align 4
  store i32* %x, i32** %1, align 8
  %2 = load i32** %1, align 8
  %3 = load i32* %2, align 4
  %4 = call i32 @pow211018(i32 %3)
  store i32 %4, i32* %p2, align 4
  %5 = load i32* @global_variable, align 4
  store i32 %5, i32* %p2, align 4
  %6 = load i32* %p2, align 4
  %7 = load i32* %p2, align 4
  %8 = mul nsw i32 %6, %7
  %9 = load i32** %1, align 8
  store i32 %8, i32* %9, align 4
  call void @pop_direct_branch()
  ret void
}

; Function Attrs: nounwind uwtable
define internal i32 @pow211017(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  store i32 %4, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %4
}

; Function Attrs: nounwind uwtable
define internal i32 @pow211018(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = load i32* %1, align 4
  %4 = mul nsw i32 %2, %3
  store i32 %4, i32* @global_variable, align 4
  call void @pop_direct_branch()
  ret i32 %4
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
!1 = metadata !{i32 152331, i32 152343, i32 152369, i32 152387, i32 152417, i32 152443, i32 152465}
