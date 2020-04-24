; OpenBoot MBR x86 Assembly Code

; Version
%define version "0.1 Alpha"

; Boot delay, you can disable it by changing the enabledelay to 0, but you wont see the cool logo :(
; Additionally you can increase, or decrease the boot delay, delay is measured in microseconds
%define enabledelay 1
%define bootdelay 10

; ASCII art switch
%define enableasciiart 1

[bits 16]
[org 0x7C00]

; Whole init kanged from OSDev
init:
  ; Disable interrupts
  cli

  ; Initialize registers
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov ss, ax
  mov sp, ax

  ; Relocate to RAM (0x0600)
  mov cx, 0x0100
  mov si, 0x7C00
  mov di, 0x0600
  rep movsw

  ; Jump to relocated code
  jmp 0:main

main:
  ; Enable interrupts
  sti

  ; Set video mode, kanged from https://github.com/egormkn/mbr-boot-manager/blob/master/mbr.asm
  mov ah, 0x00
  mov ax, 0x03
  int 0x10

%if enabledelay
%if enableasciiart
  ; Print ASCII art
  mov si, asciiart_str0
  call print

  mov si, asciiart_str1
  call print

  mov si, asciiart_str2
  call print

  mov si, asciiart_str3
  call print

  mov si, asciiart_str4
  call print
%endif ; %if enableasciiart

  mov cx, bootdelay
  mov dx, 1
  call delay
%endif ; %if enabledelay

  ; To be continued
  call reboot

print: ; It just works, kanged from https://github.com/egormkn/mbr-boot-manager/blob/master/mbr.asm
  mov ah, 0x0E
  loadchr:
    lodsb
    cmp al, 0x00
    jz exit
    int 0x10
    jmp loadchr
  exit: ret

delay:; It just works, i wrote it myself, actually no, i kanged it from Stack Overflow >:D
  mov ah, 0x86
  mov al, 0x00
  int 0x15
  ret

reboot:
  ;jmp 0xFFFF:0x0000 ; Fucking awful solution
  int 0x19 ; Temporary solution, it doesnt reboot the system, but it goes to start of MBR

; Cool L33T ASCII art
asciiart_str0: db "  ____               ___          __", 10, 13, 0
asciiart_str1: db " / __ \___ ___ ___  / _ )___ ___ / /_", 10, 13, 0
asciiart_str2: db "/ /_/ / _ / -_/ _ \/ _  / _ / _ / __/", 10, 13, 0
asciiart_str3: db "\____/ .__\__/_//_/____/\___\___\__/  ", version, 10, 13, 0
asciiart_str4: db "    /_/", 10, 13, 0

; Ugly padding
times 510 - ($ - $$) db 0
db 0x55, 0xAA
