/*
 * C to assembler menu hook
 */

#include <stdio.h>
#include <stdint.h>
#include <ctype.h>

#include "common.h"

int ddhimmar3070_add_test(int x, int y, int delay);
int ddhimmar3070_string_test(char *p);
int ddhimmar3070_a2(int num, int wait); 

void AddTest(int action)
{
    uint32_t delay;
    int fetch_status;

    if(action==CMD_SHORT_HELP)
        return;

    if(action==CMD_LONG_HELP) {
        printf("Addition Test\n\n"
               "This command tests new addition function\n");
        return;
    }

    fetch_status = fetch_uint32_arg(&delay);

    if(fetch_status) {
        delay = 0xFFFFFF;
    }

    printf("ddhimmar3070_add_test returned: %d\n",
           ddhimmar3070_add_test(99, 87, delay));
}

ADD_CMD("ddhimmar3070_add", AddTest,
        "Test the new add function")

void ddhimmar3070_StringTest(int action)
{
    int fetch_status;
    char *destptr;

    if(action==CMD_SHORT_HELP)
        return;

    if(action==CMD_LONG_HELP) {
        printf("String Test\n\n"
               "This command tests new string function by ddhimmar3070\n");
        return;
    }

    fetch_status = fetch_string_arg(&destptr);

    if(fetch_status) {
        destptr = "TESTING";
    }

    printf("string_test returned: %d\n",
           ddhimmar3070_string_test(destptr));
}

ADD_CMD("ddhimmar3070_string", ddhimmar3070_StringTest,
        "Test the new string function")

        // Assignment 2 C Hook Function
//
void _ddhimmar3070_Assignment2(int action)
{
    uint32_t count;
    uint32_t delay;
    int fetch_status;

    if(action==CMD_SHORT_HELP)
        return;

    if(action==CMD_LONG_HELP) {
        printf("Assignment 2\n\n"
               "This command triggers assignment 2 by ddhimmar3070\n");
        return;
    }

    fetch_status = fetch_uint32_arg(&count);

    if(fetch_status) {
        count = 1;
    }

    fetch_status = fetch_uint32_arg(&delay);

    if(fetch_status) {
        delay = 0xFFFFEF;
    }

    printf("ddhimmar3070_a2 returned: %d\n",
           ddhimmar3070_a2(count, delay));
}

ADD_CMD("ddhimmar3070_a2", _ddhimmar3070_Assignment2,
        "Assignment 2")