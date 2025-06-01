clc;
clear all;
close all;
data=load(['dataonemin.mat']);
x1=data.val(1,1:125*20);
x2=data.val(1,2:125*20);
figure;
subplot(4,1,1);
plot(x2);
hold on
title('the mat file');
% preprocessing
x2=x2-mean(x2);  % mean removal
d=max(abs(x2));  
normsig=x2/d;  % amplitude normalization
subplot(4,1,2);
plot(normsig);
title('the normalised');
%-----------digital resonator for RR estimate--------------
 bwidth=0.3; %Hz
 Fs=125;
wo=2*pi*(bwidth)/Fs;
 r=0.997;
a0=1;a1=-2*r*cos(wo);a2=r^2;
a=[a0 a1 a2];
b0=(1-r)*sqrt(1+(r^2)-(2*r*cos(2*wo)));
%the two pole filter with zero at origin
num=[b0 0 0];
den=[a0 a1 a2];
sys=tf(num,den);
% passing the signal through the digital resonator
y=filter(num,den,normsig);
subplot(4,1,3);
plot(y);
title('passed through resonator');
% fft
L=length(y);
N=2^nextpow2(L);
y_fftmag1=abs(fft(y,N));  % two sided magnitude spectrum
y_fftmag=y_fftmag1(1:N/2); % one sided magnitude spectrum
y_fftmag=y_fftmag/max(abs(y_fftmag)); % normalized spectrum
fk=(0:length(y_fftmag)-1).*Fs/N; % convert samples into frequeny
% finding the peak value of the frequency spectrum
%fk=range from 0.1 to .8
%N =no. of samples
%fs sampling frequency 
%fk=k x fs /N 
k1=floor(0.1*N/Fs);
k2=floor(0.8*N/Fs);
[Kmax, Kloc1]=max(y_fftmag(k1:k2));
Kloc=Kloc1+k1-1; % kmax location
disp('the maximum location')
disp(Kloc);
%finding the breath rate
fmax=Kloc*Fs/N;
rr=fmax*60;
disp('the respiratory rate is');
disp(rr);
subplot(4,1,4);
plot( fk, y_fftmag); 
hold on; 
stem(fk(Kloc),y_fftmag(Kloc)); 
ylim([0 1.3]);
xlim([0 2]);
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Magnitude spectrum')


