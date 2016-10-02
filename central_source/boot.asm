; main multiboot header constants
MBALIGN equ 1<<0
MEMINFO equ 1<<0
FLAGS equ MBALIGN |MEMINFO
MAGIC equ 0x1BADB002
CHECKSUM equ -(MAGIC + FLAGS)

; find the kernal
section .multiboot
align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

; This will create a stack. Stacks may be very annoying
; to work with, however, they have to be done, mainly
; because operating system developers want to tease people
; who work with the stack, and make them get annoyed.

section .bss
align 4
stack_bottom:
resb 16384 ; 16 KiB
stack_top:

; this will specify _start as the entry-point for the kernal
section .text
global _start:function (_start.end - _start)
_start:
	; the bootloader has now loaded the computer. The
	; kernal now has full control over the computer.
	; The kernal can now do whatver he wants with the
	; computer. Long story short, respect the kernal's
	; authority.
	mov esp, stack_top

	; the processor state is now set. We are going to
	; bring in the kernal now.
	extern kernal_main
	call kernal_main

	; The kernal has now taken control. I hope you
	; enjoyed today's booting session. If you want
	; me back, just turn your computer off and back
	; on again. So long, and thanks for all the power.

	; If the kernal ever decides to take a break, this
	; will get it back up and running.
	cli
.hang: hlt
	jmp .hang
.end:

