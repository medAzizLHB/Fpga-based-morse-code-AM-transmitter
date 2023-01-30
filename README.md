# Fpga based morse code AM transmitter
 FPGA based morse code AM transmitter
 A VHDL project for interfacing PS/2 keyboard and generating Morse code to the entered text then modulated with Double-sideband with-carrier modulation (DSWC) to be transmitted wirelessly
 As of today the project consists of the following files:
	1. pdatahold.vhd : This code holds the parallel data.
	2. letters.vhd : This code takes the 7 bit binary number that represents a letter and outputs the correct Morse code for the letter inputted.
	3. soundout.vhd : This code is used by the Letters.vhd.  It is for outputting either a short pulse or a long pulse.
	4. stop. vhd : This is the code for converting the serial data in from the keyboard to parallel data (a 7 bit binary number that represents a letter).



All future progress will be uploaded here regularely 

Written by medazizlhb