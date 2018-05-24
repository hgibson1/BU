//ek307master.c: This file contains several useful commands and prewritten sections of c.code 
//that you can use in building your program.
//If a line of code is followed by //!!! , do NOT remove it from the program. 
//It is required to make the MSP430 chip or your code run properly.
 
#include  <msp430g2231.h>                               //!!!

int T=0;

// ===== SLEEP TIMER ROUTINE===== 
void main(void) {                                       //!!!
BCSCTL1 = CALBC1_1MHZ;                                  //!!!
DCOCTL  = CALDCO_1MHZ;                                  //!!!
WDTCTL =(WDTPW + WDTTMSEL +  WDTCNTCL +  T);            //!!!
//In the above statement, set the sleep timer “wakeup interval” T which  
//indicates how often the timer will wake up and execute the 
//“CODE THAT GETS EXECUTED ONCE EACH TIME THE TIMER WAKES UP” 
//(see below).  
//Set wakeup time T as follows:  0=33ms, 1=8.2ms, 2=0.5ms, 3=65us.
IE1 |= WDTIE;                                           //!!!
  

//SET THE DIRECTIONALITY OF THE PORT1 PINS:
  P1DIR = 255;          //Set all pins of Port 1 (P1.0 to P1.7) to outputs 
//P1DIR = 0;            //Set all pins of Port 1 (P1.0 to P1.7) to inputs 
//P1DIR = 1+2+4+8       //Set Port1 pins 0-3 as outputs, pins 4-7 as inputs
//P1DIR = 16+32+64+128  //Set Port 1 pins 4-7 as outputs, 
                        //and pins 0-3 as inputs          
 
//SET THE DIRECTIONALITY OF THE PORT2 PINS:  
P2SEL=0;                                                //!!!  
  P2DIR = 0;      // Set XIN=input  and XOUT=input   
//P2DIR = 64;     // Set XIN=output and XOUT=input
//P2DIR = 128;    // Set XIN=input  and XOUT=output 
//P2DIR = 128+64; // Set XIN=output and XOUT=output
_bis_SR_register(GIE+LPM0_bits);                        //!!!
}


//=== CODE THAT GETS EXECUTED ONCE EACH TIME THE TIMER WAKES UP===
interrupt void WDT_interval_handler()                  //!!!
{                                                      //!!!

//EXAMPLES of WHAT MIGHT APPEAR IN YOUR CODE:      

//Some commands to write to Ports that have been configured as outputs:
P1OUT = 1;
//P1OUT=0;      // Sets all pins of Port1 to 0
//P1OUT=128+32; // Sets P1.7 and P1.5 to 1; all other Port1 pins to 0
//P1OUT=160;    // Same as above, but uses 128+32=160 on the RHS 
//P2OUT=128;    // Sets XOUT pin to 1  
//P2OUT=64;     // Sets XIN  pin to 1  
//P2OUT=0;      // Sets XIN and XOUT to 0

//Some commands to read from a port that has been configured as input  
//n=P1IN;     // Sets n to a number between 0 and 255 depending on the
            // high or low state of the individual pins of Port 1 
            // Example: n will be read in as 128+32+1 = 161 if 
            // the voltages applied to Port1 = [1 0 1 0 0 0 0 1] 
            // Remember that 1=high=(3.3V) and 0=low=(0 V)
//k=P2IN;     // Yields k=64 if XIN is high; k=128 if XOUT is high; and
            // k=128+64=192 if both are high

}                                                     //!!! 
// LEAVE THE FOLLOWING STATEMENT AT THE END OF YOUR PROGRAM
// DECLARES WDT_interval_handler as handler for interrupt 10
   ISR_VECTOR(WDT_interval_handler, ".int10")        //!!!
