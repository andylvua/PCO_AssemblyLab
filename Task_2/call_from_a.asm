include 'format/format.inc'

; Specify ELF64 as executable format.
format ELF64

; This is the code section of the program.
section '.text' executable

; Define public function
public main
; Include the external sorting function and printf
extrn insertion_sort
extrn printf

main:
    ; Define the stack frame
    push rbp
    ; Set the base pointer to the stack pointer
    mov rbp, rsp

    ; Print the array before sorting
    call print

    ; Call the sorting function satisfying the calling convention
    lea RDI, [arr] ; Set the first argument to the address of the array in RDI
    mov RSI, [len] ; Set the second argument to the length of the array in RSI
    call insertion_sort

    ; Print the array after sorting
    call print

    ; Restore the stack pointer to the base pointer and return
    pop rbp
    ret

; Print the array
print:
    push rbp
    mov rbp, rsp

    ; Align the stack to 16 bytes for the printf function
    sub rsp, 16
    ; Save R12
    mov [rbp-16], R12
    ; Loop through the array and print each element. Set counter to 0 (xor
    xor R12, R12
    For:
        ; If the counter is greater than the length of the array, break
        cmp R12, [len] ; compare counter with size of array
        jge EndFor

        ; Call printf to print the element satisfying the calling convention
        lea RDI, [msg] ; Set the first argument to the address of the message in RDI
        lea RBX, [arr] ; Set the second argument to the address of the array in RBX
        mov RSI, [RBX+4*R12] ; Set the third argument to the element in the array in RSI
        call printf

        ; Increment the counter and loop
        inc R12
        jmp For
    EndFor:
        ; If end of array is reached, print a newline
        lea RDI, [nln]
        call printf

        ; Restore R12
        add rsp, 16
        mov R12, [rbp-16]
        ; Restore the stack pointer to the base pointer and return
        pop rbp
        ret


; This is the data section of the program.
section '.data' writeable

; Define the array to be sorted
arr dd -9, 15, 51, 14, -23, 9, 34, 5, -7, 12, 19, -24, 60, -1, 7
; Define the length of the array
len dq 15

; Define the message to be printed
msg db "%d", ' ', 0
nln db 0xA, 0 ; newline