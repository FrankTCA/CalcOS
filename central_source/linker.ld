/* Start linker at _start in bootloader. */
ENTRY(_start)

SECTIONS {
  . = 1M
  .text BLOCK(4K) : ALIGN(4K) {
    *(.multiboot)
    *(.text)
  }
  /* Read only data */
  .rodata BLOCK(4K) : ALIGN(4K) {
    *(.rodata)
  }
  
  /* Read and Write Data */
  .data BLOCK(4K) : ALIGN(4K) {
    *(.data)
  }
  
  /* Read and write data and stack */
  .bss BLOCK(4K) : ALIGN(4K) {
    *(COMMON)
    *(.bss)
  }
}
