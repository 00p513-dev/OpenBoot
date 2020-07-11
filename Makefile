all: mbr

mbr:
	nasm -f bin -o MBR.bin MBR/Main.S
clean:
	rm -rf MBR.bin
testmbr:
	qemu-img convert -f raw -O qcow2 MBR.bin MBR.qcow2
	qemu-system-x86_64 MBR.qcow2
	rm -rf MBR.qcow2

qemu: testmbr
