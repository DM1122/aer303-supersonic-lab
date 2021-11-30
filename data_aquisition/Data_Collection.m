


%% Data Collection

clearvars -except v_offset_mean
close all
clc

tare_data = 0;

%%%%%%%%%%%%%%% Sample Time and Frequency Input %%%%%%%%%%%%%%%%%%%%%%%%%

Time_samp = 5;      % sampling time in seconds (must be less than 24s for no error)
Freq_samp = 500;    % sampling frequency (must be less than 4166s for no error [~50000/12])


%%%%%%%%%%%%%%%  Collect Data and Convert to Pressure %%%%%%%%%%%%%%%%%%%

% Determine number of scans from frequency and sampling time...............
numScans = Time_samp * Freq_samp;

% Take offset measurements.................................................
if tare_data == 1
    ask = input('Take offset measurements for the pressure transducers with the tunnel off. Press enter to continue');
    [v_offset, ActualScanRate] = LabJack_ReadData(Freq_samp, numScans);
    v_offset_mean = mean(v_offset);
end

if exist('v_offset_mean') == 0
    fprintf('Error. Need to take offset measurements first.\nSet variable tare_data to 1 and try again\n')
    return
end

ask = input('Turn on the tunnel to take static tap measurements for taps 1 to 10. Press enter when done.');

[dataV, ActualScanRate] = LabJack_ReadData(Freq_samp, numScans);

% Convert Voltage to Pressure..............................................
deltaV  = dataV - repmat(v_offset_mean, numScans, 1);
dataP   = (dataV - repmat(v_offset_mean, numScans, 1)).* 1.7838e4 + 101325;

% Calculate Statistics for each channel....................................
deltaVmean  = mean(deltaV);
Pmean       = mean(dataP);
Pstd        = std(dataP);
cd Data
save('191028_Group1_StaticTapData_supersonic_1.mat') %CHANGE
cd ../


