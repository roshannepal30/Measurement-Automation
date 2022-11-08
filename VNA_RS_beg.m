clc; clear all; close all;
test_obj=visa('ni','TCPIP0::10.50.212.8::gpib0,2::INSTR'); % check IP address
%test_obj = visa('ni', 'GPIB2::10.50.212.8::0::INSTR');
set(test_obj,'InputBufferSize', 100000);
fopen(test_obj);
fprintf(test_obj, '*IDN?');
fscanf(test_obj)
fprintf(test_obj, 'INSTRument:SELect CHANNEL1'); % select channel 1
fprintf(test_obj, 'SENS:FREQ:START 9KHz'); % set start frequency
fprintf(test_obj, 'SENS:FREQ:STOP 200MHz'); % set stop frequency
fprintf(test_obj, 'SENS:SWE:POIN 801'); % set number of points <= 801 (NA limit <=
%2001)
fprintf(test_obj, 'FREQ:MODE SWEEP');
fprintf(test_obj, 'SENS:SWE:SPAC LOG'); % set log sweep
fprintf(test_obj, 'CALC1:FORM COMP'); % set format complex (Smith chart)
fprintf(test_obj, 'INIT:CONT OFF'); % turn off continuous mode , we run the code twice in
%order to get accurate plot !!!
fprintf(test_obj, 'INIT:IMM; *WAI') ; % wait command
fprintf(test_obj, 'TRAC? CH1DATA') ; % read data of channel 1
s = fscanf(test_obj) ;%data_points
data_points = str2num(s) ;
fclose(test_obj) ;
re = data_points(1:2:1602);
im = data_points(2:2:1602);
plot(re,im);
title('Smith Chart for Start Frequency = 10Hz and Stop Frequency = 40Mhz');
fid = fopen('cableopen.txt','w');
fprintf(fid, '%f', data_points);
fclose(fid);