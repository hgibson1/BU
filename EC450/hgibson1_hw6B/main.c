#include <msp430.h> 

//Communication lines
#define SPI_CLK 0x20
#define SPI_SOMI 0x40
#define SPI_SIMO 0x80

//Other SPI config
#define LOW_BIT_RATE 32 //TODO calculate low bit rate
#define HIGH_BIT_RATE 8 //TODO calculate high bit rate

//Guess info
#define MAX_VAL 255
volatile unsigned int upper_limit;
volatile unsigned int lower_limit;
volatile unsigned int guesses;
volatile unsigned int tx_data;
volatile char rx_data;

int main(void) {
	//Configure clock
	BCSCTL1 = CALBC1_8MHZ;
	DCOCTL = CALDCO_8MHZ;
	
	//Configure WDT
    WDTCTL = WDTPW + WDTHOLD;

    //State varibles
    guesses = 0;

    //Communication lines
    //configured as inputs by default
    P1SEL |= SPI_CLK + SPI_SIMO + SPI_SOMI;
    P1SEL2 |= SPI_CLK + SPI_SIMO + SPI_SOMI;

	//Configure SPI
    //SMCLK is the source
    //Clock divided by 1
    UCB0CTL1 = UCSWRST + UCSSEL_3;
    //Active high
    //Data capture on falling edge
    //3 pin spi mode
    //SPI sync mode
	UCB0CTL0 = UCCKPH + UCMODE_0 + UCSYNC;
	UCB0BR0 = LOW_BIT_RATE; //Low bit rate
	UCB0BR1 = HIGH_BIT_RATE; //High bit rate
	UCB0CTL1 &= ~UCSWRST; //enable UCB0
	IE2 |= UCB0RXIE; //Enable recieve interrupt

    _bis_SR_register(GIE + LPM0_bits);
}


interrupt void SPI_rx() {
	rx_data = UCB0RXBUF; //recieved data copied to global varible
	if (rx_data == 0b01000001) { // "A"
        //Transmission has been intitalized
	    //first guess is half of max value
		upper_limit = MAX_VAL;
		lower_limit = 0;
		tx_data = (upper_limit + lower_limit)/2;
		guesses = guesses + 1;
	} else if (rx_data == 0b00111100) { // "<"
		//raise output value
		lower_limit = (upper_limit + lower_limit)/2;
		tx_data = (upper_limit + lower_limit)/2;
		guesses = guesses + 1;
    } else if (rx_data == 0b00111110) { // ">"
    	//Lower output
    	upper_limit = (upper_limit + lower_limit)/2;
        tx_data = (upper_limit + lower_limit)/2;
        guesses = guesses + 1;
    } else if (rx_data == 0b00111101) { // "="
        tx_data = 0b01000010; // "B", Transmission ends
        //Additional cleanup
    }
    IE2 |= UCB0TXIE; //Enable transmit interrupt

}

interrupt void SPI_tx() {
	UCB0TXBUF = tx_data;
	IE2 &= ~UCB0TXIE;
}

ISR_VECTOR(SPI_tx, ".int06")
ISR_VECTOR(SPI_rx, ".int07")



