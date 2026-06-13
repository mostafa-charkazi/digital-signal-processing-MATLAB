clc; clear; close all;
 
%% 1.
% 1. A
file_url = "files/Homayoun.mp3";
[y, fs] = audioread(file_url);

[num_samples, num_channels] = size(y);
fprintf("Number of samples : %d\n", num_samples);
fprintf("Number of channels : %d\n", num_channels);

% 1. B
%%
p = audioplayer(y, fs);
play(p);
%%
% 1. C
ymono = sum(y, 2)/2;

[num_samples_ymono, num_channels_ymono] = size(ymono);
fprintf("Number of samples : %d\n", num_samples_ymono);
fprintf("Number of channels : %d\n", num_channels_ymono);

% pmono = audioplayer(ymono, fs);
% play(pmono);

% 1. D
% Seperating from 31s to 41s (we have fs, so this is easy)

sample_min = fs * 31;
sample_max = fs * 41;

y_31_41 = ymono(sample_min: sample_max);

% p_31_41 = audioplayer(y_31_41, fs);
% play(p_31_41);

url_31_41 = "files/new_31_41.wav";
audiowrite(url_31_41, y_31_41, fs);

% 1. E
ynew = y_31_41;
A = 2;
Amplifiedy = A * ynew;

%%
p = audioplayer(Amplifiedy, fs);
play(p);
%%
% 1. F_1
p = audioplayer(ynew, 2*fs);
play(p);
%%
% 1. F_2
p = audioplayer(ynew, fs/2);
play(p);
%% 2. This does not exists in manual file.

%% 3. A
clc; clear; close all;

recObj = audiorecorder;
recDuration = 10;
disp('start speaking.');
recordblocking(recObj, recDuration);
disp('End of recording. Playing back ...');

my_voice = getaudiodata(recObj);
% 3. B
Fs = 8000;
%%
p = audioplayer(my_voice, Fs);
play(p);
%%
% 3. C
my_voice_url = "files/My_DSP_voice.wav";
audiowrite(my_voice_url,my_voice,Fs);

%% 4 Cross over
% 4. a
clc; clear; close all;
audio_url = "files/My_DSP_voice.wav";
[y, fs] = audioread(audio_url);


% 4. b
Xf = fft(y);

% 4. c
XfS = fftshift(Xf);

% 4. d
N = length(Xf);
f0 = fs/N;
f = 0: f0 :(N-1) * f0;
f_shifted = -N/2 * f0: f0 : (N-1)/2 * f0;

figure;
plot(f, abs(Xf)); title("FFT original");
figure;
plot(f_shifted, abs(XfS)); title("FFT shifted");

% 4. e
fc = 3000;
LPFilt = trapmf(f, [-fc, -fc, fc, fc])';

figure; plot(f, LPFilt, 'r', 'LineWidth', 2);

XfSFiltered = XfS .* LPFilt;

% 4. g
LPFilteredSignal = ifft(fftshift(XfSFiltered));
p = audioplayer(real(LPFilteredSignal), fs);
play(p);

% 4. h
HPFilt = 1- LPFilt;
figure; plot(f, HPFilt, 'r', 'LineWidth', 2);

pause(10);
HPFiltered = XfS .* HPFilt;
HPFilteredSignal = ifft(fftshift(HPFiltered));

p = audioplayer(real(HPFilteredSignal), fs);
play(p);

% 4. i
Signalsterio = [HPFilteredSignal, LPFilteredSignal];

pause(10);
p = audioplayer(real(Signalsterio), fs);
play(p);