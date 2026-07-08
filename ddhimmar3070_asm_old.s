@ ddhimmar3070_asm.s Data section - initialized values

.data
.align 3

huge:   .octa 0xAABBCCDDDDCCBBFF
big:    .word 0xAAEEBBFF
num:    .byte 0xAB
str2:   .asciz "Guten Tag!"
count:  .word 12345

@ End of new data section

.code 16
.text

.align 2
.syntax unified

.global ddhimmar3070_add_test

.code 16
.thumb_func

.type ddhimmar3070_add_test, %function

@ Function Declaration : int ddhimmar3070_add_test(int x, int y)
@ Input: r0, r1
@ Returns: r0

ddhimmar3070_add_test:

    push {r4, lr}

    ldr r0, =num
    ldr r0, =big
    ldr r0, =huge
    ldr r0, =str2

    ldr r2, =str2
    ldrb r0, [r2]

    ldr r2, =str2
    ldr r0, [r2]

    ldr r2, =num
    ldrb r0, [r2]

    ldr r2, =big
    ldr r0, [r2]

    ldr r2, =huge
    ldrd r0, r1, [r2]

    bkpt

    pop {r4, lr}

    bx lr

.size ddhimmar3070_add_test, .-ddhimmar3070_add_test


.global ddhimmar3070_string_test

.code 16
.thumb_func

.type ddhimmar3070_string_test, %function

@ Function Declaration : int ddhimmar3070_string_test(char *p)
@ Input: r0 pointer to byte array
@ Returns: r0

ddhimmar3070_string_test:

StringLoop:
    ldrb r1, [r0]
    cmp r1, #0
    beq OutLabel
    add r0, r0, #1
    b StringLoop

OutLabel:
    bkpt
    bx lr

.size ddhimmar3070_string_test, .-ddhimmar3070_string_test

@@ Function Header Block
    .align  2               @ Code alignment is 2^n alignment (n=2)
    .syntax unified         @ Sets the instruction set to the unified ARM + THUMB
    .global ddhimmar3070_a2   @ Make the symbol name for the function visible to the linker
    .code   16              @ 16bit THUMB code (BOTH .code and .thumb_func are required)
    .thumb_func             @ Specifies that the following symbol is the name of a THUMB
    .type   ddhimmar3070_a2, %function   @ Declares that the symbol is a function (not strictly required)

@ Function Declaration : int ddhimmar3070_a2(int num, int wait)
@
@ Input:
@   r0 = num, number of cycles
@   r1 = wait, delay amount
@ Returns:
@   r0 = total number of LED toggles
@
@ Here is the assignment 2 assembly function
ddhimmar3070_a2:

    push {r4, r5, r6, r7, lr}

    mov r4, r0
    mov r5, r1
    mov r6, #0

a2_outer_loop:
    cmp r4, #0
    beq a2_done

    mov r7, #0

a2_inner_loop:
    cmp r7, #8
    beq a2_next_cycle

    mov r0, r7
    bl BSP_LED_Toggle

    add r6, r6, #1

    mov r0, r5
    bl busy_delay

    add r7, r7, #1
    b a2_inner_loop

a2_next_cycle:
    subs r4, r4, #1
    b a2_outer_loop

a2_done:
    mov r0, r6

    pop {r4, r5, r6, r7, lr}

    bx lr

.size ddhimmar3070_a2, .-ddhimmar3070_a2

@ Function Declaration : int busy_delay(int cycles)
@
@ Input: r0 (i.e. r0 holds number of cycles to delay)
@ Returns: r0
@
@ Here is the actual function. DO NOT MODIFY THIS FUNCTION.

busy_delay:

    push {r6}

    mov r6, r0

delay_label:
    subs r6, r6, #1
    bge delay_label

    mov r0, #0

    pop {r6}

    bx lr

.end