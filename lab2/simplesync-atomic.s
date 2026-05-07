	.file	"simplesync.c"
	.text
.Ltext0:
	.file 0 "/home/loukf/src/ece/oslab/lab2" "simplesync.c"
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
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 42 1 view .LVU4
	movq	%rdi, %rbx
.LVL1:
	.loc 1 46 2 is_stmt 1 view .LVU5
	movq	stderr(%rip), %rdi
.LVL2:
	.loc 1 46 2 is_stmt 0 view .LVU6
	movl	$10000000, %edx
	leaq	.LC0(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.LVL3:
	.loc 1 47 2 is_stmt 1 view .LVU7
	.loc 1 47 16 discriminator 2 view .LVU8
	.loc 1 46 2 is_stmt 0 view .LVU9
	movl	$10000000, %eax
.LVL4:
	.loc 1 46 2 view .LVU10
	.p2align 4
	.p2align 4
	.p2align 3
.L2:
	.loc 1 48 3 is_stmt 1 view .LVU11
	.loc 1 51 13 view .LVU12
	lock addl	$1, (%rbx)
	.loc 1 47 22 discriminator 1 view .LVU13
	.loc 1 47 16 discriminator 2 view .LVU14
	.loc 1 48 3 view .LVU15
	.loc 1 51 13 view .LVU16
	lock addl	$1, (%rbx)
	.loc 1 47 22 discriminator 1 view .LVU17
	.loc 1 47 16 discriminator 2 view .LVU18
	subl	$2, %eax
	jne	.L2
	.loc 1 62 2 view .LVU19
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC1(%rip), %rdi
	call	fwrite@PLT
.LVL5:
	.loc 1 64 2 view .LVU20
	.loc 1 65 1 is_stmt 0 view .LVU21
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
.LVL6:
	.loc 1 65 1 view .LVU22
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
.LVL7:
.LFB24:
	.loc 1 68 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 69 2 view .LVU24
	.loc 1 70 2 view .LVU25
	.loc 1 68 1 is_stmt 0 view .LVU26
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 68 1 view .LVU27
	movq	%rdi, %rbx
.LVL8:
	.loc 1 72 2 is_stmt 1 view .LVU28
	movq	stderr(%rip), %rdi
.LVL9:
	.loc 1 72 2 is_stmt 0 view .LVU29
	movl	$10000000, %edx
	leaq	.LC2(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.LVL10:
	.loc 1 73 2 is_stmt 1 view .LVU30
	.loc 1 73 16 discriminator 2 view .LVU31
	.loc 1 72 2 is_stmt 0 view .LVU32
	movl	$10000000, %eax
.LVL11:
	.loc 1 72 2 view .LVU33
	.p2align 4
	.p2align 4
	.p2align 3
.L8:
	.loc 1 74 3 is_stmt 1 view .LVU34
	.loc 1 77 13 view .LVU35
	lock subl	$1, (%rbx)
	.loc 1 73 22 discriminator 1 view .LVU36
	.loc 1 73 16 discriminator 2 view .LVU37
	.loc 1 74 3 view .LVU38
	.loc 1 77 13 view .LVU39
	lock subl	$1, (%rbx)
	.loc 1 73 22 discriminator 1 view .LVU40
	.loc 1 73 16 discriminator 2 view .LVU41
	subl	$2, %eax
	jne	.L8
	.loc 1 88 2 view .LVU42
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
.LVL12:
	.loc 1 90 2 view .LVU43
	.loc 1 91 1 is_stmt 0 view .LVU44
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
.LVL13:
	.loc 1 91 1 view .LVU45
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
	.section	.text.unlikely,"ax",@progbits
.LCOLDB9:
	.section	.text.startup,"ax",@progbits
.LHOTB9:
	.p2align 4
	.section	.text.unlikely
.Ltext_cold0:
	.section	.text.startup
	.globl	main
	.type	main, @function
main:
.LVL14:
.LFB25:
	.loc 1 95 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 95 1 is_stmt 0 view .LVU47
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 96 5 view .LVU48
	leaq	lock(%rip), %rdi
.LVL15:
	.loc 1 95 1 view .LVU49
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	.loc 1 96 5 view .LVU50
	movq	%fs:40, %rsi
	movq	%rsi, 24(%rsp)
	xorl	%esi, %esi
.LVL16:
	.loc 1 96 5 view .LVU51
	call	pthread_mutex_init@PLT
.LVL17:
	.loc 1 97 2 is_stmt 1 view .LVU52
	.loc 1 98 2 view .LVU53
	.loc 1 103 2 view .LVU54
	.loc 1 108 8 is_stmt 0 view .LVU55
	xorl	%esi, %esi
	leaq	8(%rsp), %rdi
	leaq	4(%rsp), %rcx
	leaq	increase_fn(%rip), %rdx
	.loc 1 103 6 view .LVU56
	movl	$0, 4(%rsp)
	.loc 1 108 2 is_stmt 1 view .LVU57
	.loc 1 108 8 is_stmt 0 view .LVU58
	call	pthread_create@PLT
.LVL18:
	.loc 1 109 2 is_stmt 1 view .LVU59
	.loc 1 109 5 is_stmt 0 view .LVU60
	testl	%eax, %eax
	jne	.L26
	.loc 1 113 2 is_stmt 1 view .LVU61
	.loc 1 113 8 is_stmt 0 view .LVU62
	leaq	16(%rsp), %rdi
	leaq	4(%rsp), %rcx
	xorl	%esi, %esi
	leaq	decrease_fn(%rip), %rdx
	call	pthread_create@PLT
.LVL19:
	.loc 1 113 8 view .LVU63
	movl	%eax, %ebx
.LVL20:
	.loc 1 114 2 is_stmt 1 view .LVU64
	.loc 1 114 5 is_stmt 0 view .LVU65
	testl	%eax, %eax
	jne	.L27
	.loc 1 122 2 is_stmt 1 view .LVU66
	.loc 1 122 8 is_stmt 0 view .LVU67
	movq	8(%rsp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
.LVL21:
	.loc 1 122 8 view .LVU68
	movl	%eax, %ebx
.LVL22:
	.loc 1 123 2 is_stmt 1 view .LVU69
	.loc 1 123 5 is_stmt 0 view .LVU70
	testl	%eax, %eax
	jne	.L28
.LVL23:
.L15:
	.loc 1 124 3 is_stmt 1 discriminator 2 view .LVU71
	.loc 1 125 2 view .LVU72
	.loc 1 125 8 is_stmt 0 view .LVU73
	movq	16(%rsp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
.LVL24:
	movl	%eax, %ebx
.LVL25:
	.loc 1 126 2 is_stmt 1 view .LVU74
	.loc 1 126 5 is_stmt 0 view .LVU75
	testl	%eax, %eax
	jne	.L29
.LVL26:
.L16:
	.loc 1 127 3 is_stmt 1 discriminator 2 view .LVU76
	.loc 1 132 2 view .LVU77
	.loc 1 132 12 is_stmt 0 view .LVU78
	movl	4(%rsp), %edx
	xorl	%ebx, %ebx
.LVL27:
	.loc 1 134 2 discriminator 1 view .LVU79
	leaq	.LC4(%rip), %rax
	.loc 1 134 2 discriminator 2 view .LVU80
	leaq	.LC5(%rip), %rsi
	.loc 1 134 2 discriminator 3 view .LVU81
	leaq	.LC8(%rip), %rdi
	.loc 1 132 12 view .LVU82
	testl	%edx, %edx
	.loc 1 134 2 discriminator 1 view .LVU83
	cmove	%rax, %rsi
	.loc 1 132 12 view .LVU84
	sete	%bl
.LVL28:
	.loc 1 134 2 is_stmt 1 view .LVU85
	.loc 1 134 2 is_stmt 0 discriminator 3 view .LVU86
	xorl	%eax, %eax
	call	printf@PLT
.LVL29:
	.loc 1 136 2 is_stmt 1 view .LVU87
	.loc 1 137 1 is_stmt 0 view .LVU88
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L31
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	movl	%ebx, %eax
.LVL30:
	.loc 1 137 1 view .LVU89
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.LVL31:
.L31:
	.cfi_restore_state
	.loc 1 137 1 view .LVU90
	call	__stack_chk_fail@PLT
.LVL32:
	.loc 1 137 1 view .LVU91
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB25:
.L29:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -16
	.loc 1 127 3 is_stmt 1 view -0
	.loc 1 127 3 view .LVU93
	call	__errno_location@PLT
.LVL33:
	.loc 1 127 3 is_stmt 0 discriminator 1 view .LVU94
	leaq	.LC7(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 127 3 is_stmt 1 discriminator 1 view .LVU95
	call	perror@PLT
.LVL34:
	jmp	.L16
.LVL35:
.L28:
	.loc 1 124 3 view .LVU96
	.loc 1 124 3 view .LVU97
	call	__errno_location@PLT
.LVL36:
	.loc 1 124 3 is_stmt 0 discriminator 1 view .LVU98
	leaq	.LC7(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 124 3 is_stmt 1 discriminator 1 view .LVU99
	call	perror@PLT
.LVL37:
	jmp	.L15
.LVL38:
.L27:
	.loc 1 115 3 view .LVU100
	.loc 1 115 3 view .LVU101
	call	__errno_location@PLT
.LVL39:
	.loc 1 115 3 is_stmt 0 discriminator 1 view .LVU102
	leaq	.LC6(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 115 3 is_stmt 1 discriminator 1 view .LVU103
	call	perror@PLT
.LVL40:
	.loc 1 115 3 discriminator 2 view .LVU104
	.loc 1 116 3 view .LVU105
	movl	$1, %edi
	call	exit@PLT
.LVL41:
.L26:
	.loc 1 116 3 is_stmt 0 view .LVU106
	movl	%eax, %ebx
	.loc 1 110 3 is_stmt 1 view .LVU107
	.loc 1 110 3 view .LVU108
	call	__errno_location@PLT
.LVL42:
	.loc 1 110 3 is_stmt 0 discriminator 1 view .LVU109
	leaq	.LC6(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 110 3 is_stmt 1 discriminator 1 view .LVU110
	call	perror@PLT
.LVL43:
	.loc 1 110 3 discriminator 2 view .LVU111
	.loc 1 111 3 view .LVU112
	movl	$1, %edi
	call	exit@PLT
.LVL44:
	.cfi_endproc
.LFE25:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE9:
	.section	.text.startup
.LHOTE9:
	.globl	lock
	.bss
	.align 32
	.type	lock, @object
	.size	lock, 40
lock:
	.zero	40
	.text
.Letext0:
	.section	.text.unlikely
.Letext_cold0:
	.file 2 "/usr/include/bits/types.h"
	.file 3 "/usr/include/bits/types/struct_FILE.h"
	.file 4 "/usr/include/bits/types/FILE.h"
	.file 5 "/usr/include/bits/thread-shared-types.h"
	.file 6 "/usr/include/bits/struct_mutex.h"
	.file 7 "/usr/include/bits/pthreadtypes.h"
	.file 8 "/usr/include/stdio.h"
	.file 9 "/usr/include/pthread.h"
	.file 10 "/usr/include/stdlib.h"
	.file 11 "/usr/include/errno.h"
	.file 12 "<built-in>"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x912
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x1a
	.long	.LASF83
	.byte	0x1d
	.byte	0x3
	.long	0x31647
	.long	.LASF0
	.long	.LASF1
	.long	.LLRL11
	.quad	0
	.long	.Ldebug_line0
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF2
	.uleb128 0x6
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x1b
	.byte	0x8
	.uleb128 0xd
	.long	0x3d
	.uleb128 0x6
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x6
	.byte	0x2
	.byte	0x7
	.long	.LASF5
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x6
	.byte	0x2
	.byte	0x5
	.long	.LASF7
	.uleb128 0x1c
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x1d
	.long	0x60
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF8
	.uleb128 0x7
	.long	.LASF9
	.byte	0x2
	.byte	0x2d
	.byte	0x1b
	.long	0x2f
	.uleb128 0x7
	.long	.LASF10
	.byte	0x2
	.byte	0x98
	.byte	0x19
	.long	0x6c
	.uleb128 0x7
	.long	.LASF11
	.byte	0x2
	.byte	0x99
	.byte	0x1b
	.long	0x6c
	.uleb128 0x3
	.long	0x9c
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF12
	.uleb128 0xe
	.long	0x9c
	.uleb128 0xa
	.long	0x9c
	.long	0xb8
	.uleb128 0xb
	.long	0x2f
	.byte	0x3
	.byte	0
	.uleb128 0xf
	.long	.LASF50
	.byte	0xd8
	.byte	0x3
	.byte	0x33
	.byte	0x8
	.long	0x268
	.uleb128 0x1
	.long	.LASF13
	.byte	0x3
	.byte	0x35
	.byte	0x7
	.long	0x60
	.byte	0
	.uleb128 0x1
	.long	.LASF14
	.byte	0x3
	.byte	0x38
	.byte	0x9
	.long	0x97
	.byte	0x8
	.uleb128 0x1
	.long	.LASF15
	.byte	0x3
	.byte	0x39
	.byte	0x9
	.long	0x97
	.byte	0x10
	.uleb128 0x1
	.long	.LASF16
	.byte	0x3
	.byte	0x3a
	.byte	0x9
	.long	0x97
	.byte	0x18
	.uleb128 0x1
	.long	.LASF17
	.byte	0x3
	.byte	0x3b
	.byte	0x9
	.long	0x97
	.byte	0x20
	.uleb128 0x1
	.long	.LASF18
	.byte	0x3
	.byte	0x3c
	.byte	0x9
	.long	0x97
	.byte	0x28
	.uleb128 0x1
	.long	.LASF19
	.byte	0x3
	.byte	0x3d
	.byte	0x9
	.long	0x97
	.byte	0x30
	.uleb128 0x1
	.long	.LASF20
	.byte	0x3
	.byte	0x3e
	.byte	0x9
	.long	0x97
	.byte	0x38
	.uleb128 0x1
	.long	.LASF21
	.byte	0x3
	.byte	0x3f
	.byte	0x9
	.long	0x97
	.byte	0x40
	.uleb128 0x1
	.long	.LASF22
	.byte	0x3
	.byte	0x42
	.byte	0x9
	.long	0x97
	.byte	0x48
	.uleb128 0x1
	.long	.LASF23
	.byte	0x3
	.byte	0x43
	.byte	0x9
	.long	0x97
	.byte	0x50
	.uleb128 0x1
	.long	.LASF24
	.byte	0x3
	.byte	0x44
	.byte	0x9
	.long	0x97
	.byte	0x58
	.uleb128 0x1
	.long	.LASF25
	.byte	0x3
	.byte	0x46
	.byte	0x16
	.long	0x281
	.byte	0x60
	.uleb128 0x1
	.long	.LASF26
	.byte	0x3
	.byte	0x48
	.byte	0x14
	.long	0x286
	.byte	0x68
	.uleb128 0x1
	.long	.LASF27
	.byte	0x3
	.byte	0x4a
	.byte	0x7
	.long	0x60
	.byte	0x70
	.uleb128 0x1e
	.long	.LASF84
	.byte	0x3
	.byte	0x4b
	.byte	0x7
	.long	0x60
	.byte	0x18
	.value	0x3a0
	.uleb128 0x1
	.long	.LASF28
	.byte	0x3
	.byte	0x4d
	.byte	0x8
	.long	0x28b
	.byte	0x77
	.uleb128 0x1
	.long	.LASF29
	.byte	0x3
	.byte	0x4e
	.byte	0xb
	.long	0x7f
	.byte	0x78
	.uleb128 0x1
	.long	.LASF30
	.byte	0x3
	.byte	0x51
	.byte	0x12
	.long	0x4b
	.byte	0x80
	.uleb128 0x1
	.long	.LASF31
	.byte	0x3
	.byte	0x52
	.byte	0xf
	.long	0x52
	.byte	0x82
	.uleb128 0x1
	.long	.LASF32
	.byte	0x3
	.byte	0x53
	.byte	0x8
	.long	0x28b
	.byte	0x83
	.uleb128 0x1
	.long	.LASF33
	.byte	0x3
	.byte	0x55
	.byte	0xf
	.long	0x29b
	.byte	0x88
	.uleb128 0x1
	.long	.LASF34
	.byte	0x3
	.byte	0x5d
	.byte	0xd
	.long	0x8b
	.byte	0x90
	.uleb128 0x1
	.long	.LASF35
	.byte	0x3
	.byte	0x5f
	.byte	0x17
	.long	0x2a5
	.byte	0x98
	.uleb128 0x1
	.long	.LASF36
	.byte	0x3
	.byte	0x60
	.byte	0x19
	.long	0x2af
	.byte	0xa0
	.uleb128 0x1
	.long	.LASF37
	.byte	0x3
	.byte	0x61
	.byte	0x14
	.long	0x286
	.byte	0xa8
	.uleb128 0x1
	.long	.LASF38
	.byte	0x3
	.byte	0x62
	.byte	0x9
	.long	0x3d
	.byte	0xb0
	.uleb128 0x1
	.long	.LASF39
	.byte	0x3
	.byte	0x63
	.byte	0x15
	.long	0x2b4
	.byte	0xb8
	.uleb128 0x1
	.long	.LASF40
	.byte	0x3
	.byte	0x64
	.byte	0x7
	.long	0x60
	.byte	0xc0
	.uleb128 0x1
	.long	.LASF41
	.byte	0x3
	.byte	0x66
	.byte	0x7
	.long	0x60
	.byte	0xc4
	.uleb128 0x1
	.long	.LASF42
	.byte	0x3
	.byte	0x68
	.byte	0xe
	.long	0x73
	.byte	0xc8
	.uleb128 0x1
	.long	.LASF43
	.byte	0x3
	.byte	0x6d
	.byte	0x8
	.long	0x2b9
	.byte	0xd0
	.byte	0
	.uleb128 0x7
	.long	.LASF44
	.byte	0x4
	.byte	0x7
	.byte	0x19
	.long	0xb8
	.uleb128 0x1f
	.long	.LASF85
	.byte	0x3
	.byte	0x2d
	.byte	0xe
	.uleb128 0x10
	.long	.LASF45
	.uleb128 0x3
	.long	0x27c
	.uleb128 0x3
	.long	0xb8
	.uleb128 0xa
	.long	0x9c
	.long	0x29b
	.uleb128 0xb
	.long	0x2f
	.byte	0
	.byte	0
	.uleb128 0x3
	.long	0x274
	.uleb128 0x10
	.long	.LASF46
	.uleb128 0x3
	.long	0x2a0
	.uleb128 0x10
	.long	.LASF47
	.uleb128 0x3
	.long	0x2aa
	.uleb128 0x3
	.long	0x286
	.uleb128 0xa
	.long	0x9c
	.long	0x2c9
	.uleb128 0xb
	.long	0x2f
	.byte	0x7
	.byte	0
	.uleb128 0x3
	.long	0xa3
	.uleb128 0x3
	.long	0x268
	.uleb128 0x20
	.long	.LASF71
	.byte	0x8
	.byte	0x9b
	.byte	0xe
	.long	0x2ce
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF48
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF49
	.uleb128 0xf
	.long	.LASF51
	.byte	0x10
	.byte	0x5
	.byte	0x33
	.byte	0x10
	.long	0x315
	.uleb128 0x1
	.long	.LASF52
	.byte	0x5
	.byte	0x35
	.byte	0x23
	.long	0x315
	.byte	0
	.uleb128 0x1
	.long	.LASF53
	.byte	0x5
	.byte	0x36
	.byte	0x23
	.long	0x315
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.long	0x2ed
	.uleb128 0x7
	.long	.LASF54
	.byte	0x5
	.byte	0x37
	.byte	0x3
	.long	0x2ed
	.uleb128 0xf
	.long	.LASF55
	.byte	0x28
	.byte	0x6
	.byte	0x16
	.byte	0x8
	.long	0x39c
	.uleb128 0x1
	.long	.LASF56
	.byte	0x6
	.byte	0x18
	.byte	0x7
	.long	0x60
	.byte	0
	.uleb128 0x1
	.long	.LASF57
	.byte	0x6
	.byte	0x19
	.byte	0x10
	.long	0x36
	.byte	0x4
	.uleb128 0x1
	.long	.LASF58
	.byte	0x6
	.byte	0x1a
	.byte	0x7
	.long	0x60
	.byte	0x8
	.uleb128 0x1
	.long	.LASF59
	.byte	0x6
	.byte	0x1c
	.byte	0x10
	.long	0x36
	.byte	0xc
	.uleb128 0x1
	.long	.LASF60
	.byte	0x6
	.byte	0x20
	.byte	0x7
	.long	0x60
	.byte	0x10
	.uleb128 0x1
	.long	.LASF61
	.byte	0x6
	.byte	0x22
	.byte	0x9
	.long	0x59
	.byte	0x14
	.uleb128 0x1
	.long	.LASF62
	.byte	0x6
	.byte	0x23
	.byte	0x9
	.long	0x59
	.byte	0x16
	.uleb128 0x1
	.long	.LASF63
	.byte	0x6
	.byte	0x24
	.byte	0x14
	.long	0x31a
	.byte	0x18
	.byte	0
	.uleb128 0x7
	.long	.LASF64
	.byte	0x7
	.byte	0x1b
	.byte	0x1b
	.long	0x2f
	.uleb128 0x14
	.byte	0x4
	.byte	0x20
	.long	0x3c6
	.uleb128 0x8
	.long	.LASF65
	.byte	0x22
	.byte	0x8
	.long	0xa8
	.uleb128 0x8
	.long	.LASF66
	.byte	0x23
	.byte	0x7
	.long	0x60
	.byte	0
	.uleb128 0x7
	.long	.LASF67
	.byte	0x7
	.byte	0x24
	.byte	0x3
	.long	0x3a8
	.uleb128 0xe
	.long	0x3c6
	.uleb128 0x21
	.long	.LASF68
	.byte	0x38
	.byte	0x7
	.byte	0x38
	.byte	0x7
	.long	0x3fb
	.uleb128 0x8
	.long	.LASF65
	.byte	0x3a
	.byte	0x8
	.long	0x3fb
	.uleb128 0x8
	.long	.LASF66
	.byte	0x3b
	.byte	0xc
	.long	0x6c
	.byte	0
	.uleb128 0xa
	.long	0x9c
	.long	0x40b
	.uleb128 0xb
	.long	0x2f
	.byte	0x37
	.byte	0
	.uleb128 0x7
	.long	.LASF68
	.byte	0x7
	.byte	0x3e
	.byte	0x1e
	.long	0x3d7
	.uleb128 0xe
	.long	0x40b
	.uleb128 0x14
	.byte	0x28
	.byte	0x43
	.long	0x445
	.uleb128 0x8
	.long	.LASF69
	.byte	0x45
	.byte	0x1c
	.long	0x326
	.uleb128 0x8
	.long	.LASF65
	.byte	0x46
	.byte	0x8
	.long	0x445
	.uleb128 0x8
	.long	.LASF66
	.byte	0x47
	.byte	0xc
	.long	0x6c
	.byte	0
	.uleb128 0xa
	.long	0x9c
	.long	0x455
	.uleb128 0xb
	.long	0x2f
	.byte	0x27
	.byte	0
	.uleb128 0x7
	.long	.LASF70
	.byte	0x7
	.byte	0x48
	.byte	0x3
	.long	0x41c
	.uleb128 0x3
	.long	0x97
	.uleb128 0x22
	.long	.LASF72
	.byte	0x1
	.byte	0x1d
	.byte	0x11
	.long	0x455
	.uleb128 0x9
	.byte	0x3
	.quad	lock
	.uleb128 0x11
	.long	.LASF73
	.byte	0x8
	.value	0x172
	.long	0x60
	.long	0x493
	.uleb128 0x4
	.long	0x2c9
	.uleb128 0x15
	.byte	0
	.uleb128 0x16
	.long	.LASF74
	.byte	0xdb
	.long	0x60
	.long	0x4ac
	.uleb128 0x4
	.long	0x39c
	.uleb128 0x4
	.long	0x4ac
	.byte	0
	.uleb128 0x3
	.long	0x3d
	.uleb128 0x23
	.long	.LASF75
	.byte	0xa
	.value	0x30a
	.byte	0xd
	.long	0x4c4
	.uleb128 0x4
	.long	0x60
	.byte	0
	.uleb128 0x24
	.long	.LASF86
	.byte	0x8
	.value	0x368
	.byte	0xd
	.long	0x4d7
	.uleb128 0x4
	.long	0x2c9
	.byte	0
	.uleb128 0x25
	.long	.LASF87
	.byte	0xb
	.byte	0x25
	.byte	0xd
	.long	0x4e3
	.uleb128 0x3
	.long	0x60
	.uleb128 0x16
	.long	.LASF76
	.byte	0xca
	.long	0x60
	.long	0x50b
	.uleb128 0x4
	.long	0x510
	.uleb128 0x4
	.long	0x51a
	.uleb128 0x4
	.long	0x51f
	.uleb128 0x4
	.long	0x3f
	.byte	0
	.uleb128 0x3
	.long	0x39c
	.uleb128 0xd
	.long	0x50b
	.uleb128 0x3
	.long	0x417
	.uleb128 0xd
	.long	0x515
	.uleb128 0x3
	.long	0x524
	.uleb128 0x26
	.long	0x3d
	.long	0x533
	.uleb128 0x4
	.long	0x3d
	.byte	0
	.uleb128 0x11
	.long	.LASF77
	.byte	0x9
	.value	0x30d
	.long	0x60
	.long	0x54e
	.uleb128 0x4
	.long	0x54e
	.uleb128 0x4
	.long	0x553
	.byte	0
	.uleb128 0x3
	.long	0x455
	.uleb128 0x3
	.long	0x3d2
	.uleb128 0x11
	.long	.LASF78
	.byte	0x8
	.value	0x16c
	.long	0x60
	.long	0x574
	.uleb128 0x4
	.long	0x2ce
	.uleb128 0x4
	.long	0x2c9
	.uleb128 0x15
	.byte	0
	.uleb128 0x27
	.long	.LASF88
	.byte	0x1
	.byte	0x5e
	.byte	0x5
	.long	0x60
	.long	.LLRL6
	.uleb128 0x1
	.byte	0x9c
	.long	0x7b6
	.uleb128 0x17
	.long	.LASF79
	.byte	0x5e
	.byte	0xe
	.long	0x60
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x17
	.long	.LASF80
	.byte	0x5e
	.byte	0x1a
	.long	0x461
	.long	.LLST8
	.long	.LVUS8
	.uleb128 0x12
	.string	"val"
	.byte	0x61
	.byte	0x6
	.long	0x60
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x9
	.string	"ret"
	.byte	0x61
	.byte	0xb
	.long	0x60
	.long	.LLST9
	.long	.LVUS9
	.uleb128 0x9
	.string	"ok"
	.byte	0x61
	.byte	0x10
	.long	0x60
	.long	.LLST10
	.long	.LVUS10
	.uleb128 0x12
	.string	"t1"
	.byte	0x62
	.byte	0xc
	.long	0x39c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x12
	.string	"t2"
	.byte	0x62
	.byte	0x10
	.long	0x39c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x5
	.quad	.LVL17
	.long	0x533
	.long	0x621
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	lock
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x5
	.quad	.LVL18
	.long	0x4e8
	.long	0x651
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	increase_fn
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.byte	0
	.uleb128 0x5
	.quad	.LVL19
	.long	0x4e8
	.long	0x681
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	decrease_fn
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.byte	0
	.uleb128 0x5
	.quad	.LVL21
	.long	0x493
	.long	0x698
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x5
	.quad	.LVL24
	.long	0x493
	.long	0x6af
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x5
	.quad	.LVL29
	.long	0x47c
	.long	0x6ce
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC8
	.byte	0
	.uleb128 0xc
	.quad	.LVL32
	.long	0x901
	.uleb128 0xc
	.quad	.LVL33
	.long	0x4d7
	.uleb128 0x5
	.quad	.LVL34
	.long	0x4c4
	.long	0x707
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.byte	0
	.uleb128 0xc
	.quad	.LVL36
	.long	0x4d7
	.uleb128 0x5
	.quad	.LVL37
	.long	0x4c4
	.long	0x733
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.byte	0
	.uleb128 0xc
	.quad	.LVL39
	.long	0x4d7
	.uleb128 0x5
	.quad	.LVL40
	.long	0x4c4
	.long	0x75f
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.byte	0
	.uleb128 0x5
	.quad	.LVL41
	.long	0x4b1
	.long	0x776
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.uleb128 0xc
	.quad	.LVL42
	.long	0x4d7
	.uleb128 0x5
	.quad	.LVL43
	.long	0x4c4
	.long	0x7a2
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.byte	0
	.uleb128 0x13
	.quad	.LVL44
	.long	0x4b1
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.byte	0
	.uleb128 0x18
	.long	.LASF81
	.byte	0x43
	.long	0x3d
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x859
	.uleb128 0x19
	.string	"arg"
	.byte	0x43
	.long	0x3d
	.long	.LLST3
	.long	.LVUS3
	.uleb128 0x9
	.string	"i"
	.byte	0x45
	.byte	0x6
	.long	0x60
	.long	.LLST4
	.long	.LVUS4
	.uleb128 0x9
	.string	"ip"
	.byte	0x46
	.byte	0x10
	.long	0x859
	.long	.LLST5
	.long	.LVUS5
	.uleb128 0x5
	.quad	.LVL10
	.long	0x558
	.long	0x833
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0xc
	.long	0x989680
	.byte	0
	.uleb128 0x13
	.quad	.LVL12
	.long	0x90a
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC3
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x4a
	.byte	0
	.byte	0
	.uleb128 0x3
	.long	0x67
	.uleb128 0x18
	.long	.LASF82
	.byte	0x29
	.long	0x3d
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x901
	.uleb128 0x19
	.string	"arg"
	.byte	0x29
	.long	0x3d
	.long	.LLST0
	.long	.LVUS0
	.uleb128 0x9
	.string	"i"
	.byte	0x2b
	.byte	0x6
	.long	0x60
	.long	.LLST1
	.long	.LVUS1
	.uleb128 0x9
	.string	"ip"
	.byte	0x2c
	.byte	0x10
	.long	0x859
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0x5
	.quad	.LVL3
	.long	0x558
	.long	0x8db
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC0
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0xc
	.long	0x989680
	.byte	0
	.uleb128 0x13
	.quad	.LVL5
	.long	0x90a
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC1
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x4a
	.byte	0
	.byte	0
	.uleb128 0x28
	.long	.LASF89
	.long	.LASF89
	.uleb128 0x29
	.long	.LASF90
	.long	.LASF91
	.byte	0xc
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
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
	.uleb128 0x2
	.uleb128 0x49
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x7e
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
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
	.uleb128 0x7
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
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 7
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
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
	.uleb128 0xa
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x10
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 12
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
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
	.uleb128 0x13
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 7
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 9
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 9
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 12
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
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
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 7
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
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 25
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x90
	.uleb128 0xb
	.uleb128 0x91
	.uleb128 0x6
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1c
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
	.uleb128 0x1d
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
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
	.uleb128 0xd
	.uleb128 0xb
	.uleb128 0x6b
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x1f
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
	.uleb128 0x20
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
	.uleb128 0x21
	.uleb128 0x17
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
	.uleb128 0x22
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
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x87
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0
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
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
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
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
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
	.byte	0
	.byte	0
	.uleb128 0x29
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
	.section	.debug_loclists,"",@progbits
	.long	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.Ldebug_loc0:
.LVUS7:
	.uleb128 0
	.uleb128 .LVU49
	.uleb128 .LVU49
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST7:
	.byte	0x6
	.quad	.LVL14
	.byte	0x4
	.uleb128 .LVL14-.LVL14
	.uleb128 .LVL15-.LVL14
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL15-.LVL14
	.uleb128 .LHOTE9-.LVL14
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0x8
	.quad	.LFSB25
	.uleb128 .LCOLDE9-.LFSB25
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS8:
	.uleb128 0
	.uleb128 .LVU51
	.uleb128 .LVU51
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST8:
	.byte	0x6
	.quad	.LVL14
	.byte	0x4
	.uleb128 .LVL14-.LVL14
	.uleb128 .LVL16-.LVL14
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL16-.LVL14
	.uleb128 .LHOTE9-.LVL14
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.byte	0x8
	.quad	.LFSB25
	.uleb128 .LCOLDE9-.LFSB25
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.byte	0
.LVUS9:
	.uleb128 .LVU59
	.uleb128 .LVU63
	.uleb128 .LVU64
	.uleb128 .LVU68
	.uleb128 .LVU68
	.uleb128 .LVU69
	.uleb128 .LVU69
	.uleb128 .LVU71
	.uleb128 .LVU71
	.uleb128 .LVU74
	.uleb128 .LVU74
	.uleb128 .LVU76
	.uleb128 .LVU76
	.uleb128 .LVU79
	.uleb128 .LVU91
	.uleb128 0
	.uleb128 0
	.uleb128 .LVU94
	.uleb128 .LVU94
	.uleb128 .LVU96
	.uleb128 .LVU96
	.uleb128 .LVU98
	.uleb128 .LVU98
	.uleb128 .LVU100
	.uleb128 .LVU100
	.uleb128 .LVU102
	.uleb128 .LVU102
	.uleb128 .LVU106
	.uleb128 .LVU106
	.uleb128 .LVU109
	.uleb128 .LVU109
	.uleb128 0
.LLST9:
	.byte	0x6
	.quad	.LVL18
	.byte	0x4
	.uleb128 .LVL18-.LVL18
	.uleb128 .LVL19-1-.LVL18
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL20-.LVL18
	.uleb128 .LVL21-1-.LVL18
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL21-1-.LVL18
	.uleb128 .LVL22-.LVL18
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL22-.LVL18
	.uleb128 .LVL23-.LVL18
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL23-.LVL18
	.uleb128 .LVL25-.LVL18
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL25-.LVL18
	.uleb128 .LVL26-.LVL18
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL26-.LVL18
	.uleb128 .LVL27-.LVL18
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL32-.LVL18
	.uleb128 .LHOTE9-.LVL18
	.uleb128 0x1
	.byte	0x50
	.byte	0x6
	.quad	.LFSB25
	.byte	0x4
	.uleb128 .LFSB25-.LFSB25
	.uleb128 .LVL33-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL33-1-.LFSB25
	.uleb128 .LVL35-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL35-.LFSB25
	.uleb128 .LVL36-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL36-1-.LFSB25
	.uleb128 .LVL38-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL38-.LFSB25
	.uleb128 .LVL39-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL39-1-.LFSB25
	.uleb128 .LVL41-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL41-.LFSB25
	.uleb128 .LVL42-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL42-1-.LFSB25
	.uleb128 .LFE25-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0
.LVUS10:
	.uleb128 .LVU85
	.uleb128 .LVU89
	.uleb128 .LVU89
	.uleb128 .LVU90
	.uleb128 .LVU90
	.uleb128 .LVU91
.LLST10:
	.byte	0x6
	.quad	.LVL28
	.byte	0x4
	.uleb128 .LVL28-.LVL28
	.uleb128 .LVL30-.LVL28
	.uleb128 0x6
	.byte	0x73
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL30-.LVL28
	.uleb128 .LVL31-.LVL28
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL31-.LVL28
	.uleb128 .LVL32-.LVL28
	.uleb128 0x6
	.byte	0x73
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.byte	0
.LVUS3:
	.uleb128 0
	.uleb128 .LVU29
	.uleb128 .LVU29
	.uleb128 .LVU45
	.uleb128 .LVU45
	.uleb128 0
.LLST3:
	.byte	0x6
	.quad	.LVL7
	.byte	0x4
	.uleb128 .LVL7-.LVL7
	.uleb128 .LVL9-.LVL7
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL9-.LVL7
	.uleb128 .LVL13-.LVL7
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL13-.LVL7
	.uleb128 .LFE24-.LVL7
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS4:
	.uleb128 .LVU31
	.uleb128 .LVU33
.LLST4:
	.byte	0x8
	.quad	.LVL10
	.uleb128 .LVL11-.LVL10
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS5:
	.uleb128 .LVU28
	.uleb128 .LVU29
	.uleb128 .LVU29
	.uleb128 .LVU45
	.uleb128 .LVU45
	.uleb128 0
.LLST5:
	.byte	0x6
	.quad	.LVL8
	.byte	0x4
	.uleb128 .LVL8-.LVL8
	.uleb128 .LVL9-.LVL8
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL9-.LVL8
	.uleb128 .LVL13-.LVL8
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL13-.LVL8
	.uleb128 .LFE24-.LVL8
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU6
	.uleb128 .LVU6
	.uleb128 .LVU22
	.uleb128 .LVU22
	.uleb128 0
.LLST0:
	.byte	0x6
	.quad	.LVL0
	.byte	0x4
	.uleb128 .LVL0-.LVL0
	.uleb128 .LVL2-.LVL0
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL2-.LVL0
	.uleb128 .LVL6-.LVL0
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL6-.LVL0
	.uleb128 .LFE23-.LVL0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS1:
	.uleb128 .LVU8
	.uleb128 .LVU10
.LLST1:
	.byte	0x8
	.quad	.LVL3
	.uleb128 .LVL4-.LVL3
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS2:
	.uleb128 .LVU5
	.uleb128 .LVU6
	.uleb128 .LVU6
	.uleb128 .LVU22
	.uleb128 .LVU22
	.uleb128 0
.LLST2:
	.byte	0x6
	.quad	.LVL1
	.byte	0x4
	.uleb128 .LVL1-.LVL1
	.uleb128 .LVL2-.LVL1
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL2-.LVL1
	.uleb128 .LVL6-.LVL1
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL6-.LVL1
	.uleb128 .LFE23-.LVL1
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.long	0x4c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.Ltext_cold0
	.quad	.Letext_cold0-.Ltext_cold0
	.quad	.LFB25
	.quad	.LHOTE9-.LFB25
	.quad	0
	.quad	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.long	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.LLRL6:
	.byte	0x7
	.quad	.LFB25
	.uleb128 .LHOTE9-.LFB25
	.byte	0x7
	.quad	.LFSB25
	.uleb128 .LCOLDE9-.LFSB25
	.byte	0
.LLRL11:
	.byte	0x7
	.quad	.Ltext0
	.uleb128 .Letext0-.Ltext0
	.byte	0x7
	.quad	.Ltext_cold0
	.uleb128 .Letext_cold0-.Ltext_cold0
	.byte	0x7
	.quad	.LFB25
	.uleb128 .LHOTE9-.LFB25
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF87:
	.string	"__errno_location"
.LASF36:
	.string	"_wide_data"
.LASF69:
	.string	"__data"
.LASF47:
	.string	"_IO_wide_data"
.LASF50:
	.string	"_IO_FILE"
.LASF24:
	.string	"_IO_save_end"
.LASF7:
	.string	"short int"
.LASF81:
	.string	"decrease_fn"
.LASF28:
	.string	"_short_backupbuf"
.LASF34:
	.string	"_offset"
.LASF51:
	.string	"__pthread_internal_list"
.LASF18:
	.string	"_IO_write_ptr"
.LASF13:
	.string	"_flags"
.LASF70:
	.string	"pthread_mutex_t"
.LASF52:
	.string	"__prev"
.LASF57:
	.string	"__count"
.LASF33:
	.string	"_lock"
.LASF66:
	.string	"__align"
.LASF25:
	.string	"_markers"
.LASF15:
	.string	"_IO_read_end"
.LASF62:
	.string	"__unused"
.LASF38:
	.string	"_freeres_buf"
.LASF77:
	.string	"pthread_mutex_init"
.LASF53:
	.string	"__next"
.LASF44:
	.string	"FILE"
.LASF71:
	.string	"stderr"
.LASF60:
	.string	"__kind"
.LASF48:
	.string	"long long int"
.LASF74:
	.string	"pthread_join"
.LASF76:
	.string	"pthread_create"
.LASF8:
	.string	"long int"
.LASF73:
	.string	"printf"
.LASF30:
	.string	"_cur_column"
.LASF86:
	.string	"perror"
.LASF67:
	.string	"pthread_mutexattr_t"
.LASF56:
	.string	"__lock"
.LASF61:
	.string	"__spins"
.LASF80:
	.string	"argv"
.LASF75:
	.string	"exit"
.LASF29:
	.string	"_old_offset"
.LASF91:
	.string	"__builtin_fwrite"
.LASF4:
	.string	"unsigned char"
.LASF39:
	.string	"_prevchain"
.LASF79:
	.string	"argc"
.LASF6:
	.string	"signed char"
.LASF35:
	.string	"_codecvt"
.LASF49:
	.string	"long long unsigned int"
.LASF3:
	.string	"unsigned int"
.LASF45:
	.string	"_IO_marker"
.LASF32:
	.string	"_shortbuf"
.LASF17:
	.string	"_IO_write_base"
.LASF43:
	.string	"_unused2"
.LASF41:
	.string	"_unused3"
.LASF14:
	.string	"_IO_read_ptr"
.LASF65:
	.string	"__size"
.LASF21:
	.string	"_IO_buf_end"
.LASF12:
	.string	"char"
.LASF59:
	.string	"__nusers"
.LASF88:
	.string	"main"
.LASF72:
	.string	"lock"
.LASF37:
	.string	"_freeres_list"
.LASF9:
	.string	"__uint64_t"
.LASF58:
	.string	"__owner"
.LASF5:
	.string	"short unsigned int"
.LASF82:
	.string	"increase_fn"
.LASF55:
	.string	"__pthread_mutex_s"
.LASF90:
	.string	"fwrite"
.LASF2:
	.string	"long unsigned int"
.LASF19:
	.string	"_IO_write_end"
.LASF11:
	.string	"__off64_t"
.LASF27:
	.string	"_fileno"
.LASF26:
	.string	"_chain"
.LASF54:
	.string	"__pthread_list_t"
.LASF40:
	.string	"_mode"
.LASF10:
	.string	"__off_t"
.LASF23:
	.string	"_IO_backup_base"
.LASF20:
	.string	"_IO_buf_base"
.LASF84:
	.string	"_flags2"
.LASF46:
	.string	"_IO_codecvt"
.LASF16:
	.string	"_IO_read_base"
.LASF63:
	.string	"__list"
.LASF31:
	.string	"_vtable_offset"
.LASF83:
	.string	"GNU C23 16.1.1 20260430 -mtune=generic -march=x86-64 -g -O2"
.LASF22:
	.string	"_IO_save_base"
.LASF42:
	.string	"_total_written"
.LASF89:
	.string	"__stack_chk_fail"
.LASF68:
	.string	"pthread_attr_t"
.LASF64:
	.string	"pthread_t"
.LASF78:
	.string	"fprintf"
.LASF85:
	.string	"_IO_lock_t"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"simplesync.c"
.LASF1:
	.string	"/home/loukf/src/ece/oslab/lab2"
	.ident	"GCC: (GNU) 16.1.1 20260430"
	.section	.note.GNU-stack,"",@progbits
