; OpenBoot MBR x86 Assembly Code

%define base 0x7C00
%define target 0x0600

[bits 16]
[org 0x0600]
  ; Stop interrupts
  cli

  ; Initialize registers
  xor ax, ax
  mov ss, ax
  mov es, ax
  mov ds, ax
  mov sp, ax

  mov si, base
  mov di, target
  mov cx, 512
  rep movsb
  jmp skip + target

  skip: equ ($ - $$)
  
  hlt

times 510 - ($ - $$) db 0
db 0x55, 0xAA                 
