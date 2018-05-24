#include <msp430g2553.h>

//My initials are "H,J,L,G",
//which results in a sequence of dot dot dot, dot dash dash dash, dot dash dot dot, dash dash dot

volatile unsigned int blink_interval;  // number of WDT interrupts per blink of LED
volatile unsigned int blink_counter;   // down counter for interrupt handler
//Sequence which will be used to toggle led
const short int blink_sequence[52] = {0,1,1,1,1,1, //H
		                              1,0,0, //pause
		                              0,1,1,1,0,0,1,1,0,0,1,1,0,0, //J
		                              1,0,0, //pause
		                              0,1,1,1,0,0,1,1,1,1, //L
		                              1,0,0, //pause
		                              0,1,0,0,1,1,0,0,1,1, //G
		                              1,0,0}; //pause
volatile short int index; //index into sequence


int main(void) {
	  // setup the watchdog timer as an interval timer
	  WDTCTL =(WDTPW + // (bits 15-8) password
	                   // bit 7=0 => watchdog timer on
	                   // bit 6=0 => NMI on rising edge (not used here)
	                   // bit 5=0 => RST/NMI pin does a reset (not used here)
	           WDTTMSEL + // (bit 4) select interval timer mode
	           WDTCNTCL +  // (bit 3) clear watchdog timer counter
	  		          0 // bit 2=0 => SMCLK is the source
	  		          +1 // bits 1-0 = 01 => source/8K
	  		   );
	  IE1 |= WDTIE;		// enable the WDT interrupt (in the system interrupt register IE1)

	  P1DIR |= 0x01;					// Set P1.0 to output direction

	  // initialize the state variables
	  blink_interval=67;                // the number of WDT interrupts per toggle of P1.0
	  blink_counter=blink_interval;     // initialize the counter
	  index = 0;                        // initialize index

	  P1OUT &= 0; //set LED off

	  _bis_SR_register(GIE+LPM0_bits);  // enable interrupts and also turn the CPU off!
}

// ===== Watchdog Timer Interrupt Handler =====
// This event handler is called to handle the watchdog timer interrupt,
//    which is occurring regularly at intervals of about 8K/1.1MHz ~= 7.4ms.

interrupt void WDT_interval_handler(){
  if (--blink_counter==0){          // decrement the counter and act only if it has reached 0
	  P1OUT ^= blink_sequence[index];                   // toggle LED on P1.0
	  blink_counter=blink_interval; // reset the down counter
	  index++; //increment the index
	  if (index > 51) index = 0; //reset index if it is greater than the length of the sequence array
  }
}
// DECLARE function WDT_interval_handler as handler for interrupt 10
// using a macro defined in the msp430g2553.h include file
ISR_VECTOR(WDT_interval_handler, ".int10")
