	.file	"lab1.c"
	.text
	.globl	sse
	.type	sse, @function
sse:
.LFB509:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rcx
#APP
# 8 "lab1.c" 1
	movups (%rax), %xmm0
movups (%rdx), %xmm1
mulps %xmm1, %xmm0
movups %xmm0, (%rcx)

# 0 "" 2
#NO_APP
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE509:
	.size	sse, .-sse
	.globl	sequential
	.type	sequential, @function
sequential:
.LFB510:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	%ecx, -44(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L4
.L5:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm1
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	mulss	%xmm1, %xmm0
	movss	%xmm0, (%rax)
	addl	$1, -4(%rbp)
.L4:
	movl	-4(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl	.L5
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE510:
	.size	sequential, .-sequential
	.section	.rodata
.LC0:
	.string	"%f"
.LC1:
	.string	"; "
.LC2:
	.string	"}"
	.text
	.globl	print_massiv
	.type	print_massiv, @function
print_massiv:
.LFB511:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$123, %edi
	call	putchar@PLT
	movl	$0, -4(%rbp)
	jmp	.L8
.L10:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movss	(%rax), %xmm0
	pxor	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	movq	%xmm1, %rax
	movq	%rax, %xmm0
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	-28(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, -4(%rbp)
	jge	.L9
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L9:
	addl	$1, -4(%rbp)
.L8:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L10
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE511:
	.size	print_massiv, .-print_massiv
	.section	.rodata
.LC3:
	.string	"ru"
.LC6:
	.string	"\320\234\320\260\321\201\320\270\320\262 a:"
.LC7:
	.string	"\320\234\320\260\321\201\320\270\320\262 b:"
.LC8:
	.string	"%d\n"
.LC9:
	.string	"\320\234\320\260\321\201\320\270\320\262 c:"
	.align 8
.LC10:
	.string	"\n\320\241 \320\270\321\201\320\277\320\276\320\273\321\214\320\267\320\276\320\262\320\260\320\275\320\270\320\265\320\274 sse \320\270\320\275\321\201\321\202\321\200\321\203\320\272\321\206\320\270\320\271."
	.align 8
.LC11:
	.string	"\320\241\321\200\320\265\320\264\320\275\320\265\320\265 \320\262\321\200\320\265\320\274\321\217 \321\200\320\260\321\201\321\201\321\207\320\265\321\202\320\276\320\262: %f\n"
	.align 8
.LC12:
	.string	"\n\320\237\320\276\321\201\320\273\320\265\320\264\320\276\320\262\320\260\321\202\320\265\320\273\321\214\320\275\320\260\321\217 \320\277\321\200\320\276\320\263\321\200\320\260\320\274\320\274\320\260."
	.text
	.globl	main
	.type	main, @function
main:
.LFB512:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$136, %rsp
	.cfi_offset 3, -24
	movl	%edi, -132(%rbp)
	movq	%rsi, -144(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	%rsp, %rax
	movq	%rax, %rbx
	leaq	.LC3(%rip), %rax
	movq	%rax, %rsi
	movl	$6, %edi
	call	setlocale@PLT
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	movl	$4, -104(%rbp)
	movq	$1000000000, -96(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -128(%rbp)
	pxor	%xmm0, %xmm0
	movss	%xmm0, -124(%rbp)
	movl	-104(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -88(%rbp)
	cltq
	leaq	0(,%rax,4), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %esi
	movl	$0, %edx
	divq	%rsi
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L13:
	cmpq	%rdx, %rsp
	je	.L14
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L13
.L14:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L15
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L15:
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -80(%rbp)
	movl	-104(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -72(%rbp)
	cltq
	leaq	0(,%rax,4), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %esi
	movl	$0, %edx
	divq	%rsi
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L16:
	cmpq	%rdx, %rsp
	je	.L17
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L16
.L17:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L18
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L18:
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -64(%rbp)
	movl	-104(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -56(%rbp)
	cltq
	leaq	0(,%rax,4), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %esi
	movl	$0, %edx
	divq	%rsi
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L19:
	cmpq	%rdx, %rsp
	je	.L20
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L19
.L20:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L21
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L21:
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -48(%rbp)
	movl	$0, -120(%rbp)
	jmp	.L22
.L23:
	call	rand@PLT
	movslq	%eax, %rdx
	imulq	$1374389535, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$5, %edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	imull	$100, %edx, %ecx
	subl	%ecx, %eax
	movl	%eax, %edx
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%edx, %xmm0
	movss	.LC5(%rip), %xmm1
	divss	%xmm1, %xmm0
	movq	-80(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	%xmm0, (%rax,%rdx,4)
	call	rand@PLT
	movslq	%eax, %rdx
	imulq	$1374389535, %rdx, %rdx
	shrq	$32, %rdx
	sarl	$5, %edx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	imull	$100, %edx, %ecx
	subl	%ecx, %eax
	movl	%eax, %edx
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%edx, %xmm0
	movss	.LC5(%rip), %xmm1
	divss	%xmm1, %xmm0
	movq	-64(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	%xmm0, (%rax,%rdx,4)
	addl	$1, -120(%rbp)
.L22:
	movl	-120(%rbp), %eax
	cmpl	-104(%rbp), %eax
	jl	.L23
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	-104(%rbp), %edx
	movq	-80(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	print_massiv
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	-104(%rbp), %edx
	movq	-64(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	print_massiv
	movl	$10, -100(%rbp)
	movl	$0, -116(%rbp)
	jmp	.L24
.L29:
	movl	-116(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	call	clock@PLT
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -40(%rbp)
	movl	$0, -112(%rbp)
	jmp	.L25
.L26:
	movq	-48(%rbp), %rdx
	movq	-64(%rbp), %rcx
	movq	-80(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	sse
	addl	$1, -112(%rbp)
.L25:
	movl	-112(%rbp), %eax
	cltq
	cmpq	%rax, -96(%rbp)
	jg	.L26
	call	clock@PLT
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -32(%rbp)
	pxor	%xmm1, %xmm1
	cvtss2sd	-128(%rbp), %xmm1
	movsd	-32(%rbp), %xmm0
	subsd	-40(%rbp), %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -128(%rbp)
	call	clock@PLT
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -40(%rbp)
	movl	$0, -108(%rbp)
	jmp	.L27
.L28:
	movl	-104(%rbp), %ecx
	movq	-48(%rbp), %rdx
	movq	-64(%rbp), %rsi
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	sequential
	addl	$1, -108(%rbp)
.L27:
	movl	-108(%rbp), %eax
	cltq
	cmpq	%rax, -96(%rbp)
	jg	.L28
	call	clock@PLT
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, -32(%rbp)
	pxor	%xmm1, %xmm1
	cvtss2sd	-124(%rbp), %xmm1
	movsd	-32(%rbp), %xmm0
	subsd	-40(%rbp), %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -124(%rbp)
	addl	$1, -116(%rbp)
.L24:
	movl	-116(%rbp), %eax
	cmpl	-100(%rbp), %eax
	jl	.L29
	movl	-100(%rbp), %eax
	cltq
	imulq	$1000000, %rax, %rax
	pxor	%xmm1, %xmm1
	cvtsi2ssq	%rax, %xmm1
	movss	-128(%rbp), %xmm0
	divss	%xmm1, %xmm0
	movss	%xmm0, -128(%rbp)
	movl	-100(%rbp), %eax
	cltq
	imulq	$1000000, %rax, %rax
	pxor	%xmm1, %xmm1
	cvtsi2ssq	%rax, %xmm1
	movss	-124(%rbp), %xmm0
	divss	%xmm1, %xmm0
	movss	%xmm0, -124(%rbp)
	leaq	.LC9(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	-104(%rbp), %edx
	movq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	print_massiv
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	pxor	%xmm2, %xmm2
	cvtss2sd	-128(%rbp), %xmm2
	movq	%xmm2, %rax
	movq	%rax, %xmm0
	leaq	.LC11(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	leaq	.LC12(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	pxor	%xmm3, %xmm3
	cvtss2sd	-124(%rbp), %xmm3
	movq	%xmm3, %rax
	movq	%rax, %xmm0
	leaq	.LC11(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	%rbx, %rsp
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L31
	call	__stack_chk_fail@PLT
.L31:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE512:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC5:
	.long	1092616192
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
