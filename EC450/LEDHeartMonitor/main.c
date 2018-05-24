#include <msp430g2553.h>

void main(void){
BCSCTL1 = CALBC1_1MHZ;                                 
DCOCTL  = CALDCO_1MHZ;                                
WDTCTL =(WDTPW + WDTTMSEL +  WDTCNTCL +  0);
//sets frequnecy of watchdog timer as 2.2 ms
IE1 |= WDTIE;       
P1DIR = 0; //sets all pin 1 as inputs
P2DIR = 255; //sets all pin 2 as outputs  
_bis_SR_register(GIE+LPM0_bits);                                                  
}

interrupt void WDT_interval_handler(){   
	if (P1IN == 1){
	P2OUT = 1;	
	}
}
// DECLARES WDT_interval_handler as handler for interrupt 10
   ISR_VECTOR(WDT_interval_handler, ".int10")   