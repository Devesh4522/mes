@ Test code for my own new function called from C

@ This is a comment. Anything after an @ symbol is ignored.
@@ This is also a comment. Some people use double @@ symbols. 


    .code   16              @ This directive selects the instruction set being generated. 
                            @ The value 16 selects Thumb, with the value 32 selecting ARM.

    .text                   @ Tell the assembler that the upcoming section is to be considered
                            @ assembly language instructions - Code section (text -> ROM)

@@ Function Header Block
    .align  2               @ Code alignment - 2^n alignment (n=2)
                            @ This causes the assembler to use 4 byte alignment

    .syntax unified         @ Sets the instruction set to the new unified ARM + THUMB
                            @ instructions. The default is divided (separate instruction sets)

    .global ddhimmar3070_lab6        @ Make the symbol name for the function visible to the linker

    .code   16              @ 16bit THUMB code (BOTH .code and .thumb_func are required)
    .thumb_func             @ Specifies that the following symbol is the name of a THUMB
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.

    .type   ddhimmar3070_lab6, %function   @ Declares that the symbol is a function (not strictly required)

@ Function Declaration : int ddhimmar3070_lab6(int x, int y)
@
@ Input: r0, r1 (i.e. r0 holds x, r1 holds y)
@ Returns: r0
@ 

@ Here is the actual ddhimmar3070_lab6 function
ddhimmar3070_lab6:
    push {r4, r5, r6, lr}

    mov r4, r0          @ Save delay number
    mov r5, #7          @ LED index starts at 7
    mov r6, #0          @ Toggle counter starts at 0

lab6_loop:
    cmp r5, #0
    bge lab6_toggle

    mov r5, #7          @ Reset index when it results in negative

lab6_toggle:
    mov r0, r5
    bl BSP_LED_Toggle

    add r6, r6, #1      @ Increment of the toggle counter
    sub r5, r5, #1      @ Decrement of the LED index

    mov r0, r4
    bl busy_delay

    mov r0, #0          @ BUTTON_USER is 0
    bl BSP_PB_GetState

    cmp r0, #0
    beq lab6_loop       @ Keep looping if button is not pressed

    mov r0, r6          @ Return toggle counter

    pop {r4, r5, r6, lr}

    bx lr                           @ Return (Branch eXchange) to the address in the link register (lr) 
    .size   ddhimmar3070_lab6, .-ddhimmar3070_lab6    @@ - symbol size (not strictly required, but makes the debugger happy)

@@ Function Header Block

    .global ddhimmar3070_lab7        @ Make the symbol name for the function visible to the linker
    .type   ddhimmar3070_lab7, %function   @ Declares that the symbol is a function (not strictly required)

@ Function Declaration : int ddhimmar3070_lab7(int delay)
@
@ Input: r0 (i.e. r0 holds the delay value)
@ Returns: r0
@ 

@ Here is the actual ddhimmar3070_lab7 function
ddhimmar3070_lab7:
    push {lr}
    bl busy_delay

    @ Get the state of the user button here.
    @ Return the result to the calling C function

    pop {lr}
    bx lr                           @ Return (Branch eXchange) to the address in the link register (lr) 
    .size   ddhimmar3070_lab7, .-ddhimmar3070_lab7    @@ - symbol size (not strictly required)

.global ddhimmar3070_a3
.thumb_func
.type   ddhimmar3070_a3, %function

.global ddhimmar3070_a3
.thumb_func
.type ddhimmar3070_a3, %function

ddhimmar3070_a3:
    push {r4-r7, lr}
    sub sp, sp, #4

    mov r4, r0
    mov r5, r1
    mov r6, r2
    mov r7, #0

    ldrb r0, [r5]
    cmp r0, #0
    beq a3_first_done

    sub r0, r0, #'0'

    cmp r0, #0
    blt a3_first_done

    cmp r0, #7
    bgt a3_first_done

    bl BSP_LED_Toggle

    add r7, r7, #1

    mov r0, r4
    bl busy_delay

a3_first_done:
    mov r0, r7

    add sp, sp, #4
    pop {r4-r7, pc}

    .size   ddhimmar3070_a3, .-ddhimmar3070_a3

@ Function Declaration: int busy_delay(int cycles)
@
@ Input: r0 (i.e. r0 is how many cycles to delay)
@ Returns: r0
@ 

@ Here is the actual function. DO NOT MODIFY THIS FUNCTION
busy_delay:
    push {r6}
    mov r6, r0

    d3lay_loop:
        subs r6, r6, #1
        bge d3lay_loop

        mov r0, #0      @ Return zero (success)

    pop {r6}
    bx lr               @ Return to calling function


@ Assembly file ended by single .end directive on its own line
.end

Things past the end directive are not processed, as you can see here.
