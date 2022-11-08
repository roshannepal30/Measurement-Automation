clc; clear all; close all; 
test_obj=visa('ni','TCPIP::10.70.13.164::INSTR'); % check IP address
set(test_obj,'InputBufferSize', 100000); 
fopen(test_obj);
fprintf(test_obj , '*IDN?');
fscanf(test_obj)
fprintf(test_obj, 'LOGGer:AUToset');   % AUTOSET (seems to reset)
fprintf(test_obj, 'CHANnel1:STATe ON');   % Turn channel 1 on
fprintf(test_obj, 'CHANnel2:STATe ON');	% Turn channel 2 on
fprintf(test_obj, 'CHANnel1:SCALe 50');% Setting the vertical res. Ch1
fprintf(test_obj, 'CHANnel2:SCALe 50'); % Setting the vertical res. Ch2
fprintf(test_obj, 'LOGGer:SOURCe CHANnel1');
fprintf(test_obj, 'LOGGer:TIMebase:SCALe nS20');% Setting the time base - Ch1
fprintf(test_obj, 'TRIGger:EDGE:SLOPe POSitive'); % Set trigger edge slope to positive
fprintf(test_obj, 'TRIG:LEV1:VAL 0.005'); % Set trigger level to 0.005
fprintf(test_obj, 'TRIGger:SOURce CHANnel2'); % Set trigger source to be channel 2
fprintf(test_obj, 'TRIGger:MODE SING'); % Set trigger mode to SINGLE
fprintf(test_obj, 'CHAN1:DATA?');    % read data of Channel 1
s1 = fscanf(test_obj);
data_points1 = str2num(s1);
fprintf(test_obj, 'CHAN2:DATA?');    % read data of Channel 2
s2 = fscanf(test_obj);
data_points2 = str2num(s2);
%s = fscanf(test_obj);
fclose(test_obj);
plot(data_points1);
hold on;
plot(data_points2);
hold off;