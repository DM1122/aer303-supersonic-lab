function out = LimitSwitch()
% Basic command/response example using the MATLAB, .NET and the UD driver.
%
% support@labjack.com
%


ljasm = NET.addAssembly('LJUDDotNet'); %Make the UD .NET assembly visible in MATLAB
ljudObj = LabJack.LabJackUD.LJUD;

try
    %Open the first found LabJack U6.
    [ljerror, ljhandle] = ljudObj.OpenLabJack(LabJack.LabJackUD.DEVICE.U6, LabJack.LabJackUD.CONNECTION.USB, '0', true, 0);
    
       
    %Read digital input FIO1.
    ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.GET_DIGITAL_BIT, 1, 0, 0, 0);
    
    ljudObj.GoOne(ljhandle);    
    requestedExit = false;       %Execute the requests.
        
        
        %Get all the results.  The input measurement results are stored.  All other
        %results are for configuration or output requests so we are just checking
        %whether there was an error.
        [ljerror, ioType, channel, dblValue, dummyInt, dummyDbl] = ljudObj.GetFirstResult(ljhandle, 0, 0, 0, 0, 0);
        
        
                    valueDIBit = dblValue;

%         disp(['FIO1 = ' num2str(valueDIBit)])

catch e
    showErrorMessage(e)
end

out = valueDIBit;
