/*
 *  C to assembler menu hook
 *
 *  Modified by ddhimmar3070
 * 
 */

#include "stm32f3_discovery_gyroscope.h"
#include <stdio.h>
#include <stdint.h>
#include <ctype.h>

#include "common.h"

int ddhimmar3070_lab6(int delay);

void Lab6_ddhimmar3070(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Lab 6\n\n"
	   "This command tests new lab 6 function by ddhimmar3070\n"
	   );

    return;
  }

  uint32_t delay;
  int fetch_status;

  fetch_status = fetch_uint32_arg(&delay);

  if (fetch_status) {
    delay = 1000000;
  }

  printf("ddhimmar3070_lab6 returned: %d\n", ddhimmar3070_lab6(delay) );
}

ADD_CMD("ddhimmar3070_lab6", Lab6_ddhimmar3070,"Test the new lab 6 function")

int ddhimmar3070_lab7(int delay);
void Lab7_ddhimmar3070(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Lab 7\n\n"
	   "This command tests new lab 7 function by ddhimmar3070\n"
	   );

    return;
  }

  uint32_t count;
  int fetch_count_status = fetch_uint32_arg(&count);

  if (fetch_count_status) {
    count = 10;
  }

  uint32_t delay;
  int fetch_delay_status = fetch_uint32_arg(&delay);

  if (fetch_delay_status) {
    delay = 0xFFFFF;
  }

  uint32_t axis;
  int fetch_axis_status = fetch_uint32_arg(&axis);

  if (fetch_axis_status) {
    axis = 0;
  }

  float xyz [3] = {0};
  for (uint32_t i = 0; i < count; i++) {
    BSP_GYRO_GetXYZ(xyz);
    if (axis == 0) {
    printf("Gyroscope returns;\n"
           "X: %f\n"
           "Y: %f\n"
           "Z: %f\n",
           xyz[0] / 256,
           xyz[1] / 256,
           xyz[2] / 256);
    }
    else if (axis == 1) {
      printf("X: %f\n", xyz[0] / 256);
    }
    else if (axis == 2) {
      printf("Y: %f\n", xyz[1] / 256);
    }
    else if (axis == 3) {
      printf("Z: %f\n", xyz[2] / 256);
    }

           printf("ddhimmar3070_lab7 returned: %d\n", ddhimmar3070_lab7(delay) );
  }
}

ADD_CMD("ddhimmar3070_lab7", Lab7_ddhimmar3070,"Test the new lab 7 function")


int ddhimmar3070_a3(uint32_t wait, char *pattern_ptr, uint32_t num );

void A3_ddhimmar3070(int action)
{
    if(action==CMD_SHORT_HELP) return;

    if(action==CMD_LONG_HELP) {
        printf("Assignment 3\n\n"
               "Usage:\n"
               "ddhimmar3070_a3 wait pattern num\n");
        return;
    }

uint32_t wait;
uint32_t num;
char *pattern;

if (fetch_uint32_arg(&wait)) {
  wait = 400000;

  if (fetch_string_arg(&pattern))
    pattern = "123";

if (fetch_uint32_arg(&num))
    num = 2;

printf("ddhimmar3070_a3 returned: %d\n\n",
       ddhimmar3070_a3(wait, pattern, num));
}
}

ADD_CMD("ddhimmar3070_a3", A3_ddhimmar3070,"Run A3 for ddhimmar3070")
