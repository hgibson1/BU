#include <msp430.h> 
#include <stdlib.h>

//Button
#define START_BUTTON 0x08;

//ADC pin
#define ADC_PIN 0x10

//State LED
#define RED 0x01

//Communication lines
#define SPI_CLK 0x20
#define SPI_SOMI 0x40
#define SPI_SIMO 0x80

//Other SPI config
#define LOW_BIT_RATE 32 //TODO calculate low bit rate
#define HIGH_BIT_RATE 8 //TODO calculate high bit rate

//Guess info
volatile unsigned int secret_number;
volatile unsigned int guesses;
volatile char tx_data;
volatile unsigned int rx_data;

int main(void) {
	//Configure clock
	BCSCTL1 = CALBC1_8MHZ;
	DCOCTL = CALDCO_8MHZ;
	
	//Configure WDT
    WDTCTL = WDTPW + WDTHOLD;

    //Random number generator
    //Uses analog to Digital converter as seed
    //reading voltage of pin 0x10
    //ADC10 triggers conversion
    //clock = clock / 1
    //Source = SMCLK
    //single channel, single conversion
    ADC10CTL1 = INCH_4 + SHS_0 + ADC10DIV_0 + ADC10SSEL_3 + CONSEQ_0;
    ADC10AE0 |= ADC_PIN;
    //Reference voltages are Vss and Vref+ = 1.5 V
    //Since Vss likely to be close to ground, smaller reference volatge gives larger range
    //Sample period = 4 clock cycles, smallest amount of time for more unsettled value
    ADC10CTL0 = SREF_1 + ADC10ON + ADC10SHT_0 + REFON + ENC + ADC10IE; //

    //State varibles
    guesses = 0;

    //LED
    P1DIR |= RED;
    P1OUT &= ~RED;

    //Initialize Start Button
    P1REN |= START_BUTTON; //enable pullup resistors
    P1IES |= START_BUTTON; //set for 1->0 transition
    P1IFG &= ~START_BUTTON; //clear interrupt flag
    P1IE |= START_BUTTON; //enable interrupts
    P1OUT |= START_BUTTON;

    //Communication lines
    //configured as inputs by default
    P1SEL |= SPI_CLK + SPI_SIMO + SPI_SOMI;
    P1SEL2 |= SPI_CLK + SPI_SIMO + SPI_SOMI;

	//Configure SPI
    //SMCLK is the source
    UCB0CTL1 = UCSWRST + UCSSEL_3;
    //Active High
    //Data capture on falling edge
    //3 pin spi mode
    //SPI sync mode
    //A is master, initializes communication
	UCB0CTL0 = UCCKPH + UCMODE_0 + UCMST + UCSYNC;
	UCB0BR0 = LOW_BIT_RATE; //Low bit rate
	UCB0BR1 = HIGH_BIT_RATE; //High bit rate
	UCB0CTL1 &= ~UCSWRST; //enable UCB0
    IE2 |= UCB0RXIE; //enable recieve interrupt

    _bis_SR_register(GIE + LPM0_bits);
}

interrupt void button_handler() {
	P1IFG &= ~START_BUTTON; //clear interrupt flag
    //triggers ADC conversion which seeds random number generator
    ADC10CTL0 |= ADC10SC;
    //disable button interrupt
    P1IE &= ~START_BUTTON; //disable interrupts
    P1OUT &= ~RED;
}

interrupt void ADC_handler() {
	srand(ADC10MEM); //seeds rand function with value of ADC conversion
	//generates random number
	secret_number = rand() % 0xff;

	//starts SPI communication
	tx_data = 0b01000001; // "A"
	IE2 |= UCB0TXIE; //Enable transmit interrupt

}

interrupt void SPI_rx() {
	rx_data = (unsigned int) ((UCB0RXBUF & 0b1) << 7) + ((UCB0RXBUF & 0b10) << 5) + ((UCB0RXBUF & 0b100) << 3) + ((UCB0RXBUF & 0b1000) << 1) +
			    ((UCB0RXBUF & 0b10000) >> 1) + ((UCB0RXBUF & 0b100000) >> 3) + ((UCB0RXBUF & 0b1000000) >> 5) + ((UCB0RXBUF & 0b10000000) >> 7); //Bit reversed UCB0RXBUF
    if (rx_data == 0b01000010) { // "B"
	    //Tranmission has ended; cleanup and reset for new button press
		P1IE |= START_BUTTON; //reenable interrupts
		P1OUT |= RED;
	//Reading guesses from B
	} else if (rx_data > secret_number) { //rx_data has to be greater than 0
		tx_data = 0b00111110; // ">"
		guesses = guesses + 1;
    } else if (rx_data < secret_number) { //rx_data has to be greater than 0
    	tx_data = 0b00111100; // "<"
    	guesses = guesses + 1;
	} else if (rx_data == secret_number){
		tx_data = 0b00111101; // "="
	}
    IE2 |= UCB0TXIE; //Enable transmit interupt after transmit data calvulated
}

interrupt void SPI_tx() {
    UCB0TXBUF = tx_data;
    IE2 &= ~UCB0TXIE;
}

ISR_VECTOR(SPI_tx, ".int06")
ISR_VECTOR(SPI_rx, ".int07")
ISR_VECTOR(ADC_handler, ".int05")
ISR_VECTOR(button_handler, ".int02")
