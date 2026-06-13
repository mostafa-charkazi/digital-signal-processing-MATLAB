clc; clear; close all;

file_url = "files/EEG_data.mat";
eeg_data = load(file_url);

eeg_A = eeg_data.A;
eeg_B = eeg_data.B;
eeg_C = eeg_data.C;
eeg_D = eeg_data.D;
eeg_E = eeg_data.E;