clc
clear
close all
%% importing data
fs=100;
eeg1=importdata('eeg1-c3.dat');
eeg2=importdata('eeg1-c4.dat');
eeg3=importdata('eeg1-f3.dat');
eeg4=importdata('eeg1-f4.dat');
eeg5=importdata('eeg1-o1.dat');
eeg6=importdata('eeg1-o2.dat');
eeg7=importdata('eeg1-p3.dat');
eeg8=importdata('eeg1-p4.dat');
eegf1=[eeg1.';eeg2.';eeg3.';eeg4.';eeg5.';eeg6.';eeg7.';eeg8.'];
%% eeg1 after bandpass filter 
y = bandpass(eeg1,[8 13],fs);
t=1:length(eeg1);
figure()
plot(y)
title(' eeg1 signal after band-pass filter')
y2=y(450:500); % choose this segment to find correlation
%% correlation coefficent
b=[];
for j=1:7
 eeg=eegf1(j,:);
 eeg=eeg.';
 for i= 1:length(eeg1)-50
    if corrcoef(y2,eeg(i:i+50))>0.65
        b(end+1) = i;
        b(end+1) = i+50; 
    
    
    end
 end
  %% plotting results
 figure()
 colors1 = {'b','g','r','k','c','m'};
 getFirst = @(v)v{1}; 
 getprop = @(options, idx)getFirst(circshift(options,-idx+1));
 for i=1:2:length(b)
   plot(t,eeg,'k-s','MarkerEdgeColor',getprop(colors1,i),'MarkerIndices', [b(i) b(i+1)],'MarkerSize',10);hold on
   title("alpha rhythm detection in eeg"+ j+ " with crosscorrelation")
 end
 b=[];
end


