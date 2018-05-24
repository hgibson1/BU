#include <msp430.h>

void delay(const unsigned int DELAY){
	volatile unsigned int i = DELAY ;	// volatile to prevent optimization
	do i--;
	while(i > 0);
}

void dot(const unsigned int DELAY){
	P1OUT |= 1; //turns on LED
	delay(DELAY); //delays one DELAY
	P1OUT &= 0; //turns off LED
	delay(DELAY); //delays one DELAY
}

void dash(const unsigned int DELAY){
	P1OUT |= 1; //turns on LED
	//const unsigned int dash_delay = 60000;
	delay(DELAY*3); //delay's three delays
	P1OUT &= 0; //turns off LED
	delay(DELAY); //delays one DELAY
}

int main(void) {
	WDTCTL = WDTPW | WDTHOLD;		// Stop watchdog timer
	P1DIR |= 0x01;					// Set P1.0 to output direction
	//My initails are HJLG
	//This is represented in mores code as
	//[dot dot dot dot][dot dash dash dash][dot dash dot dot][dash dash dot]
	//Each dot LED on for a period of 1 delay
	//Each dash LED on for 3 delays
	const unsigned int DELAY = 20000;

	for (;;){
		P1OUT &= 0x00; //turns off LED
		//H
		dot(DELAY);
		dot(DELAY);
		dot(DELAY);
		//Additional delay to see break between sequences
	    delay(DELAY*3);
		//J
		dot(DELAY);
		dash(DELAY);
		dash(DELAY);
		dash(DELAY);
		//Additional delay to see break between sequences
	    delay(DELAY*3);
		//L
		dot(DELAY);
		dash(DELAY);
		dot(DELAY);
		dot(DELAY);
		//Additional delay to see break between sequences
		delay(DELAY*3);
		//G
		dash(DELAY);
		dash(DELAY);
		dot(DELAY);
		//Additional delay to see break between sequences
		delay(DELAY*3);
	}
	return 0;
}
