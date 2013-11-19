section .data
    msg:    db 'Hello world!'

section .text
    global _start

_start:
    mov eax, 4      ; write(fd, buf, buf_size)
    mov ebx, 1      ; FD 1
    mov ecx, msg    ; buffer
    mov edx, 13     ; msg length
    int 80h         ; call kernel


    mov eax, 1      ; exit(status)
    mov ebx, 0      ; status 0
    int 80h         ; call kernel