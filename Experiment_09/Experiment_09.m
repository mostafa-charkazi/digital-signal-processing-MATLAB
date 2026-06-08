clc; clear; close all;
 
%% 1. A
file_url = "files/Homayoun.mp3";
[y, fs] = audioread(file_url);

[num_samples, num_channels] = size(y);
fprintf("Number of samples : %d\n", num_samples);
fprintf("Number of channels : %d\n", num_channels);

%% 1. B
p = audioplayer(y, fs);
play(p);

%% 1. C
ymono = sum(y, 2)/2;

[num_samples_ymono, num_channels_ymono] = size(ymono);
fprintf("Number of samples : %d\n", num_samples_ymono);
fprintf("Number of channels : %d\n", num_channels_ymono);

% pmono = audioplayer(ymono, fs);
% play(pmono);

%% 1. D
% Seperating from 31s to 41s (we have fs, so this is easy)

sample_min = fs * 31;
sample_max = fs * 41;

y_31_41 = ymono(sample_min: sample_max);

% p_31_41 = audioplayer(y_31_41, fs);
% play(p_31_41);

url_31_41 = "files/new_31_41.wav";
audiowrite(url_31_41, y_31_41, fs);

%% 1. E

ynew = y_31_41;
A = 2;
Amplifiedy = A * ynew;

p = audioplayer(Amplifiedy, fs);
play(p);

%% 1. F_1
p = audioplayer(ynew, 2*fs);
play(p);

%% 1. F_2
p = audioplayer(ynew, fs/2);
play(p);

%% 2. This does not exists in manual file.

%% 3. 