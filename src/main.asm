%ifdef
                                    88888888
                                  888888888888
                                 88888888888888
                                8888888888888888
                               888888888888888888
                              888888  8888  888888
                              88888    88    88888
                              888888  8888  888888
                              88888888888888888888
                              88888888888888888888
                             8888888888888888888888
                          8888888888888888888888888888
                        88888888888888888888888888888888
                              88888888888888888888
                            888888888888888888888888
                           888888  8888888888  888888
                           888     8888  8888     888
                                   888    888

                                   OCTOBANANA

Licensed under the MIT License

Copyright (c) 2019 Brett Robinson <https://octobanana.com/>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
%endif

bits 64

eof: equ 0
stdin: equ 0
stdout: equ 1
stderr: equ 2

; term_color '[000-255]' '[000-255]' '[000-255]'
; make sure to pad with 0 so each value has a length of 3
%define term_color(r, g ,b) 1bh, '[38;2;', r, ';', g, ';', b, 'm'

; length of the term_color string
%define color_len 19

; clear all term attributes
%define term_color_clear 1bh, '[0m'

%define color_val_0 term_color('254', '087', '103')
%define color_val_1 term_color('114', '249', '086')
%define color_val_2 term_color('255', '157', '088')
%define color_val_3 term_color('083', '242', '220')

%define color_outline term_color('066', '073', '087')
%define color_duplicate term_color('066', '073', '087')
%define color_offset color_val_3
%define color_0 color_val_0
%define color_1 color_val_1
%define color_2 color_val_2
%define color_3 color_val_3
%define color_4 color_val_0
%define color_5 color_val_1
%define color_6 color_val_2
%define color_7 color_val_3
%define color_8 color_val_0
%define color_9 color_val_1
%define color_a color_val_2
%define color_b color_val_3
%define color_c color_val_0
%define color_d color_val_1
%define color_e color_val_2
%define color_f color_val_3

section .rodata

header:
  db color_outline, '╭────────┬───────────────────────────────────────────────┬────────────────╮', 0ah
  db color_outline, '│'
  db color_offset, ' offset '
  db color_outline, '│'
  db color_0, '00 ', color_1, '01 ', color_2, '02 ', color_3, '03 '
  db color_4, '04 ', color_5, '05 ', color_6, '06 ', color_7, '07 '
  db color_8, '08 ', color_9, '09 ', color_a, '0a ', color_b, '0b '
  db color_c, '0c ', color_d, '0d ', color_e, '0e ', color_f, '0f'
  db color_outline, '│'
  db color_0, '0', color_1, '1', color_2, '2', color_3, '3'
  db color_4, '4', color_5, '5', color_6, '6', color_7, '7'
  db color_8, '8', color_9, '9', color_a, 'a', color_b, 'b'
  db color_c, 'c', color_d, 'd', color_e, 'e', color_f, 'f'
  db color_outline, '│',
  db 0ah
  db color_outline, '├────────┼───────────────────────────────────────────────┼────────────────┤'
  db term_color_clear, 0ah
header_len: equ $-header

line:
  db color_outline, '│'
  db color_offset
begin_offset: equ $-line
  db '00000000'
  db color_outline, '│'
  db color_0
begin_hex: equ $-line
  db '   '
hex_len: equ 3+color_len
  db color_1, '   ', color_2, '   ', color_3, '   '
  db color_4, '   ', color_5, '   ', color_6, '   ', color_7, '   '
  db color_8, '   ', color_9, '   ', color_a, '   ', color_b, '   '
  db color_c, '   ', color_d, '   ', color_e, '   ', color_f, '  '
  db color_outline, '│'
  db color_0
begin_ascii: equ $-line
  db ' '
ascii_len: equ 1+color_len
  db color_1, ' ', color_2, ' ', color_3, ' '
  db color_4, ' ', color_5, ' ', color_6, ' ', color_7, ' '
  db color_8, ' ', color_9, ' ', color_a, ' ', color_b, ' '
  db color_c, ' ', color_d, ' ', color_e, ' ', color_f, ' '
  db color_outline, '│'
  db term_color_clear, 0ah
line_len: equ $-line

dupline:
  db color_outline, '│'
  db color_duplicate, '........'
  db color_outline, '│'
  db color_duplicate, '.. .. .. .. .. .. .. .. .. .. .. .. .. .. .. ..'
  db color_outline, '│'
  db color_duplicate, '................'
  db color_outline, '│'
  db term_color_clear, 0ah
dupline_len: equ $-dupline

footer:
  db color_outline, '╰────────┴───────────────────────────────────────────────┴────────────────╯'
  db term_color_clear, 0ah
footer_len: equ $-footer

map_hex:
  db '0123456789abcdef'

map_ascii:
  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'
  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'
  db ' ','!','"','#', '$','%','&',"'", '(',')','*','+', ',','-','.','/'
  db '0','1','2','3', '4','5','6','7', '8','9',':',';', '<','=','>','?'

  DB '@','A','B','C', 'D','E','F','G', 'H','I','J','K', 'L','M','N','O'
  DB 'P','Q','R','S', 'T','U','V','W', 'X','Y','Z','[', '\',']','^','_'
  db '`','a','b','c', 'd','e','f','g', 'h','i','j','k', 'l','m','n','o'
  db 'p','q','r','s', 't','u','v','w', 'x','y','z','{', '|','}','~','.'

  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'
  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'
  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'
  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'

  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'
  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'
  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'
  db '.','.','.','.', '.','.','.','.', '.','.','.','.', '.','.','.','.'

section .bss

buf_len: equ 10h
buf: resb buf_len
buf_prev: resb buf_len
buf_fmt: resb line_len

section .text

global main

extern read, write, memcmp, memcpy, memset

main:

; program initialization
; display the header
; setup registers
.init:
  ; write the header to stdout
  mov rdx, header_len
  mov rsi, header
  mov rdi, stdout
  call write

  ; check the return value of write
  cmp rax, header_len
  jne quit_error

  ; clear register to hold offset count unsigned int
  xor r13, r13

  ; clear register to hold duplicate line boolean
  ; 1: when the duplicate line has been displayed
  ; 0: otherwise
  xor r14, r14

; clear and fill the input buffer
; display duplicate line if the input buffer matches the previous input
; copy the input buffer into the previous input buffer
; copy the template line into the format buffer
input:
  ; clear the input buffer
  mov rdx, buf_len
  mov rsi, 0h
  mov rdi, buf
  call memset

  ; read up to 16 bytes into the input buffer
  mov rdx, buf_len
  mov rsi, buf
  mov rdi, stdin
  call read

  ; store the number of bytes read
  mov r12, rax

  ; check the return value of read
  cmp rax, eof
  jl quit_error
  je quit

  ; compare the input buffer to the previous input buffer
  mov rdx, buf_len
  mov rsi, buf
  mov rdi, buf_prev
  call memcmp

  ; check if the input buffer is equal to the previous input buffer
  cmp rax, 0h
  jne .cont
  ; increase the offset count by 16
  add r13, 10h
  ; check if the duplicate line has already been displayed
  cmp r14, 1h
  je input
  jmp output_dup

.cont:
  ; set duplicate line to false
  xor r14, r14

  ; copy the input buffer into the previous input buffer
  mov rdx, buf_len
  mov rsi, buf
  mov rdi, buf_prev
  call memcpy

  ; copy the template line into the format buffer
  mov rdx, line_len
  mov rsi, line
  mov rdi, buf_fmt
  call memcpy

; write the offset count to the format buffer
offset:
  ; store pointer to the start of the format/offset buffer
  lea rbp, [buf_fmt + begin_offset]
  ; the index used to write into the buffer
  mov rbx, 7h
  ; the index used to shift the number by 4 each loop
  xor rcx, rcx

.begin:
  ; check if there is any values left to fill
  cmp rbx, 0h
  je .end

  ; copy the offset count
  mov rax, r13
  ; shift the offset right by a multiple of 4
  shr rax, cl
  ; mask off all the bits except the lower 4
  and rax, 0fh
  ; retrieve and store the hex value of the lower 4 bits
  mov al, byte [map_hex + rax]
  ; copy the hex value into the buffer at the write index
  mov byte [rbp + rbx], al

  ; decrease the write index
  dec rbx
  ; add 4 to the shift index
  add rcx, 4h
  jmp .begin
.end:

  ; increase the offset count by 16
  add r13, 10h

; iterate through the input buffer and
; write the hex and ascii value of each byte to the format buffer
iter:
  ; clear register to hold the input buffer index
  xor rcx, rcx
  ; store pointer to the start of the format/hex buffer
  lea rbp, [buf_fmt + begin_hex]
  ; store pointer to the start of the format/ascii buffer
  lea rdi, [buf_fmt + begin_ascii]

.begin:
  ; check if the input buffer index is equal to
  ; the number of bytes in the input buffer
  cmp rcx, r12
  je output

  ; clear register to hold the byte
  xor rbx, rbx
  ; copy the byte at the index into the lower 8 bits of the register
  mov bl, byte [buf + rcx]
  ; copy the byte into a second register
  mov rax, rbx
  ; copy the byte into a third register
  mov rdx, rbx

  ; access the 4 most significant bits (msb)
  shr al, 4h
  ; access the 4 least significant bits (lsb)
  and bl, 0fh

  ; copy hex value of the 4 msb
  mov al, byte [map_hex + rax]
  ; copy hex value of the 4 lsb
  mov bl, byte [map_hex + rbx]
  ; copy ascii value of the byte
  mov dl, byte [map_ascii + rdx]

  ; copy first hex value into the buffer
  mov byte [rbp], al
  ; copy second hex value into the buffer
  mov byte [rbp + 1h], bl
  ; copy ascii value into the buffer
  mov byte [rdi], dl

  ; increase the format/hex buffer pointer
  add rbp, hex_len
  ; increase the format/ascii buffer pointer
  add rdi, ascii_len
  ; increase the input buffer index by 1
  inc rcx
  jmp .begin

; display the formatted line
output:
  ; write the formatted line to stdout
  mov rdx, line_len
  mov rsi, buf_fmt
  mov rdi, stdout
  call write

  ; check the return value of write
  cmp rax, line_len
  jne quit_error

  jmp input

; display the duplicate line
output_dup:
  ; set duplicate line to true
  mov r14, 1h

  ; write the duplicate line to stdout
  mov rdx, dupline_len
  mov rsi, dupline
  mov rdi, stdout
  call write

  ; check the return value of write
  cmp rax, dupline_len
  jne quit_error

  jmp input

; display the header
; return with no errors
quit:
  ; write the footer to stdout
  mov rdx, footer_len
  mov rsi, footer
  mov rdi, stdout
  call write

  ; check the return value of write
  cmp rax, footer_len
  jne quit_error

  ; return with exit status 0
  xor rax, rax
  ret

; return with errors
quit_error:
  ; return with exit status 1
  mov rax, 1h
  ret
