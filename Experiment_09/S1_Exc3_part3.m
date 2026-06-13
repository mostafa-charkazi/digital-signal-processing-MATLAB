clc; clear; close all;
[y_key, Fs1] = audioread('files/new_31_41.wav');
[y_watermarked, Fs2] = audioread('files/watermarked_voice.wav');

y = y_watermarked - y_key;

fs = 8000;
p = audioplayer(y, fs);
play(p);