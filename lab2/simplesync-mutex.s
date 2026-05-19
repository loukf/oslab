	.file	"simplesync.c"
	.text
.Ltext0:
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"About to increase variable %d times\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Done increasing variable.\n"
	.text
	.p2align 4
	.globl	increase_fn
	.type	increase_fn, @function
increase_fn:
.LVL0:
.LFB23:
	.file 1 "simplesync.c"
	.loc 1 42 1 view -0
	.cfi_startproc
	.loc 1 43 2 view .LVU1
	.loc 1 44 2 view .LVU2
	.loc 1 42 1 is_stmt 0 view .LVU3
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	.loc 1 46 2 view .LVU4
	movl	$10000000, %edx
	leaq	.LC0(%rip), %rsi
	xorl	%eax, %eax
	.loc 1 42 1 view .LVU5
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
.LVL1:
	.loc 1 46 2 is_stmt 1 view .LVU6
	movq	stderr(%rip), %rdi
.LVL2:
	.loc 1 56 13 is_stmt 0 view .LVU7
	leaq	lock(%rip), %r12
	.loc 1 42 1 view .LVU8
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.loc 1 46 2 view .LVU9
	movl	$10000000, %ebx
	call	fprintf@PLT
.LVL3:
	.loc 1 47 2 is_stmt 1 view .LVU10
	.loc 1 47 14 view .LVU11
	.p2align 4,,10
	.p2align 3
.L2:
	.loc 1 48 3 view .LVU12
	.loc 1 56 13 view .LVU13
	movq	%r12, %rdi
	call	pthread_mutex_lock@PLT
.LVL4:
	.loc 1 57 4 view .LVU14
	.loc 1 57 7 is_stmt 0 view .LVU15
	movl	0(%rbp), %eax
	.loc 1 58 13 view .LVU16
	movq	%r12, %rdi
	.loc 1 57 4 view .LVU17
	addl	$1, %eax
	movl	%eax, 0(%rbp)
	.loc 1 58 13 is_stmt 1 view .LVU18
	call	pthread_mutex_unlock@PLT
.LVL5:
	.loc 1 47 21 view .LVU19
	.loc 1 47 14 view .LVU20
	.loc 1 47 2 is_stmt 0 view .LVU21
	subl	$1, %ebx
.LVL6:
	.loc 1 47 2 view .LVU22
	jne	.L2
	.loc 1 62 2 is_stmt 1 view .LVU23
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC1(%rip), %rdi
	call	fwrite@PLT
.LVL7:
	.loc 1 64 2 view .LVU24
	.loc 1 65 1 is_stmt 0 view .LVU25
	popq	%rbx
	.cfi_def_cfa_offset 24
.LVL8:
	.loc 1 65 1 view .LVU26
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
.LVL9:
	.loc 1 65 1 view .LVU27
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	increase_fn, .-increase_fn
	.section	.rodata.str1.8
	.align 8
.LC2:
	.string	"About to decrease variable %d times\n"
	.section	.rodata.str1.1
.LC3:
	.string	"Done decreasing variable.\n"
	.text
	.p2align 4
	.globl	decrease_fn
	.type	decrease_fn, @function
decrease_fn:
.LVL10:
.LFB24:
	.loc 1 68 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 69 2 view .LVU29
	.loc 1 70 2 view .LVU30
	.loc 1 68 1 is_stmt 0 view .LVU31
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	.loc 1 72 2 view .LVU32
	movl	$10000000, %edx
	leaq	.LC2(%rip), %rsi
	xorl	%eax, %eax
	.loc 1 68 1 view .LVU33
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
.LVL11:
	.loc 1 72 2 is_stmt 1 view .LVU34
	movq	stderr(%rip), %rdi
.LVL12:
	.loc 1 82 13 is_stmt 0 view .LVU35
	leaq	lock(%rip), %r12
	.loc 1 68 1 view .LVU36
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.loc 1 72 2 view .LVU37
	movl	$10000000, %ebx
	call	fprintf@PLT
.LVL13:
	.loc 1 73 2 is_stmt 1 view .LVU38
	.loc 1 73 14 view .LVU39
	.p2align 4,,10
	.p2align 3
.L7:
	.loc 1 74 3 view .LVU40
	.loc 1 82 13 view .LVU41
	movq	%r12, %rdi
	call	pthread_mutex_lock@PLT
.LVL14:
	.loc 1 83 4 view .LVU42
	.loc 1 83 7 is_stmt 0 view .LVU43
	movl	0(%rbp), %eax
	.loc 1 84 13 view .LVU44
	movq	%r12, %rdi
	.loc 1 83 4 view .LVU45
	subl	$1, %eax
	movl	%eax, 0(%rbp)
	.loc 1 84 13 is_stmt 1 view .LVU46
	call	pthread_mutex_unlock@PLT
.LVL15:
	.loc 1 73 21 view .LVU47
	.loc 1 73 14 view .LVU48
	.loc 1 73 2 is_stmt 0 view .LVU49
	subl	$1, %ebx
.LVL16:
	.loc 1 73 2 view .LVU50
	jne	.L7
	.loc 1 88 2 is_stmt 1 view .LVU51
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
.LVL17:
	.loc 1 90 2 view .LVU52
	.loc 1 91 1 is_stmt 0 view .LVU53
	popq	%rbx
	.cfi_def_cfa_offset 24
.LVL18:
	.loc 1 91 1 view .LVU54
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
.LVL19:
	.loc 1 91 1 view .LVU55
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	decrease_fn, .-decrease_fn
	.section	.rodata.str1.1
.LC4:
	.string	""
.LC5:
	.string	"NOT "
.LC6:
	.string	"pthread_create"
.LC7:
	.string	"pthread_join"
.LC8:
	.string	"%sOK, val = %d.\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LVL20:
.LFB25:
	.loc 1 95 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 96 5 view .LVU57
	.loc 1 95 1 is_stmt 0 view .LVU58
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	.loc 1 96 5 view .LVU59
	xorl	%esi, %esi
.LVL21:
	.loc 1 96 5 view .LVU60
	leaq	lock(%rip), %rdi
.LVL22:
	.loc 1 95 1 view .LVU61
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	.loc 1 96 5 view .LVU62
	call	pthread_mutex_init@PLT
.LVL23:
	.loc 1 97 2 is_stmt 1 view .LVU63
	.loc 1 98 2 view .LVU64
	.loc 1 103 2 view .LVU65
	.loc 1 108 8 is_stmt 0 view .LVU66
	leaq	12(%rsp), %r12
	xorl	%esi, %esi
	leaq	16(%rsp), %rdi
	movq	%r12, %rcx
	leaq	increase_fn(%rip), %rdx
	.loc 1 103 6 view .LVU67
	movl	$0, 12(%rsp)
	.loc 1 108 2 is_stmt 1 view .LVU68
	.loc 1 108 8 is_stmt 0 view .LVU69
	call	pthread_create@PLT
.LVL24:
	.loc 1 109 2 is_stmt 1 view .LVU70
	.loc 1 109 5 is_stmt 0 view .LVU71
	testl	%eax, %eax
	jne	.L25
	.loc 1 113 2 is_stmt 1 view .LVU72
	.loc 1 113 8 is_stmt 0 view .LVU73
	leaq	24(%rsp), %rdi
	movq	%r12, %rcx
	leaq	decrease_fn(%rip), %rdx
	xorl	%esi, %esi
	call	pthread_create@PLT
.LVL25:
	.loc 1 113 8 view .LVU74
	movl	%eax, %ebx
.LVL26:
	.loc 1 114 2 is_stmt 1 view .LVU75
	.loc 1 114 5 is_stmt 0 view .LVU76
	testl	%eax, %eax
	jne	.L24
	.loc 1 122 2 is_stmt 1 view .LVU77
	.loc 1 122 8 is_stmt 0 view .LVU78
	movq	16(%rsp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
.LVL27:
	.loc 1 122 8 view .LVU79
	movl	%eax, %ebx
.LVL28:
	.loc 1 123 2 is_stmt 1 view .LVU80
	.loc 1 123 5 is_stmt 0 view .LVU81
	testl	%eax, %eax
	jne	.L26
.LVL29:
.L13:
	.loc 1 124 3 is_stmt 1 discriminator 1 view .LVU82
	.loc 1 125 2 discriminator 1 view .LVU83
	.loc 1 125 8 is_stmt 0 discriminator 1 view .LVU84
	movq	24(%rsp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
.LVL30:
	movl	%eax, %ebx
.LVL31:
	.loc 1 126 2 is_stmt 1 discriminator 1 view .LVU85
	.loc 1 126 5 is_stmt 0 discriminator 1 view .LVU86
	testl	%eax, %eax
	jne	.L27
.LVL32:
.L14:
	.loc 1 127 3 is_stmt 1 discriminator 1 view .LVU87
	.loc 1 132 2 discriminator 1 view .LVU88
	.loc 1 132 12 is_stmt 0 discriminator 1 view .LVU89
	movl	12(%rsp), %edx
	xorl	%r12d, %r12d
	.loc 1 134 2 discriminator 1 view .LVU90
	leaq	.LC5(%rip), %rax
	leaq	.LC4(%rip), %rsi
	leaq	.LC8(%rip), %rdi
	.loc 1 132 12 discriminator 1 view .LVU91
	testl	%edx, %edx
	.loc 1 134 2 discriminator 1 view .LVU92
	cmovne	%rax, %rsi
	.loc 1 132 12 discriminator 1 view .LVU93
	sete	%r12b
.LVL33:
	.loc 1 134 2 is_stmt 1 discriminator 1 view .LVU94
	xorl	%eax, %eax
	call	printf@PLT
.LVL34:
	.loc 1 136 2 discriminator 1 view .LVU95
	.loc 1 137 1 is_stmt 0 discriminator 1 view .LVU96
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	%r12d, %eax
.LVL35:
	.loc 1 137 1 discriminator 1 view .LVU97
	popq	%rbx
	.cfi_def_cfa_offset 16
.LVL36:
	.loc 1 137 1 discriminator 1 view .LVU98
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.LVL37:
.L26:
	.cfi_restore_state
	.loc 1 124 3 is_stmt 1 view .LVU99
	.loc 1 124 3 view .LVU100
	call	__errno_location@PLT
.LVL38:
	.loc 1 124 3 is_stmt 0 view .LVU101
	leaq	.LC7(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 124 3 is_stmt 1 view .LVU102
	call	perror@PLT
.LVL39:
	jmp	.L13
.LVL40:
.L27:
	.loc 1 127 3 view .LVU103
	.loc 1 127 3 view .LVU104
	call	__errno_location@PLT
.LVL41:
	.loc 1 127 3 is_stmt 0 view .LVU105
	leaq	.LC7(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 127 3 is_stmt 1 view .LVU106
	call	perror@PLT
.LVL42:
	jmp	.L14
.LVL43:
.L25:
	.loc 1 127 3 is_stmt 0 view .LVU107
	movl	%eax, %ebx
	.loc 1 110 3 is_stmt 1 view .LVU108
	.loc 1 110 3 view .LVU109
.LVL44:
.L24:
	.loc 1 115 3 view .LVU110
	.loc 1 115 3 view .LVU111
	call	__errno_location@PLT
.LVL45:
	leaq	.LC6(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 115 3 view .LVU112
	call	perror@PLT
.LVL46:
	.loc 1 115 3 view .LVU113
	.loc 1 116 3 view .LVU114
	movl	$1, %edi
	call	exit@PLT
.LVL47:
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.globl	lock
	.bss
	.align 32
	.type	lock, @object
	.size	lock, 40
lock:
	.zero	40
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/10/include/stddef.h"
	.file 3 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 5 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 6 "/usr/include/x86_64-linux-gnu/bits/thread-shared-types.h"
	.file 7 "/usr/include/x86_64-linux-gnu/bits/struct_mutex.h"
	.file 8 "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h"
	.file 9 "/usr/include/stdio.h"
	.file 10 "/usr/include/pthread.h"
	.file 11 "/usr/include/errno.h"
	.file 12 "/usr/include/stdlib.h"
	.file 13 "<built-in>"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x801
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF82
	.byte	0xc
	.long	.LASF83
	.long	.LASF84
	.long	.Ldebug_ranges0+0
	.quad	0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF7
	.byte	0x2
	.byte	0xd1
	.byte	0x17
	.long	0x35
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF1
	.uleb128 0x4
	.byte	0x8
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF2
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x6
	.long	0x61
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x2
	.long	.LASF8
	.byte	0x3
	.byte	0x98
	.byte	0x19
	.long	0x6d
	.uleb128 0x2
	.long	.LASF9
	.byte	0x3
	.byte	0x99
	.byte	0x1b
	.long	0x6d
	.uleb128 0x7
	.byte	0x8
	.long	0x92
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF10
	.uleb128 0x8
	.long	.LASF45
	.byte	0xd8
	.byte	0x4
	.byte	0x31
	.byte	0x8
	.long	0x220
	.uleb128 0x9
	.long	.LASF11
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.long	0x61
	.byte	0
	.uleb128 0x9
	.long	.LASF12
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.long	0x8c
	.byte	0x8
	.uleb128 0x9
	.long	.LASF13
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.long	0x8c
	.byte	0x10
	.uleb128 0x9
	.long	.LASF14
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.long	0x8c
	.byte	0x18
	.uleb128 0x9
	.long	.LASF15
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.long	0x8c
	.byte	0x20
	.uleb128 0x9
	.long	.LASF16
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.long	0x8c
	.byte	0x28
	.uleb128 0x9
	.long	.LASF17
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.long	0x8c
	.byte	0x30
	.uleb128 0x9
	.long	.LASF18
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.long	0x8c
	.byte	0x38
	.uleb128 0x9
	.long	.LASF19
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.long	0x8c
	.byte	0x40
	.uleb128 0x9
	.long	.LASF20
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.long	0x8c
	.byte	0x48
	.uleb128 0x9
	.long	.LASF21
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.long	0x8c
	.byte	0x50
	.uleb128 0x9
	.long	.LASF22
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.long	0x8c
	.byte	0x58
	.uleb128 0x9
	.long	.LASF23
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.long	0x239
	.byte	0x60
	.uleb128 0x9
	.long	.LASF24
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.long	0x23f
	.byte	0x68
	.uleb128 0x9
	.long	.LASF25
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.long	0x61
	.byte	0x70
	.uleb128 0x9
	.long	.LASF26
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.long	0x61
	.byte	0x74
	.uleb128 0x9
	.long	.LASF27
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.long	0x74
	.byte	0x78
	.uleb128 0x9
	.long	.LASF28
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.long	0x4c
	.byte	0x80
	.uleb128 0x9
	.long	.LASF29
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.long	0x53
	.byte	0x82
	.uleb128 0x9
	.long	.LASF30
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.long	0x245
	.byte	0x83
	.uleb128 0x9
	.long	.LASF31
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.long	0x255
	.byte	0x88
	.uleb128 0x9
	.long	.LASF32
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.long	0x80
	.byte	0x90
	.uleb128 0x9
	.long	.LASF33
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.long	0x260
	.byte	0x98
	.uleb128 0x9
	.long	.LASF34
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.long	0x26b
	.byte	0xa0
	.uleb128 0x9
	.long	.LASF35
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.long	0x23f
	.byte	0xa8
	.uleb128 0x9
	.long	.LASF36
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.long	0x43
	.byte	0xb0
	.uleb128 0x9
	.long	.LASF37
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.long	0x29
	.byte	0xb8
	.uleb128 0x9
	.long	.LASF38
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.long	0x61
	.byte	0xc0
	.uleb128 0x9
	.long	.LASF39
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.long	0x271
	.byte	0xc4
	.byte	0
	.uleb128 0x2
	.long	.LASF40
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.long	0x99
	.uleb128 0xa
	.long	.LASF85
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0xb
	.long	.LASF41
	.uleb128 0x7
	.byte	0x8
	.long	0x234
	.uleb128 0x7
	.byte	0x8
	.long	0x99
	.uleb128 0xc
	.long	0x92
	.long	0x255
	.uleb128 0xd
	.long	0x35
	.byte	0
	.byte	0
	.uleb128 0x7
	.byte	0x8
	.long	0x22c
	.uleb128 0xb
	.long	.LASF42
	.uleb128 0x7
	.byte	0x8
	.long	0x25b
	.uleb128 0xb
	.long	.LASF43
	.uleb128 0x7
	.byte	0x8
	.long	0x266
	.uleb128 0xc
	.long	0x92
	.long	0x281
	.uleb128 0xd
	.long	0x35
	.byte	0x13
	.byte	0
	.uleb128 0x7
	.byte	0x8
	.long	0x220
	.uleb128 0xe
	.long	.LASF65
	.byte	0x9
	.byte	0x8b
	.byte	0xe
	.long	0x281
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF44
	.uleb128 0x8
	.long	.LASF46
	.byte	0x10
	.byte	0x6
	.byte	0x31
	.byte	0x10
	.long	0x2c2
	.uleb128 0x9
	.long	.LASF47
	.byte	0x6
	.byte	0x33
	.byte	0x23
	.long	0x2c2
	.byte	0
	.uleb128 0x9
	.long	.LASF48
	.byte	0x6
	.byte	0x34
	.byte	0x23
	.long	0x2c2
	.byte	0x8
	.byte	0
	.uleb128 0x7
	.byte	0x8
	.long	0x29a
	.uleb128 0x2
	.long	.LASF49
	.byte	0x6
	.byte	0x35
	.byte	0x3
	.long	0x29a
	.uleb128 0x8
	.long	.LASF50
	.byte	0x28
	.byte	0x7
	.byte	0x16
	.byte	0x8
	.long	0x34a
	.uleb128 0x9
	.long	.LASF51
	.byte	0x7
	.byte	0x18
	.byte	0x7
	.long	0x61
	.byte	0
	.uleb128 0x9
	.long	.LASF52
	.byte	0x7
	.byte	0x19
	.byte	0x10
	.long	0x3c
	.byte	0x4
	.uleb128 0x9
	.long	.LASF53
	.byte	0x7
	.byte	0x1a
	.byte	0x7
	.long	0x61
	.byte	0x8
	.uleb128 0x9
	.long	.LASF54
	.byte	0x7
	.byte	0x1c
	.byte	0x10
	.long	0x3c
	.byte	0xc
	.uleb128 0x9
	.long	.LASF55
	.byte	0x7
	.byte	0x20
	.byte	0x7
	.long	0x61
	.byte	0x10
	.uleb128 0x9
	.long	.LASF56
	.byte	0x7
	.byte	0x22
	.byte	0x9
	.long	0x5a
	.byte	0x14
	.uleb128 0x9
	.long	.LASF57
	.byte	0x7
	.byte	0x23
	.byte	0x9
	.long	0x5a
	.byte	0x16
	.uleb128 0x9
	.long	.LASF58
	.byte	0x7
	.byte	0x24
	.byte	0x14
	.long	0x2c8
	.byte	0x18
	.byte	0
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF59
	.uleb128 0x2
	.long	.LASF60
	.byte	0x8
	.byte	0x1b
	.byte	0x1b
	.long	0x35
	.uleb128 0xf
	.byte	0x28
	.byte	0x8
	.byte	0x43
	.byte	0x9
	.long	0x38b
	.uleb128 0x10
	.long	.LASF61
	.byte	0x8
	.byte	0x45
	.byte	0x1c
	.long	0x2d4
	.uleb128 0x10
	.long	.LASF62
	.byte	0x8
	.byte	0x46
	.byte	0x8
	.long	0x38b
	.uleb128 0x10
	.long	.LASF63
	.byte	0x8
	.byte	0x47
	.byte	0xc
	.long	0x6d
	.byte	0
	.uleb128 0xc
	.long	0x92
	.long	0x39b
	.uleb128 0xd
	.long	0x35
	.byte	0x27
	.byte	0
	.uleb128 0x2
	.long	.LASF64
	.byte	0x8
	.byte	0x48
	.byte	0x3
	.long	0x35d
	.uleb128 0x7
	.byte	0x8
	.long	0x8c
	.uleb128 0x11
	.long	.LASF66
	.byte	0x1
	.byte	0x1d
	.byte	0x11
	.long	0x39b
	.uleb128 0x9
	.byte	0x3
	.quad	lock
	.uleb128 0x12
	.long	.LASF69
	.byte	0x1
	.byte	0x5e
	.byte	0x5
	.long	0x61
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.long	0x5c8
	.uleb128 0x13
	.long	.LASF67
	.byte	0x1
	.byte	0x5e
	.byte	0xe
	.long	0x61
	.long	.LLST6
	.long	.LVUS6
	.uleb128 0x13
	.long	.LASF68
	.byte	0x1
	.byte	0x5e
	.byte	0x1a
	.long	0x3a7
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x14
	.string	"val"
	.byte	0x1
	.byte	0x61
	.byte	0x6
	.long	0x61
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x15
	.string	"ret"
	.byte	0x1
	.byte	0x61
	.byte	0xb
	.long	0x61
	.long	.LLST8
	.long	.LVUS8
	.uleb128 0x15
	.string	"ok"
	.byte	0x1
	.byte	0x61
	.byte	0x10
	.long	0x61
	.long	.LLST9
	.long	.LVUS9
	.uleb128 0x14
	.string	"t1"
	.byte	0x1
	.byte	0x62
	.byte	0xc
	.long	0x351
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x14
	.string	"t2"
	.byte	0x1
	.byte	0x62
	.byte	0x10
	.long	0x351
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x16
	.quad	.LVL23
	.long	0x77a
	.long	0x483
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	lock
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x16
	.quad	.LVL24
	.long	0x787
	.long	0x4b3
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	increase_fn
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.byte	0
	.uleb128 0x16
	.quad	.LVL25
	.long	0x787
	.long	0x4e3
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	decrease_fn
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.byte	0
	.uleb128 0x16
	.quad	.LVL27
	.long	0x793
	.long	0x4fa
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x16
	.quad	.LVL30
	.long	0x793
	.long	0x511
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x16
	.quad	.LVL34
	.long	0x79f
	.long	0x530
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC8
	.byte	0
	.uleb128 0x18
	.quad	.LVL38
	.long	0x7ac
	.uleb128 0x16
	.quad	.LVL39
	.long	0x7b8
	.long	0x55c
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.byte	0
	.uleb128 0x18
	.quad	.LVL41
	.long	0x7ac
	.uleb128 0x16
	.quad	.LVL42
	.long	0x7b8
	.long	0x588
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.byte	0
	.uleb128 0x18
	.quad	.LVL45
	.long	0x7ac
	.uleb128 0x16
	.quad	.LVL46
	.long	0x7b8
	.long	0x5b4
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.byte	0
	.uleb128 0x19
	.quad	.LVL47
	.long	0x7c5
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.byte	0
	.uleb128 0x12
	.long	.LASF70
	.byte	0x1
	.byte	0x43
	.byte	0x7
	.long	0x43
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x69e
	.uleb128 0x1a
	.string	"arg"
	.byte	0x1
	.byte	0x43
	.byte	0x19
	.long	0x43
	.long	.LLST3
	.long	.LVUS3
	.uleb128 0x15
	.string	"i"
	.byte	0x1
	.byte	0x45
	.byte	0x6
	.long	0x61
	.long	.LLST4
	.long	.LVUS4
	.uleb128 0x15
	.string	"ip"
	.byte	0x1
	.byte	0x46
	.byte	0x10
	.long	0x69e
	.long	.LLST5
	.long	.LVUS5
	.uleb128 0x16
	.quad	.LVL13
	.long	0x7d2
	.long	0x648
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.quad	.LVL14
	.long	0x7df
	.long	0x660
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.quad	.LVL15
	.long	0x7ec
	.long	0x678
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL17
	.long	0x7f9
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC3
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x4a
	.byte	0
	.byte	0
	.uleb128 0x7
	.byte	0x8
	.long	0x68
	.uleb128 0x12
	.long	.LASF71
	.byte	0x1
	.byte	0x29
	.byte	0x7
	.long	0x43
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x77a
	.uleb128 0x1a
	.string	"arg"
	.byte	0x1
	.byte	0x29
	.byte	0x19
	.long	0x43
	.long	.LLST0
	.long	.LVUS0
	.uleb128 0x15
	.string	"i"
	.byte	0x1
	.byte	0x2b
	.byte	0x6
	.long	0x61
	.long	.LLST1
	.long	.LVUS1
	.uleb128 0x15
	.string	"ip"
	.byte	0x1
	.byte	0x2c
	.byte	0x10
	.long	0x69e
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0x16
	.quad	.LVL3
	.long	0x7d2
	.long	0x724
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC0
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.quad	.LVL4
	.long	0x7df
	.long	0x73c
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.quad	.LVL5
	.long	0x7ec
	.long	0x754
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x19
	.quad	.LVL7
	.long	0x7f9
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC1
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x17
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x4a
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF72
	.long	.LASF72
	.byte	0xa
	.value	0x2d5
	.byte	0xc
	.uleb128 0x1c
	.long	.LASF73
	.long	.LASF73
	.byte	0xa
	.byte	0xc6
	.byte	0xc
	.uleb128 0x1c
	.long	.LASF74
	.long	.LASF74
	.byte	0xa
	.byte	0xd7
	.byte	0xc
	.uleb128 0x1b
	.long	.LASF75
	.long	.LASF75
	.byte	0x9
	.value	0x14c
	.byte	0xc
	.uleb128 0x1c
	.long	.LASF76
	.long	.LASF76
	.byte	0xb
	.byte	0x25
	.byte	0xd
	.uleb128 0x1b
	.long	.LASF77
	.long	.LASF77
	.byte	0x9
	.value	0x307
	.byte	0xd
	.uleb128 0x1b
	.long	.LASF78
	.long	.LASF78
	.byte	0xc
	.value	0x269
	.byte	0xd
	.uleb128 0x1b
	.long	.LASF79
	.long	.LASF79
	.byte	0x9
	.value	0x146
	.byte	0xc
	.uleb128 0x1b
	.long	.LASF80
	.long	.LASF80
	.byte	0xa
	.value	0x2e2
	.byte	0xc
	.uleb128 0x1b
	.long	.LASF81
	.long	.LASF81
	.byte	0xa
	.value	0x2f4
	.byte	0xc
	.uleb128 0x1d
	.long	.LASF86
	.long	.LASF87
	.byte	0xd
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LVUS6:
	.uleb128 0
	.uleb128 .LVU61
	.uleb128 .LVU61
	.uleb128 0
.LLST6:
	.quad	.LVL20
	.quad	.LVL22
	.value	0x1
	.byte	0x55
	.quad	.LVL22
	.quad	.LFE25
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS7:
	.uleb128 0
	.uleb128 .LVU60
	.uleb128 .LVU60
	.uleb128 0
.LLST7:
	.quad	.LVL20
	.quad	.LVL21
	.value	0x1
	.byte	0x54
	.quad	.LVL21
	.quad	.LFE25
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS8:
	.uleb128 .LVU70
	.uleb128 .LVU74
	.uleb128 .LVU75
	.uleb128 .LVU79
	.uleb128 .LVU79
	.uleb128 .LVU80
	.uleb128 .LVU80
	.uleb128 .LVU82
	.uleb128 .LVU82
	.uleb128 .LVU85
	.uleb128 .LVU85
	.uleb128 .LVU87
	.uleb128 .LVU87
	.uleb128 .LVU98
	.uleb128 .LVU99
	.uleb128 .LVU101
	.uleb128 .LVU101
	.uleb128 .LVU103
	.uleb128 .LVU103
	.uleb128 .LVU105
	.uleb128 .LVU105
	.uleb128 .LVU107
	.uleb128 .LVU107
	.uleb128 .LVU110
.LLST8:
	.quad	.LVL24
	.quad	.LVL25-1
	.value	0x1
	.byte	0x50
	.quad	.LVL26
	.quad	.LVL27-1
	.value	0x1
	.byte	0x50
	.quad	.LVL27-1
	.quad	.LVL28
	.value	0x1
	.byte	0x53
	.quad	.LVL28
	.quad	.LVL29
	.value	0x1
	.byte	0x50
	.quad	.LVL29
	.quad	.LVL31
	.value	0x1
	.byte	0x53
	.quad	.LVL31
	.quad	.LVL32
	.value	0x1
	.byte	0x50
	.quad	.LVL32
	.quad	.LVL36
	.value	0x1
	.byte	0x53
	.quad	.LVL37
	.quad	.LVL38-1
	.value	0x1
	.byte	0x50
	.quad	.LVL38-1
	.quad	.LVL40
	.value	0x1
	.byte	0x53
	.quad	.LVL40
	.quad	.LVL41-1
	.value	0x1
	.byte	0x50
	.quad	.LVL41-1
	.quad	.LVL43
	.value	0x1
	.byte	0x53
	.quad	.LVL43
	.quad	.LVL44
	.value	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LVUS9:
	.uleb128 .LVU94
	.uleb128 .LVU97
	.uleb128 .LVU97
	.uleb128 .LVU99
.LLST9:
	.quad	.LVL33
	.quad	.LVL35
	.value	0x6
	.byte	0x7c
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.quad	.LVL35
	.quad	.LVL37
	.value	0x1
	.byte	0x50
	.quad	0
	.quad	0
.LVUS3:
	.uleb128 0
	.uleb128 .LVU35
	.uleb128 .LVU35
	.uleb128 .LVU55
	.uleb128 .LVU55
	.uleb128 0
.LLST3:
	.quad	.LVL10
	.quad	.LVL12
	.value	0x1
	.byte	0x55
	.quad	.LVL12
	.quad	.LVL19
	.value	0x1
	.byte	0x56
	.quad	.LVL19
	.quad	.LFE24
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS4:
	.uleb128 .LVU39
	.uleb128 .LVU40
	.uleb128 .LVU40
	.uleb128 .LVU48
	.uleb128 .LVU48
	.uleb128 .LVU50
	.uleb128 .LVU50
	.uleb128 .LVU54
.LLST4:
	.quad	.LVL13
	.quad	.LVL13
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL13
	.quad	.LVL15
	.value	0x9
	.byte	0xc
	.long	0x989680
	.byte	0x73
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.quad	.LVL15
	.quad	.LVL16
	.value	0x9
	.byte	0xc
	.long	0x989681
	.byte	0x73
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.quad	.LVL16
	.quad	.LVL18
	.value	0x9
	.byte	0xc
	.long	0x989680
	.byte	0x73
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS5:
	.uleb128 .LVU34
	.uleb128 .LVU35
	.uleb128 .LVU35
	.uleb128 .LVU55
	.uleb128 .LVU55
	.uleb128 0
.LLST5:
	.quad	.LVL11
	.quad	.LVL12
	.value	0x1
	.byte	0x55
	.quad	.LVL12
	.quad	.LVL19
	.value	0x1
	.byte	0x56
	.quad	.LVL19
	.quad	.LFE24
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU7
	.uleb128 .LVU7
	.uleb128 .LVU27
	.uleb128 .LVU27
	.uleb128 0
.LLST0:
	.quad	.LVL0
	.quad	.LVL2
	.value	0x1
	.byte	0x55
	.quad	.LVL2
	.quad	.LVL9
	.value	0x1
	.byte	0x56
	.quad	.LVL9
	.quad	.LFE23
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS1:
	.uleb128 .LVU11
	.uleb128 .LVU12
	.uleb128 .LVU12
	.uleb128 .LVU20
	.uleb128 .LVU20
	.uleb128 .LVU22
	.uleb128 .LVU22
	.uleb128 .LVU26
.LLST1:
	.quad	.LVL3
	.quad	.LVL3
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	.LVL3
	.quad	.LVL5
	.value	0x9
	.byte	0xc
	.long	0x989680
	.byte	0x73
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.quad	.LVL5
	.quad	.LVL6
	.value	0x9
	.byte	0xc
	.long	0x989681
	.byte	0x73
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.quad	.LVL6
	.quad	.LVL8
	.value	0x9
	.byte	0xc
	.long	0x989680
	.byte	0x73
	.sleb128 0
	.byte	0x1c
	.byte	0x9f
	.quad	0
	.quad	0
.LVUS2:
	.uleb128 .LVU6
	.uleb128 .LVU7
	.uleb128 .LVU7
	.uleb128 .LVU27
	.uleb128 .LVU27
	.uleb128 0
.LLST2:
	.quad	.LVL1
	.quad	.LVL2
	.value	0x1
	.byte	0x55
	.quad	.LVL2
	.quad	.LVL9
	.value	0x1
	.byte	0x56
	.quad	.LVL9
	.quad	.LFE23
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
	.section	.debug_aranges,"",@progbits
	.long	0x3c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.quad	0
	.quad	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.Ltext0
	.quad	.Letext0
	.quad	.LFB25
	.quad	.LFE25
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF76:
	.string	"__errno_location"
.LASF34:
	.string	"_wide_data"
.LASF61:
	.string	"__data"
.LASF45:
	.string	"_IO_FILE"
.LASF22:
	.string	"_IO_save_end"
.LASF5:
	.string	"short int"
.LASF7:
	.string	"size_t"
.LASF32:
	.string	"_offset"
.LASF46:
	.string	"__pthread_internal_list"
.LASF16:
	.string	"_IO_write_ptr"
.LASF11:
	.string	"_flags"
.LASF64:
	.string	"pthread_mutex_t"
.LASF47:
	.string	"__prev"
.LASF52:
	.string	"__count"
.LASF31:
	.string	"_lock"
.LASF63:
	.string	"__align"
.LASF23:
	.string	"_markers"
.LASF13:
	.string	"_IO_read_end"
.LASF36:
	.string	"_freeres_buf"
.LASF72:
	.string	"pthread_mutex_init"
.LASF80:
	.string	"pthread_mutex_lock"
.LASF48:
	.string	"__next"
.LASF65:
	.string	"stderr"
.LASF55:
	.string	"__kind"
.LASF44:
	.string	"long long int"
.LASF74:
	.string	"pthread_join"
.LASF73:
	.string	"pthread_create"
.LASF6:
	.string	"long int"
.LASF75:
	.string	"printf"
.LASF28:
	.string	"_cur_column"
.LASF77:
	.string	"perror"
.LASF79:
	.string	"fprintf"
.LASF56:
	.string	"__spins"
.LASF68:
	.string	"argv"
.LASF78:
	.string	"exit"
.LASF27:
	.string	"_old_offset"
.LASF87:
	.string	"__builtin_fwrite"
.LASF2:
	.string	"unsigned char"
.LASF67:
	.string	"argc"
.LASF4:
	.string	"signed char"
.LASF33:
	.string	"_codecvt"
.LASF59:
	.string	"long long unsigned int"
.LASF70:
	.string	"decrease_fn"
.LASF1:
	.string	"unsigned int"
.LASF41:
	.string	"_IO_marker"
.LASF30:
	.string	"_shortbuf"
.LASF82:
	.string	"GNU C17 10.2.1 20210110 -mtune=generic -march=x86-64 -g -O2 -fasynchronous-unwind-tables"
.LASF15:
	.string	"_IO_write_base"
.LASF39:
	.string	"_unused2"
.LASF12:
	.string	"_IO_read_ptr"
.LASF62:
	.string	"__size"
.LASF19:
	.string	"_IO_buf_end"
.LASF10:
	.string	"char"
.LASF54:
	.string	"__nusers"
.LASF69:
	.string	"main"
.LASF83:
	.string	"simplesync.c"
.LASF66:
	.string	"lock"
.LASF35:
	.string	"_freeres_list"
.LASF37:
	.string	"__pad5"
.LASF81:
	.string	"pthread_mutex_unlock"
.LASF51:
	.string	"__lock"
.LASF53:
	.string	"__owner"
.LASF3:
	.string	"short unsigned int"
.LASF71:
	.string	"increase_fn"
.LASF50:
	.string	"__pthread_mutex_s"
.LASF86:
	.string	"fwrite"
.LASF0:
	.string	"long unsigned int"
.LASF17:
	.string	"_IO_write_end"
.LASF9:
	.string	"__off64_t"
.LASF57:
	.string	"__elision"
.LASF25:
	.string	"_fileno"
.LASF24:
	.string	"_chain"
.LASF49:
	.string	"__pthread_list_t"
.LASF38:
	.string	"_mode"
.LASF8:
	.string	"__off_t"
.LASF21:
	.string	"_IO_backup_base"
.LASF18:
	.string	"_IO_buf_base"
.LASF26:
	.string	"_flags2"
.LASF42:
	.string	"_IO_codecvt"
.LASF14:
	.string	"_IO_read_base"
.LASF58:
	.string	"__list"
.LASF29:
	.string	"_vtable_offset"
.LASF43:
	.string	"_IO_wide_data"
.LASF20:
	.string	"_IO_save_base"
.LASF40:
	.string	"FILE"
.LASF84:
	.string	"/home/oslab/oslab092/lab2"
.LASF60:
	.string	"pthread_t"
.LASF85:
	.string	"_IO_lock_t"
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
