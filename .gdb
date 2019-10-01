set language asm
set disassembly-flavor intel
break main
run < ./build/debug/asm-hexdump
