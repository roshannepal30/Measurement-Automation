clc; close all; clear all;
h = visa('ni','TCPIP::10.70.13.175::INSTR');  % check IP address!!!
h.inputbuffersize = 1000000;
fopen(h);
fprintf(h, 'FREQ:START 9KHz') % set start frequency
fprintf(h, 'FREQ:STOP 20MHz') % set stop frequency

%similar to the resoltion bandwidth,
fprintf(h, 'BAND:VID 1kHz') % set video bandwidth to 1 kHz

%the narrower the resolution bandwidth, the morse distinctive the frequency
%compoment but at the cost of larger sweep time.
fprintf(h, 'BAND:RES 100kHz') % set resolution bandwidth to 100 kHz

fprintf(h, 'SWE:POIN 10001\n') % set number of points to 10001
fprintf(h,'FORM ASCII');
pause(40) %waiting for some time so that complete data is plotted on the screen of instrument.
fprintf(h,'TRAC? TRACE1');
tr = fscanf(h);
fclose(h);
trace = str2num(tr);
size(trace);
freq = linspace(1,4, 601);
plot(freq,trace);
xlabel('Frequency (Hz)');
ylabel('Magnitude (Hz)');
title('Plot of 9 KHz to 20 MHz for video Bandwidth of 1KHz');