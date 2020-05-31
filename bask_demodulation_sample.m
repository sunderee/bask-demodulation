clc;
clear all;
close all;

N = 10;
bit_period = 0.0001;
input_signal = randi([0 1], 1, N)

% ------------------------------------------------------------------------------
% Represent input signal as a digital signal (square wave). Plot the signal into
% the first figure.
% ------------------------------------------------------------------------------
input_signal_digital=[];
number_of_bits=100;

for n=1:1:N
  if input_signal(n)==1
    signal_bits=ones(1,number_of_bits);
  else input_signal(n)==0;
    signal_bits=zeros(1,number_of_bits);
  end
  input_signal_digital=[input_signal_digital signal_bits];
end

signal_duration=bit_period/number_of_bits:bit_period/number_of_bits:number_of_bits*N*(bit_period/number_of_bits);

fig=figure(1);
set(fig,'color',[1 1 1]);
subplot(3,1,1);
plot(signal_duration,input_signal_digital);
grid on;
axis([0 bit_period*N -0.5 1.5]);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Input signal represented as a square wave');

% ------------------------------------------------------------------------------
% BASK MODULATION
% Modulate the input signal with the amplitude-shift keying modulation and plot
% the resulting signal into the second figure.
% ------------------------------------------------------------------------------

amplitude_binary_1=15;
amplitude_binary_0=10;
factor=10;
carrier_frequency=factor*(1/number_of_bits);
modulated_signal_time=bit_period/number_of_bits:bit_period/number_of_bits:bit_period;
modulated_signal_length = length(modulated_signal_time);

modulated_signal=[];
for i=1:1:N
  if input_signal(i)==1
    modulated_bit=amplitude_binary_1*cos(2*pi*carrier_frequency*modulated_signal_time);
  else
    modulated_bit=amplitude_binary_0*cos(2*pi*carrier_frequency*modulated_signal_time);
  end
  modulated_signal=[modulated_signal modulated_bit];
end

bask_time=bit_period/number_of_bits:bit_period/number_of_bits:bit_period*N;
subplot(3,1,2);
plot(bask_time,modulated_signal);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('BASK modulated input signal');

% ------------------------------------------------------------------------------
% BASK DEMODULATION
% Demodulated the modulated signal and plot the resulting signal into the final
% third figure.
% ------------------------------------------------------------------------------
fading=1;
noise=0;
received_signal=fading.*modulated_signal+noise;

demodulated_signal=[];
for n=modulated_signal_length:modulated_signal_length:length(received_signal)
  time=bit_period/number_of_bits:bit_period/number_of_bits:bit_period;
  carrier_signal=cos(2*pi*carrier_frequency*time);
  demodulated_bit=carrier_signal.*received_signal((n-(modulated_signal_length-1)):n);
  integration=trapz(time,demodulated_bit);
  amplitude_demodulated=round(2*integration/bit_period);
  if amplitude_demodulated>((amplitude_binary_1 + amplitude_binary_0) / 2)
    demodulated_amplitude=1;
  else
    demodulated_amplitude=0;
  end
  demodulated_signal=[demodulated_signal demodulated_amplitude];
end

demodulated_result=[];
for n=1:len(demodulated_signal);
  if demodulated_signal(n)==1
    demodulated_result_bit=ones(1,number_of_bits);
  else demodulated_signal(n)==0
    demodulated_result_bit=zeros(1,number_of_bits);
  end
  demodulated_result=[demodulated_result demodulated_result_bit];
end

result_time=bit_period/number_of_bits:bit_period/number_of_bits:number_of_bits*len(demodulated_signal)*(bit_period/number_of_bits);
subplot(3,1,3);
plot(result_time,demodulated_result);
grid on;
axis([0 bit_period*length(demodulated_signal) -0.5 1.5]);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('BASK demodulation result');