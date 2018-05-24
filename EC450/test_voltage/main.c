#include <msp430g2553.h>

int main(void) {
	  BCSCTL1 = 0x0e;
	  DCOCTL = 0x50;

	  // setup the watchdog timer as an interval timer
	  WDTCTL =(WDTPW + // (bits 15-8) password
	                   // bit 7=0 => watchdog timer on
	                   // bit 6=0 => NMI on rising edge (not used here)
	                   // bit 5=0 => RST/NMI pin does a reset (not used here)
	           WDTTMSEL + // (bit 4) select interval timer mode
	           WDTCNTCL +  // (bit 3) clear watchdog timer counter
	  		          0   // bit 2=0 => SMCLK is the source
	  		          + 2 // bits 1-0 = 10 => source/512
	  		   );
	  IE1 |= WDTIE;		// enable the WDT interrupt (in the system interrupt register IE1)

	  P1DIR |= 0x01;					// Set P1.0 to output direction

	  // in the CPU status register, set bits:
	   //    GIE == CPU general interrupt enable
	   //    LPM0_bits == bit to set for CPUOFF (which is low power mode 0)

	  _bis_SR_register(GIE+LPM0_bits);  // enable interrupts and also turn the CPU off!
}

// ===== Watchdog Timer Interrupt Handler =====
// This event handler is called to handle the watchdog timer interrupt,
//    which is occurring regularly at intervals of about 8K/1.1MHz ~= 7.4ms.

interrupt void WDT_interval_handler(){
  P1OUT ^= 1;
}
// DECLARE function WDT_interval_handler as handler for interrupt 10
// using a macro defined in the msp430g2553.h include file
ISR_VECTOR(WDT_interval_handler, ".int10")

