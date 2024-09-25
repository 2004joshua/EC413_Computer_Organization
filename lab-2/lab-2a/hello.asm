.data 
hello_str: .asciiz "Hello World!\n"

.text
.globl main

main: 
    li $v0, 4
    la $a0, hello_str
    syscall


    li $v0, 10
    syscall
