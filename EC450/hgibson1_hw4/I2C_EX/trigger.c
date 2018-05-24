/*
 * trigger.c
 *
 *  Created on: Dec 11, 2015
 *      Author: hgibson1
 */

#include "msp430g2553.h"
#include "trigger.h"

void init_trigger(){
	TRIGGERPORT(OUT) &= ~TRIGGERBIT; //be ready with a 0 output
	TRIGGERPORT(DIR) |= TRIGGERBIT;  // set direction to be output
}

void trigger(){ //sends a short pulse on the trigger output
	TRIGGERPORT(OUT) ^= TRIGGERBIT;
	__delay_cycles(20);
	TRIGGERPORT(OUT) ^= TRIGGERBIT;
}


