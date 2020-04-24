# Do not use this bootloader unless you REALLY want to

## Implemented stuff  
Initialization  
Relocation to RAM  
Print function  
Delay function  
Reboot function(kinda, replaced temporarily with int 0x19)

## Unimplemented stuff  
Booting

## Cool featurez  
ASCII art  
Lightweight(relatively)

## Bugs  
Old implementation of reboot function may hang the system(atleast on a emulated hardware)  
No booting support(reboots after ASCII art splash screen)

## Code kanged from
https://github.com/egormkn/mbr-boot-manager  
https://wiki.osdev.org/MBR
