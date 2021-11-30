% Calculate Autocorrelation and Time Constant

channel = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% select a subset of data
    disp(['Channel ',num2str(channel)])
data = dataP (:,channel);
e_std = std(data);


%%%%% Calculate the autocorrelation
lag = [0:length(data)/2];%, 15:5:100, 110:10:200];
acf = [];
data2= data - mean(data);

for i = 1:length(lag)
    dum = data2(1:end-lag(i)).*data2(lag(i)+1:end);
    acf(i) = mean(dum);
end
acf = acf/e_std^2;

% semilogx(lag,acf)
% plot(lag,acf)Pxx

%%%% Calculate the time constant of the signal
time = lag / ActualScanRate;

I = find(acf<0);

T_e = trapz(time(1:I(1)),acf(1:I(1)));
disp(['Time Constant = ', num2str(T_e,'%2.4f'), ' s'])


CofV = (e_std / mean(data))  * 100;
disp(['Coefficient of Variation = ', num2str(CofV,'%2.3f'), ' %'])


% %%%% Calculate the spectra
Bin = 7;
bin_size = 2^Bin;
Buff_size = bin_size * 2;
if Time_samp * Freq_samp > Buff_size
    [Pxx, F] = pwelch(data2,Buff_size, Buff_size/2, Buff_size, ActualScanRate);
    
    figure;
    loglog(F,Pxx);
    title(['Channel ',num2str(channel)])
   
end


