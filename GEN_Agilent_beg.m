h = visa('agilent','TCPIP::10.70.13.216::INSTR');
h.inputbuffersize = 1000000;
fopen(h);
fprintf(h, '*RST'); %Reset the function generator
fprintf(h,'FUNC SINUSOID');%Select waveshape
fprintf(h,'OUTPut:LOAD 50'); %Set the load impedance to 50 Ohms (default) 
fprintf(h,'VOLTage 0.1'); %Set the amplitude to 100 mV-pp
fprintf(h,'SWEep:SPACing LIN'); %Set linear spacing;
fprintf(h,'SWEep:TIME 10'); %Set Sweep time 5s 
fprintf(h,'FREQuency:STARt 1e(-6)'); %Set Start frequency 1 microHz 
fprintf(h,'FREQuency:STOP 20e6'); %Set Stop frequency 20 MHz 
fprintf(h,''); %Set type of internal triggering
fprintf(h,'OUTPut ON'); %Turn on the instrument output 
fprintf(h,'SWEep:STATe ON');%Turn sweep on
fclose(h);