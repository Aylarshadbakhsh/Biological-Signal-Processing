close all
clc
clear
%% loading data
fs=200;
load ('ECG3.dat');
load ('ECG4.dat');
load ('ECG5.dat');
load ('ECG6.dat');
%% Pan-Tompkins algorithm
[ecg1, ecg_h1] =pantom(ECG3,fs);
[ecg2, ecg_h2] =pantom(ECG4,fs);
[ecg3, ecg_h3]=pantom(ECG5,fs);
[ecg4, ecg_h4] =pantom(ECG6,fs);
N = length (ecg1);
t1 = 0:1/fs:N/fs-1/fs;
ECG1={ecg1.';ecg_h1.';ECG3.';ecg2.';ecg_h2.';ECG4.';ecg3.';ecg_h3.';ECG5.';ecg4.';ecg_h4.';ECG6.'};
%%
for j=1:3:12
    ecg=ECG1(j,:);
    ecg=cell2mat(ecg);
    ecgh=ECG1(j+1,:);
    ecgh=cell2mat(ecgh);
    ECG=ECG1(j+2,:);
    ECG=cell2mat(ECG);
    ecg=ecg.';
    ecgh=ecgh.';
    ECG=ECG.';
    figure()
    subplot(3,1,1)
    plot(ecg)
    title("QRS complex of ECG"+j)
    xlabel('time')
    ylabel('amplitude')
    subplot(3,1,2)
    plot(ecgh)
    title("filtered ECG"+j)
    xlabel('time')
    ylabel('amplitude')
    subplot(3,1,3)
    plot(ECG)
    title(" RAW  ECG"+j)
    xlabel('time')
    ylabel('amplitude')
end
 %% R-R interval and QRS width ECG3
[pks,locs] = findpeaks(ecg1,'MINPEAKDISTANCE',round(0.5*fs)); %peak r
figure()
plot(t1,ecg1,t1(locs),pks,'or')
title('R PEAKS ECG1 ')
interval=(diff(locs))/200;%second
meanr=mean(interval);
HRV1=60/meanr;
dev1=interval-meanr;
fprintf('\nHRV of ECG1=%d',HRV1)
fprintf('\nR interval mean ECG1 (second)=%f',meanr)
%fprintf('deviation=%f',dev1)
 %% R-R interval and QRS width ECG3
[pks,locs] = findpeaks(ecg2,'MINPEAKDISTANCE',round(0.5*fs)); %peak r
figure()
plot(t1,ecg2,t1(locs),pks,'or')
title('R PEAKS ECG2 ')
interval=(diff(locs))/200;%second
meanr=mean(interval);
HRV1=60/meanr;
dev1=interval-meanr;
fprintf('\nHRV of ECG2=%d',HRV1)
fprintf('\nR interval mean ECG2 (second)=%f',meanr)
%fprintf('deviation=%f',dev1)
 %% R-R interval and QRS width ECG3
[pks,locs] = findpeaks(ecg3,'MINPEAKDISTANCE',round(0.3*fs)); %peak r
figure()
plot(t1,ecg3,t1(locs),pks,'or')
title('R PEAKS ECG3 ')
interval=(diff(locs))/200;%second
meanr=mean(interval);
HRV1=60/meanr;
dev1=interval-meanr;
fprintf('\nHRV of ECG3=%d',HRV1)
fprintf('\nR interval mean ECG3 (second)=%f',meanr)
%fprintf('deviation=%f',dev1)
 %% R-R interval and QRS width ECG3
[pks,locs] = findpeaks(ecg4,'MINPEAKDISTANCE',round(0.7*fs)); %peak r
figure()
plot(t1,ecg4,t1(locs),pks,'or')
title('R PEAKS ECG4 ')
interval=(diff(locs))/200;%seconds
meanr=mean(interval);
HRV1=60/meanr;
dev1=interval-meanr;
fprintf('\nHRV of ECG4=%d',HRV1)
fprintf('\nR interval mean ECG4 (second)=%f',meanr)
%fprintf('deviation=%f',dev1)
%% function
function [ecg_in,ecg_hp] = pantom(ecg, fs)
    ecg = ecg - mean(ecg);
    % Pan-Tompkins algorithm
    %filtering
    f1=5;                                                                  
    f2=15;                                                                     
    Wn=[f1 f2]*2/fs;                                                          
    N = 3;                                                                     
   [a,b] = butter(N,Wn);                                                      
   ecg_h = filtfilt(a,b,ecg);
   ecg_hp= ecg_h/ max( abs(ecg_h));
    %Derivative filter
    B_df_1 = [1 2 0 -2 -1]*fs/8;
    A_df_1 = 1;
    ecg_df = filter(B_df_1,A_df_1,ecg_hp);
    ecg_df  = ecg_df/max(ecg_df);
    %Squaring
    ecg_sq = ecg_df .^2;
    % moving average
    ecg_in = conv(ecg_sq ,ones(1 ,round(0.150*fs))/round(0.150*fs));

end