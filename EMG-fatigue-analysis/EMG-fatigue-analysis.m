close all
clc
clear
%% load data
fs=2000;
load("EMG1.mat");
load("EMG2.mat");
load("EMG3.mat");
load("EMG4.mat");
N = length (data1);
t1 = 0:1/fs:N/fs-1/fs;
N2=length(data2);
t2=0:1/fs:N2/fs-1/fs;
N3=length(data3);
t3=0:1/fs:N3/fs-1/fs;
N4=length(data4);
t4=0:1/fs:N4/fs-1/fs;
%% rms
WinLen = 200;  %fs=2000hz, time window =100ms -> N=2000*0.1S=200                                         % Window Length For RMS Calculation
rmsv1 = sqrt(movmean(data1.^2, 200)); 
rmsv2 = sqrt(movmean(data2.^2, 200));
rmsv3 = sqrt(movmean(data3.^2, 200));
%% rectification
rectified1=abs(data1);
rectified2=abs(data2);
rectified3=abs(data3);
%% plottings
figure()
subplot(3,3,1)
plot(t1,data1)
title('EMG1')
subplot(3,3,2)
plot(t2,data2)
title('EMG2')
subplot(3,3,3)
plot(t3,data3)
title('EMG3')
subplot(3,3,4)
plot(t1,rectified1)
title('rectified EMG1')
subplot(3,3,5)
plot(t2,rectified2)
title('rectified EMG2')
subplot(3,3,6)
plot(t3,rectified3)
title('rectified EMG3')
subplot(3,3,7)
plot(t1,rmsv1)
title('RMS1')
subplot(3,3,8)
plot(t2,rmsv2)
title('RMS2')
subplot(3,3,9)
plot(t3,rmsv3)
title('RMS3')
%%  MVC ( cumulative integral of EMG1,EMG2,EMG3 )
VT1 = cumtrapz(t1, abs(data1)); 
VT2 = cumtrapz(t2, abs(data2));
VT3 = cumtrapz(t3, abs(data3));
figure()
plot(t1,VT1)
title('MVC1')
figure()
plot(t2,VT2)
title('MVC2')
figure()
plot(t3,VT3)
title('MVC3')
%% analysing fatigue for EMG4 with RMS,median frequency and zero crossing rate
%0.5s Window with 5s time interval
for i=1:10151:length(data4) 
    data44(i:i+1015)=data4(i:i+1015);
    rmsv42(i:i+1015) = sqrt(movmean(data44(i:i+1015).^2, 1000));
    figure()
    plot(t4(i:i+1015),rmsv42(i:i+1015));
    title('RMS')
    figure()
    [Pxx,Freq] = periodogram(data44(i:i+1015),rectwin(length(data44(i:i+1015))),length(data44(i:i+1015)),fs);
    BCMPF=medfreq(Pxx,Freq);
    fprintf('\n median frequey =%d',BCMPF)
    plot(Freq,Pxx)
    hold on
    plot([BCMPF BCMPF], ylim, '-r', 'LineWidth',1) 
    xlabel('frequency')
    ylabel('amplitude')
    title('median frequency')
    s=data44(i:i+1015);
    t1=t4(i:i+1015);
    w = 1;
    %zero crossings
   crossPts=[];
   for k=1:(length(s)-1)
     if (s(k)*s(k+1)<0)
        crossPts(w) = (t1(k)+t1(k+1))/2;
        w = w + 1;
     end
   end
   figure
   set(gcf,'color','w')
  plot(t1,s)
  hold on
  plot(t1, s)
  plot(crossPts, zeros(length(crossPts)), 'o')
  title('zero crossing rate')
end





