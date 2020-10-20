# Asynchronous FIFO #1
<br />

This is a custom asynchronous FIFO with minor spec adjustments. The interface requirements of this FIFO have been listed out below.
<br />
  - The FIFO works on two seperate frequencies anmely, WRITE_CLK and READ_CLK
  - Input and output data widths are configurable ( Although, they are required to be the same )
  - There is one input data bus ( for writes ) and one output data bus ( for reads )
  - Depth of the FIFO is configurable ( Although, it must always be a power of 2 )
  - FIFO has one asynchronous reset pin
  - FIFO has the generic **FULL** and **EMPTY** output pins
  - There is one additional output pin, **H_FULL**
  - FIFO has the generic input control pins, **WR_EN** and **RD_EN**
  - There on additional input pin, **H_FLUSH**
  
<br />

The functional specification of the FIFO are listed below.
<br />
  - WRITE_CLK is faster or euqal to the READ_CLOCK
  - The asynchronous reset is active **LOW**
  - Write has a priority over read
  - Reset may clear the memory ( Optional )
  - At the rising edge of WRITE_CLK, input data to the FIFO is push if **WR_EN** is asserted
  - At the rising edge of READ_CLK, if **RD_EN** is asserted then the one data is popped
  - The FIFO must only drive that read data on the **data out**, which it will pop on the next RD_EN
  - Data out must be driven to zero if the FIFO is EMPTY
  - The **EMPTY** pin must be asserted if the FIFO has no elements
  - The **FULL** pin must be asserted if the FIFO has maxed out the number of elements 
  - The **H_FULL** if the number of elements in the FIFO is more than or equal to half the depth of the FIFO
  - Assertnig the **H_FLUSH** will result in half of the upcoming elements to be read out, to be popped instantly ( eg, if the FIFO had initially 5 elements, then after the H_FLUSH, it will only have 2 elements )
