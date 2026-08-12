@ Assembly File - Lab 8 Version
@
@ NOTE THERE IS A DATA SECTION AT THE END OF THIS FILE FOR ASSIGNMENT 4
@ USE THAT DATA SECTION FOR ANY DATA YOU NEED, DO NOT ADD ANOTHER.

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

    .global ddhimmar3070_lab8        @ Make the symbol name for the function visible to the linker

    .code   16              @ 16bit THUMB code (BOTH .code and .thumb_func are required)
    .thumb_func             @ Specifies that the following symbol is the name of a THUMB
                            @ encoded function. Necessary for interlinking between ARM and THUMB code.

    .type   ddhimmar3070_lab8, %function   @ Declares that the symbol is a function (not strictly required)

@ Function Declaration : void ddhimmar3070_lab8(void)
@
@ Input: none
@ Returns: nothing
@ 

@ Here is the actual ddhimmar3070_lab8 function
ddhimmar3070_lab8:
    push {lr}

    @ For now, this function just toggles, delays, and toggles again.
    mov r0, #3
    bl BSP_LED_Toggle

    ldr r0, =0xFFFFFFF
    bl busy_delay

    mov r0, #3
    bl BSP_LED_Toggle

    pop {lr}
    bx lr                           @ Return (Branch eXchange) to the address in the link register (lr) 
    .size   ddhimmar3070_lab8, .-ddhimmar3070_lab8    @@ - symbol size (not strictly required, but makes the debugger happy)


@@ Function Header Block

    .global ddhimmar3070_lab9        @ Make the symbol name for the function visible to the linker
    .type   ddhimmar3070_lab9, %function   @ Declares that the symbol is a function (not strictly required)

@ Function Declaration : int ddhimmar3070_lab9(void)
@
@ Input: None
@ Returns: r0
@ 

@ Here is the actual ddhimmar3070_lab9 function
ddhimmar3070_lab9:
    push {lr}

ldr r1, =0x48001014
 
    ldrh r0, [r1]

   ldr r2, =0xAA00
   eor r0, r0, r2
   
    strh r0, [r1]

    mov r0, #0
    pop {lr}
    bx lr

    .size   ddhimmar3070_lab9, .-ddhimmar3070_lab9    @@ - symbol size (not strictly required)


.global ddhimmar3070_a4
.type   ddhimmar3070_a4, %function

@ Function Declaration : int ddhimmar3070_a4(int x)
@
@ Input: Document this
@ Returns: Document this
@ 

@ Here is the actual function
ddhimmar3070_a4:
    push {r4, lr}

    @ r0 = status
    @ r1 = num_to_skip
    @ r2 = direction

    @ Save running status
    ldr r3, =a4_is_running
    str r0, [r3]

    @ Save number of ticks to skip
    ldr r3, =a4_num_to_skip
    str r1, [r3]

    @ Direction 0 means keep the previous direction
    cmp r2, #0
    beq a4_keep_direction

    @ Save new direction
    ldr r3, =a4_direction
    str r2, [r3]

a4_keep_direction:

    @ If status is zero or negative, stop and return
    cmp r0, #0
    ble a4_function_end

    @ Reset skip counter
    ldr r3, =a4_skip_count
    mov r0, #0
    str r0, [r3]

    @ Reset current LED to 0
    ldr r3, =a4_current_led
    str r0, [r3]

    @ Turn off all 8 LEDs
    mov r4, #0

a4_led_off_loop:
    mov r0, r4
    bl BSP_LED_Off

    add r4, r4, #1
    cmp r4, #8
    blt a4_led_off_loop

a4_function_end:
    mov r0, #0
    pop {r4, lr}
    bx lr
    .size   ddhimmar3070_a4, .-ddhimmar3070_a4

.global ddhimmar3070_a5
.type   ddhimmar3070_a5, %function

@ Function Declaration : int ddhimmar3070_a5(int status, int num_to_skip, int direction)
@
@ Input:
@   r0 = status
@   r1 = num_to_skip
@   r2 = direction
@
@ Returns:
@   r0 = 0
@
@ Here is the actual function
ddhimmar3070_a5:
    push {r4, lr}

    @ Save running status
    ldr r3, =a5_running
    str r0, [r3]

    @ Save number of ticks to skip
    ldr r3, =a5_num_to_skip
    str r1, [r3]

    @ Direction 0 means keep the previous direction
    cmp r2, #0
    beq a5_keep_direction

    @ Save new direction
    ldr r3, =a5_direction
    str r2, [r3]

a5_keep_direction:

    @ If status is zero or negative, stop and return
    cmp r0, #0
    ble a5_function_end

    @ Reset skip counter
    ldr r3, =a5_skip_count
    mov r0, #0
    str r0, [r3]

    @ Reset current LED to 0
    ldr r3, =a5_current_led
    str r0, [r3]

a5_function_end:

 @ Initialize watchdog with reload value 8000
    ldr r0, =8000
    bl mes_InitIWDG

    @ Start watchdog
    bl mes_IWDGStart

    mov r0, #0
    pop {r4, lr}
    bx lr

.size ddhimmar3070_a5, .-ddhimmar3070_a5

.global ddhimmar3070_a4_btn
.type   ddhimmar3070_a4_btn, %function

@ Function Declaration : void ddhimmar3070_a4_btn(void)
@
@ Input: None
@ Returns: Nothing
@ 
@ Reminder - this requires the button has been initialized as an interrupt
@ in main.c using BSP_PB_Init(BUTTON_USER, BUTTON_MODE_EXTI)
@ as well as requires a new function set up void EXTI0_IRQHandler(void)

@ Here is the actual function
ddhimmar3070_a4_btn:
    push {lr}

    ldr r1, =a4_button_count        @ Get the address of the counter
    ldr r0, [r1]                    @ Get the actual count
    add r0, r0, #1                  @ Increment the count
    and r0, #7                      @ Keep the count between 0 and 7
    str r0, [r1]                    @ Store the new count

    bl BSP_LED_Toggle               @ Toggle the current LED

    pop {lr}
    bx lr
    .size   ddhimmar3070_a4_btn, .-ddhimmar3070_a4_btn


.global ddhimmar3070_a4_tick
.type   ddhimmar3070_a4_tick, %function

@ Function Declaration : void ddhimmar3070_a4_tick(void)
@
@ Input: None
@ Returns: Nothing
@ 

@ Here is the actual function
ddhimmar3070_a4_tick:
    push {r4, lr}

    @ As a starting point, this function implements the basics needed
    @ to determine if our A4 logic should be running.
    @
    @ You will have to add logic here for A4.

    @ Some useful notes
    @
    @ BSP_LED_On, BSP_LED_Off - same argument as BSP_LED_Toggle, sets
    @ the LED to ON or OFF as you tell it
    @
    @ How to delay: DO NOT use busy_delay - remember, this is an interrupt
    @ handler. If you need a delay, use a counter to count how many times
    @ this function has been called, and use that to skip a desired number
    @ of calls.


    @ ***** Get something
    ldr r1, =a4_is_running
    ldr r0, [r1]

    @ ***** Check something
    cmp r0, #0
    ble a4_skip

        @ This part below is skipped if A4 is NOT running. You will want to
        @ keep all your A4 logic inside here.
        @ DO NOT PUT LOGIC FOR A4 ABOVE THIS LINE -----------------------------

        @ Even within this logic, you should still take a philosopy of check
        @ things, do things, and store things - do not use delays of any sort,
        @ and only use loops if they are bounded (that is, guaranteed to end)

       ldr r1, =a4_skip_count
       ldr r2, [r1]

        @ Load the requested skip count
        ldr r3, =a4_num_to_skip
        ldr r3, [r3]

        @ Check if it is time to toggle
        cmp r2, r3
        bge a4_take_action

        @ Not yet - increment counter and exit
        add r2, r2, #1
        str r2, [r1]
        b a4_skip

a4_take_action:

    @ Reset skip counter
    ldr r1, =a4_skip_count
    mov r2, #0
    str r2, [r1]

   @ Load current LED
ldr r1, =a4_current_led
ldr r4, [r1]

@ Toggle current LED
mov r0, r4
bl BSP_LED_Toggle

@ Load direction
ldr r2, =a4_direction
ldr r2, [r2]

@ Move to next/previous LED
add r4, r4, r2

@ Keep LED between 0 and 7
and r4, r4, #7

@ Reload the address because BSP_LED_Toggle may change r1
ldr r1, =a4_current_led
str r4, [r1]

        @ DO NOT PUT LOGIC FOR A4 BELOW THIS LINE -----------------------------
        @ End of A4 skipped logic. Do not add logic below here.

    a4_skip:

    @ ***** End of our tick function
    pop {r4, lr}
    bx lr
    .size   ddhimmar3070_a4_tick, .-ddhimmar3070_a4_tick

    .global ddhimmar3070_a5_tick
.type ddhimmar3070_a5_tick, %function

@ Function Declaration : void ddhimmar3070_a5_tick(void)
@
@ Input: None
@ Returns: Nothing
@
@ Here is the actual function
ddhimmar3070_a5_tick:
    push {lr}

    @ Check whether A5 is running
    ldr r1, =a5_running
    ldr r0, [r1]

    cmp r0, #0
    ble a5_skip

     @ Refresh watchdog while A5 is running
     bl mes_IWDGRefresh

    @ Toggle Upper Left, Upper Right, Lower Left and Lower Right LEDs
    @ directly through the GPIOE output data register
    ldr r1, =0x48001014
    ldrh r0, [r1]

    ldr r2, =0x5500
    eor r0, r0, r2

    strh r0, [r1]

a5_skip:
    pop {lr}
    bx lr

.size ddhimmar3070_a5_tick, .-ddhimmar3070_a5_tick


@ Function Declaration : int busy_delay(int cycles)
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


@ Here is another data section, we will use it for some key interrupt items
@ We will put all necessary data for A4 in this block
.data
a4_is_running:   .word 0
a4_button_count: .word 0

a4_num_to_skip:  .word 0
a4_direction:    .word 1
a4_skip_count:   .word 0
a4_current_led:  .word 0

a5_running:      .word 0
a5_num_to_skip:  .word 0
a5_direction:    .word 1
a5_skip_count:   .word 0
a5_current_led:  .word 0


@ Assembly file ended by single .end directive on its own line
.end

Things past the end directive are not processed, as you can see here.
