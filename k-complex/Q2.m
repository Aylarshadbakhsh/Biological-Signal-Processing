clc
clear
close all
%%  importing data
Fs=100;
eeg1=importdata('eeg2-c3.dat');
eeg2=importdata('eeg2-c4.dat');
eeg3=importdata('eeg2-f3.dat');
eeg4=importdata('eeg2-f4.dat');
eeg5=importdata('eeg2-o1.dat');
eeg6=importdata('eeg2-o2.dat');
eeg7=importdata('eeg2-p3.dat');
eeg8=importdata('eeg2-p4.dat');
eeg9=importdata('eeg2-t3.dat');
eeg10=importdata('eeg2-t4.dat');
eegf1=[eeg1.';eeg2.';eeg3.';eeg4.';eeg5.';eeg6.';eeg7.';eeg8.';eeg9.';eeg10.'];
%%
t=1:length(eeg1);
y2=eeg1(44:92);
figure()
plot(y2)
title('k-complex')
%% correlation coefficent
b=[];
for j=1:10
 eeg=eegf1(j,:);
 eeg=eeg.';
 for i= 1:9:length(eeg1)-48
   if corrcoef(y2,eeg(i:i+48))>0.5
        b(end+1) = i;
        b(end+1) = i+48; 
    
    
    end
 end
  %% plotting results
 figure()
 colors1 = {'b','g','r','k','c','m'};
 getFirst = @(v)v{1}; 
 getprop = @(options, idx)getFirst(circshift(options,-idx+1));
 for i=1:2:length(b)
   plot(t,eeg,'k-s','MarkerEdgeColor',getprop(colors1,i),'MarkerIndices', [b(i) b(i+1)],'MarkerSize',10);hold on
    title("k-complex detection in eeg"+ j+ " with crosscorrelation")
 end
 b=[];
end
