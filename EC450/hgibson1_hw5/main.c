#include <msp430.h> 
//Note durations
#define WHOLE 32
#define HALF 16
#define QUARTER 8
#define EIGTH 4
#define SIXTEENTH 2
#define NOTE_WAIT_PERIOD 1

//Note pitches
#define low_Bb 253
#define middle_C 239
#define low_D  213
#define low_Eb 201
#define F  179
#define G  159
#define Ab 150
#define high_Bb 134
#define high_C 119
#define high_D 106
#define high_E 95

//Speaker
#define SPEAKER 0x02

//ADC
#define ADC_INPUT 0x10
#define ADC_DELTA 170
#define MAX_TEMPO 7
//current_note_duration is stored in an unsigned char
//its value is the GOT_NOTE_DURATION[current_note] * tempo
//the max GOT_NOTE_DURATION[current_note] is 31, so the max tempo is 255/31 = 7
//Tempo values can be [1,7]
//There is a 10 bit ADC and 6 possible tempos, so tempo value should only change if change in input voltage is +/- 1023/6 = +/- 170

#define SONG_LENGTH 28

const unsigned char GOT_NOTE_DURATIONS[SONG_LENGTH] = {QUARTER + EIGTH, QUARTER + EIGTH, SIXTEENTH, SIXTEENTH, QUARTER, QUARTER,
		                                               SIXTEENTH, SIXTEENTH, HALF + QUARTER, QUARTER + EIGTH, QUARTER + EIGTH, SIXTEENTH,
                                                       SIXTEENTH, QUARTER, QUARTER, SIXTEENTH, SIXTEENTH, HALF + QUARTER,
                                                       HALF + QUARTER, HALF + QUARTER, HALF + QUARTER, HALF + QUARTER,
                                                       HALF + QUARTER, QUARTER, QUARTER, SIXTEENTH, SIXTEENTH, HALF + QUARTER};
const unsigned char GOT_NOTE_FREQUENCIES[SONG_LENGTH] = {G, middle_C, middle_C, F, G, middle_C, middle_C, low_Eb, low_D,
                                                         F, low_Bb, low_Bb, low_Eb, F, low_Bb, low_Eb, low_D, middle_C,
                                                         high_C, high_Bb, Ab, G, low_Eb, low_D, F, low_Eb, low_D, middle_C};

//Song state varibles
unsigned char current_note;
unsigned char current_note_duration;
unsigned char tempo;
volatile unsigned int last_result;

int main(void) {
	//Calibrate clock
	BCSCTL1 = CALBC1_1MHZ;
	DCOCTL = CALDCO_1MHZ;

	//Initialize WDT
    WDTCTL = WDTPW + WDTTMSEL + WDTCNTCL + 0;	//Source /32k
	IE1 |= WDTIE;

	//initialize timer A
    TA0CTL |= TACLR; //clear TIMER
	TA0CTL |= TASSEL_2 + ID_3 + MC_1; //source = SMCLK, divider = 8, up mode
	TA0CCTL0 = 0; //Compare mode, outmod 0, interrupt disabled
	TA0CCR0 = GOT_NOTE_FREQUENCIES[0];
	P1SEL |= SPEAKER; //connect timer to bit that powers speaker
	P1DIR |= SPEAKER;

	//initialize ADC
	//Input channel 4, ADC10SC triggers sampling
	//Clock = SMCLK/8, same as tone clock divider
	//Not sure if it makes a difference
	//but it seems like they should be syncronized
	//Clock source = SMCLK
	//Single channel single conversion
    ADC10CTL1 = INCH_4 + SHS_0 + ADC10DIV_7 + ADC10SSEL_3 + CONSEQ_0;
    ADC10AE0 |= ADC_INPUT; //Enable channel 4 analog input
    ADC10CTL0 = 1; //1 block/ transfer
    //Reference voltages Vss and Vcc
    //64 ADC10 clock cycles for sample + hold time
    //Not sure if this clock is divided or not.
    //If this is undivied clock needs to be this length because clock diver = 8
    //If not can be shorter
    //ADC on and interrupt enabled
    ADC10CTL0 = SREF_0 + ADC10SHT_3 + ADC10ON + ENC + ADC10IE;

	 //State varibles
	 current_note = 0;
	 current_note_duration = GOT_NOTE_DURATIONS[0];
	
	_bis_SR_register(GIE + LPM0_bits);
}

//WDT interupts handler
interrupt void WDT_handler() {
	//Start conversion
	if (!(ADC10CTL1 & ADC10BUSY)) {
		ADC10CTL0 |= ADC10SC;
	}
}

//ADC handler involked when conversion is done
void interrupt ADC_handler() {
	//Clear interrupt flag
	ADC10CTL0 &= ~ADC10IFG;
	tempo = ADC10MEM/170 + 1; // range [1, 7]

	if (current_note_duration == 0){
		//note has finished playing, moving to next note
		current_note = current_note + 1;
		if (current_note == SONG_LENGTH) {
			//Is at end of song
			current_note = 0; //goes to begining of sequence
		}
		current_note_duration = GOT_NOTE_DURATIONS[current_note]*tempo;
		TA0CCR0 = GOT_NOTE_FREQUENCIES[current_note];
	} else if (current_note_duration <= NOTE_WAIT_PERIOD) {
		//This is the pause in between notes
		TACCTL0 &= ~OUTMOD_4; //shuts off sound
		current_note_duration = current_note_duration - 1;
	} else {
		//note is playing
		TACCTL0 |= OUTMOD_4;
		current_note_duration = current_note_duration - 1;
	}
}

ISR_VECTOR(ADC_handler, ".int05")
ISR_VECTOR(WDT_handler, ".int10")
