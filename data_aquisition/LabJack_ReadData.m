function [Data, ActualScanRate] = LabJack_ReadData (scanRate, numScans)
% Reads analog data from the LabJack U6.
% Required inputs are: - Scan Rate
%                      - Total Number of Scans
% The function will output a data array where each column is a channel and
% each row is a sample.
%
% Created by P.McCarthy,October 2016.

% Total number of Channels to be sampled.
numChannels = 12;
MaxSamplingTime = 25; % this is the time in seconds that is used to determine the required buffer size

% These are no longer required but kept for debugging
%scanRate = 50;
%numScans = 150;


%Make the UD .NET assembly visible in MATLAB
ljasm = NET.addAssembly('LJUDDotNet');
ljudObj = LabJack.LabJackUD.LJUD;


% Initialise variable for labjack communication. These should no be changed
ioType = 0;
channel = 0;
dblValue = 0;
dblCommBacklog = 0;
dblUDBacklog = 0;
Data= zeros(numScans,numChannels);
% Variables to satisfy certain method signatures
dummyInt = 0;
dummyDouble = 0;
dummyDoubleArray = [0];


try
    %Open the first found LabJack U6.
    [ljerror, ljhandle] = ljudObj.OpenLabJack(LabJack.LabJackUD.DEVICE.U6, LabJack.LabJackUD.CONNECTION.USB, '0', true, 0);
    
    %Configure the resolution of the analog inputs. The 0 corresponds to
    %the default resolution of 16 bits.
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_CONFIG, LabJack.LabJackUD.CHANNEL.AIN_RESOLUTION, 0, 0, 0);
    
    %Configure the analog input range of each channel for bipolar +-10 volts (LJ_rgBIP10V).
    LJ_rgBIP10V = ljudObj.StringToConstant('LJ_rgBIP10V');
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 0, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 1, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 2, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 3, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 4, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 5, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 6, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 7, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 8, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 9, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 10, LJ_rgBIP10V, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_AIN_RANGE, 11, LJ_rgBIP10V, 0, 0);
    
    %Set the scan rate.
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_CONFIG, LabJack.LabJackUD.CHANNEL.STREAM_SCAN_FREQUENCY, scanRate, 0, 0);
    
    %Set the buffer size based on scanRate, number of channels and maximum sampling time.
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_CONFIG, LabJack.LabJackUD.CHANNEL.STREAM_BUFFER_SIZE, scanRate*numChannels*MaxSamplingTime, 0, 0);
    
    %Configure reads to retrieve data when total number of required samples are recorded.
    LJ_swSLEEP = ljudObj.StringToConstant('LJ_swSLEEP');
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.PUT_CONFIG, LabJack.LabJackUD.CHANNEL.STREAM_WAIT_MODE, LJ_swSLEEP, 0, 0);
    
    %Define which channels to scan
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.CLEAR_STREAM_CHANNELS, 0, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 0, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 1, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 2, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 3, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 4, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 5, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 6, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 7, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 8, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 9, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 10, 0, 0, 0);
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.ADD_STREAM_CHANNEL, 11, 0, 0, 0);
    
    %Execute the list of requests.
    ljudObj.GoOne(ljhandle);
    
    %Get all the results just to check for errors.
    [ljerror, ioType, channel, dblValue, dummyInt, dummyDbl] = ljudObj.GetFirstResult(ljhandle, ioType, channel, dblValue, dummyInt, dummyDouble);
    finished = false;
    while finished == false
        try
            [ljerror, ioType, channel, dblValue, dummyInt, dummyDbl] = ljudObj.GetNextResult(ljhandle, ioType, channel, dblValue, dummyInt, dummyDouble);
        catch e
            if(isa(e, 'NET.NetException'))
                eNet = e.ExceptionObject;
                if(isa(eNet, 'LabJack.LabJackUD.LabJackUDException'))
                    if(eNet.LJUDError == LabJack.LabJackUD.LJUDERROR.NO_MORE_DATA_AVAILABLE)
                        finished = true;
                    end
                end
            end
            %Report non NO_MORE_DATA_AVAILABLE error.
            if(finished == false)
                throw(e)
            end
        end
    end
    
    
    %Start the stream.
    [ljerror, dblValue] = ljudObj.eGet(ljhandle, LabJack.LabJackUD.IO.START_STREAM, 0, 0, 0);
    
    % Determine the actual scan rate from labjack. This is dependent on how
    % the desired scan rate divides into the LabJack hardware clock.
    ActualScanRate = dblValue;
    disp(['Actual Scan Rate = ' num2str(ActualScanRate)])
    
    %Read data
    %Initialise array to store data
    adblData = NET.createArray('System.Double', numChannels*numScans);  %Max buffer size
    
    %Read the data.
    numScansRequested = numScans;
    [ljerror, numScansRequested] = ljudObj.eGetPtr(ljhandle, LabJack.LabJackUD.IO.GET_STREAM_DATA, LabJack.LabJackUD.CHANNEL.ALL_CHANNELS, numScansRequested, adblData);
    
    %The displays the number of scans that were actually read.
    disp(['Number of total scans = ' num2str(numScansRequested)])
    
    
    
    %Stop the stream
    ljudObj.eGet(ljhandle, LabJack.LabJackUD.IO.STOP_STREAM, 0, 0, 0);
    
    disp('Data Collected')
    
 % If error has occurred, assign it to workspace for inspection.   
catch e
    disp('Error has occurred, please review ''Error'' in workspace') 
    assignin('base','Error',e);
end

% Retreive data from .Net.array and insert it into standard double array
% for output. 
dataInterleaved = adblData.double;

% It is interleaved so need to split into columns
ind = 1:numChannels:numScans*numChannels;
for i = 1:numChannels
    Data(:,i)= dataInterleaved(ind+i-1);
end
