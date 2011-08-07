#include "xparameters.h"
#include "xbasic_types.h"
#include "xstatus.h"

int main (void)
{
  // Display message
  xil_printf("%c[2J",27);
  xil_printf("Tri-mode Ethernet MAC Loop-back");
  xil_printf(" by Virtex-5 Resource\n\r");
  xil_printf("http://virtex5.blogspot.com\n\r");

  // Stay in an infinite loop
  while(1){
  }
}
