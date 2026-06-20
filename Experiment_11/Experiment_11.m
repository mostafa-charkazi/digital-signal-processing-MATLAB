clc; clear; close all;

data = [1 0 0 1 0 1 1 0];
Fs = 1000;
A = 1;

%% 1
fc_ask = 20;
fp_ask = 4;

[t_ask, ask_signal, ask_baseband] = ASK_Mod(data, fc_ask, fp_ask, Fs, A);

figure;
subplot(3,1,1);
plot(t_ask, ask_baseband, 'LineWidth', 1.5);
grid on;
ylim([-0.2 1.2]);
title('داده دیجیتال ورودی برای ASK');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t_ask, cos(2*pi*fc_ask*t_ask), 'LineWidth', 1);
grid on;
title('سیگنال حامل ASK');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t_ask, ask_signal, 'LineWidth', 1.2);
grid on;
title('سیگنال مدوله شده ASK برای داده 10010110');
xlabel('Time (s)');
ylabel('Amplitude');

%% 2
fc_list = [8 12 20 40 80];
figure;
for k = 1:length(fc_list)
    fc = fc_list(k);
    [t_temp, ask_temp, ~] = ASK_Mod(data, fc, fp_ask, Fs, A);

    subplot(length(fc_list),1,k);
    plot(t_temp, ask_temp, 'LineWidth', 1);
    grid on;
    title(['ASK Modulation with fc = ', num2str(fc), ' Hz']);
    xlabel('Time (s)');
    ylabel('Amplitude');
end

%% 3

detected_ask = ASK_Demod(ask_signal, fc_ask, fp_ask, Fs);

disp('ASK Demodulated data:');
disp(detected_ask);

%% 4
fc_bpsk = 20;
fp_bpsk = 4;

[t_bpsk, bpsk_signal, bpsk_baseband] = BPSK_Mod(data, fc_bpsk, fp_bpsk, Fs, A);

figure;
subplot(3,1,1);
plot(t_bpsk, bpsk_baseband, 'LineWidth', 1.5);
grid on;
ylim([-1.2 1.2]);
title('داده دودویی نگاشت شده برای BPSK');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t_bpsk, cos(2*pi*fc_bpsk*t_bpsk), 'LineWidth', 1);
grid on;
title('سیگنال حامل BPSK');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t_bpsk, bpsk_signal, 'LineWidth', 1.2);
grid on;
title('سیگنال مدوله شده BPSK برای داده 10010110');
xlabel('Time (s)');
ylabel('Amplitude');


%% 5

detected_bpsk = BPSK_Demod(bpsk_signal, fc_bpsk, fp_bpsk, Fs);

disp('BPSK Demodulated data:');
disp(detected_bpsk);


%% 6

f0 = 10;            % فرکانس برای بیت صفر
f1 = 20;            % فرکانس برای بیت یک
fp_fsk = 5;

[t_fsk, bfsk_signal, bfsk_baseband] = BFSK_Mod(data, f0, f1, fp_fsk, Fs, A);

figure;
subplot(2,1,1);
plot(t_fsk, bfsk_baseband, 'LineWidth', 1.5);
grid on;
ylim([-0.2 1.2]);
title('داده دیجیتال ورودی برای BFSK');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t_fsk, bfsk_signal, 'LineWidth', 1.2);
grid on;
title('سیگنال مدوله شده BFSK برای داده 10010110');
xlabel('Time (s)');
ylabel('Amplitude');


%% 7

detected_bfsk = BFSK_Demod(bfsk_signal, f0, f1, fp_fsk, Fs);

disp('BFSK Demodulated data:');
disp(detected_bfsk);


%% 8
ask_noisy  = ask_signal  + 0.5 * randn(size(ask_noisy));
bpsk_noisy = bpsk_signal + 0.5 * randn(size(bpsk_noisy));
bfsk_noisy = bfsk_signal + 0.5 * randn(size(bfsk_noisy));

detected_ask_noisy  = ASK_Demod(ask_noisy, fc_ask, fp_ask, Fs);
detected_bpsk_noisy = BPSK_Demod(bpsk_noisy, fc_bpsk, fp_bpsk, Fs);
detected_bfsk_noisy = BFSK_Demod(bfsk_noisy, f0, f1, fp_fsk, Fs);

disp('Detected data with Noise:');

disp('ASK:');
disp(detected_ask_noisy);

disp('BPSK:');
disp(detected_bpsk_noisy);

disp('BFSK:');
disp(detected_bfsk_noisy);

figure;
subplot(3,1,1);
plot(t_ask, ask_noisy, 'LineWidth', 1);
grid on;
title('ASK Signal with Noise');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t_bpsk, bpsk_noisy, 'LineWidth', 1);
grid on;
title('BPSK Signal with Noise');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t_fsk, bfsk_noisy, 'LineWidth', 1);
grid on;
title('BFSK Signal with Noise');
xlabel('Time (s)');
ylabel('Amplitude');