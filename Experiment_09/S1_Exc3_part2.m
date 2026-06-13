clc; clear; close all;

[y1, Fs1] = audioread('files/new_31_41.wav'); N1 = numel(y1);
[y2, Fs2] = audioread('files/My_DSP_voice.wav'); N2 = length(y2);

sy = y1(1:N2) + y2;
y = y1;
y(1:N2) = sy;

% p = audioplayer(y, Fs2);
% play(p);
audiowrite('files/watermarked_voice.wav', y, Fs1);
audiowrite('files/watermarked_voice_higher_fs.wav', y, Fs1);
audiowrite('files/watermarked_voice_lower_fs.wav', y, Fs2);