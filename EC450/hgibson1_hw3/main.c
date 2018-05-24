#include <msp430.h> 

// Bit masks for port 1
#define RED 0x01
#define GREEN 0x40
#define BUTTON 0x08
#define SEQUENCE_LENGTH 6
#define PLAY 0
#define RECORD 1
#define DELAY 0xfff

// Global state variables
volatile unsigned char last_button_state; // the state of the button bit at the last interrupt
unsigned short int sequence[SEQUENCE_LENGTH];
unsigned char state[SEQUENCE_LENGTH];
unsigned char mode;
unsigned char index;
unsigned short int delay;

void main(void) {
	  // setup the watchdog timer as an interval timer
	WDTCTL =(WDTPW + WDTTMSEL + WDTCNTCL + 0 + 1);
	  IE1 |= WDTIE;		// enable the WDT interrupt (in the system interrupt register IE1)

	  P1DIR |= RED;				// Set RED and GREEN to output direction
	  P1DIR |= GREEN;
	  P1DIR &= ~BUTTON;						// make sure BUTTON bit is an input

	  P1OUT |= GREEN; // Green on
	  P1OUT &= ~RED;  // Red off

	  P1OUT |= BUTTON;
	  P1REN |= BUTTON;						// Activate pullup resistors on Button Pin

	  mode = RECORD;
	  index = 0;
	  delay = 0;
	  last_button_state = (P1IN & BUTTON); //initializes last button state
	  P1OUT |= GREEN;
	  P1OUT &= ~RED;

	  _bis_SR_register(GIE+LPM0_bits);  // enable interrupts and also turn the CPU off!
}

// ===== Watchdog Timer Interrupt Handler =====

interrupt void WDT_interval_handler(){
	unsigned current_button_state = (P1IN & BUTTON);
	if (mode == RECORD) {
		if (last_button_state != current_button_state && delay != DELAY){
			if (index < SEQUENCE_LENGTH) {
				//toggles LED when button pressed
				P1OUT ^= RED;
			    sequence[index] = delay; //puts delay period in sequence array
			    state[index] = 1; //
			    //sets value indicating whether red LED should change state
			    //necessary because if timeout should NOT change state
			    //but if button pushed led should change state
			    delay = 0;
				index = index + 1;
			} else {
				index = 0;
				delay = sequence[index]; //sets initial delay for play setting
				mode = PLAY;
				P1OUT &= ~GREEN;
			}
		} else if (last_button_state == current_button_state) {
			if (delay == DELAY) {
				//button pressed or not pressed for maximum delay period
				if (index < SEQUENCE_LENGTH) {
					//moves to next position in sequence
				    sequence[index] = delay;
					state[index] = 0;
					delay = 0;
					index = index + 1;
			    } else {
			    	//timeout
			    	//switching modes
					index = 0;
					delay = sequence[index]; //sets initial delay for play setting: delay = sequence[0]
					mode = PLAY;
					P1OUT &= ~GREEN;
			    }
			} else {
				//max delay period has not been reached so delay increases
				delay = delay + 1;
			}

		}
	} else if (mode == PLAY) {
		if (delay == 0) {
			//indicates LED blink has finished play back, moves to next position in sequence
			if (index < SEQUENCE_LENGTH) {
				P1OUT ^= (RED & state[index]); //will toggle LED if state = 1, otherwise led state will stay the same
				index = index + 1;
				delay = sequence[index];
			} else {
				//sequence done playing
				//switching modes
				index = 0;
				mode = RECORD;
				P1OUT |= GREEN;
			}
		} else {
			delay = delay - 1;
		}
	}
	last_button_state = current_button_state;
}

ISR_VECTOR(WDT_interval_handler, ".int10")
