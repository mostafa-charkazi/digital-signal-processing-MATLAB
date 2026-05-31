%% A01
clc; clear; close all;

fs = 100;
t = 0 : 1/fs : 3 - 1/fs;
x = sin(2*pi*1*t);

sampling_rates = [0.5, 1, 2, 4];

figure;
stem(t, x, 'filled', 'MarkerSize', 3);
title(sprintf('نرخ نمونه‌برداری = %d', fs));
xlabel('زمان (ثانیه)'); ylabel('دامنه');
grid on;

for i = 1:length(sampling_rates)
    fs_new = sampling_rates(i);
    t_new = 0 : 1/fs_new : 3 - 1/fs_new;
    x_new = sin(2*pi*1*t_new);
    
    figure;
    stem(t_new, x_new, 'filled', 'MarkerSize', 3, 'LineWidth', 3);
    title(sprintf('نرخ نمونه‌برداری = %d', fs_new));
    xlabel('زمان (ثانیه)'); ylabel('دامنه');
    grid on;
end
%% A0
clc; clear; close all;

freqs = [3, 5];
fs_original = 100;
T = 3;
t = 0 : 1/fs_original : T - 1/fs_original;

sampling_rates = [2, 5, 10, 20];
x1 = sin(2*pi*freqs(1)*t);
x2 = sin(2*pi*freqs(2)*t);

figure;
subplot(2,1,1);
stem(t, x1, 'filled', 'MarkerSize', 3);
title(sprintf('f = %d Hz, fs=100', freqs(1)));
xlabel('زمان (ثانیه)'); ylabel('دامنه');
grid on;


subplot(2,1,2);
stem(t, x2, 'filled', 'MarkerSize', 3);
title(sprintf('f = %d Hz, fs=100', freqs(2)));
xlabel('زمان (ثانیه)'); ylabel('دامنه');
grid on;

for f = freqs
    figure('Name', sprintf('%d Hz', f));
    for i = 1:length(sampling_rates)
        fs_new = sampling_rates(i);
        t_new = 0 : 1/fs_new : T - 1/fs_new;
        x_new = sin(2*pi*f*t_new);
        
        subplot(2,2,i);
        stem(t_new, x_new, 'filled', 'MarkerSize', 3);
        title(sprintf('fs = %d Hz', fs_new));
        xlabel('زمان (ثانیه)'); ylabel('دامنه');
        grid on;
        ylim([-1.2, 1.2]);
    end
end
%% A03
clc; clear; close all;

T = 3;
f_signal = 1;
sampling_rates = [1, 2, 5, 10];

for fs = sampling_rates
    t_sample = 0 : 1/fs : T - 1/fs;
    x_sample = sin(2*pi*f_signal*t_sample);
    
    % بازسازی با درون‌یابی خطی
    t_recon = 0 : 1/1000 : T - 1/1000;
    x_recon = interp1(t_sample, x_sample, t_recon, 'linear');
    
    figure;
    plot(t_recon, x_recon, 'b-', 'LineWidth', 1.5); hold on;
    stem(t_sample, x_sample, 'r', 'filled', 'MarkerSize', 4, 'LineWidth', 3);
    title(sprintf('باز سازی سینوسی %d هرتز با نرخ نمونه برداری %d هرتز', f_signal, fs));
    xlabel('زمان (ثانیه)'); ylabel('دامنه');
    legend('سیگنال بازسازی شده', 'نمونه‌ها');
    grid on;
end
%% A04_A
clc; clear; close all;
Fs = 8000;
T = 0.1;
t = 0 : 1/Fs : T - 1/Fs;
x = 5*cos(2*pi*2500*t) + 2*cos(2*pi*4500*t);

N = length(x);
X = fft(x);
f_axis = (0:N-1)*(Fs/N);
figure;
stem(f_axis, abs(X)/N, 'b', 'LineWidth', 1.5);
title('طیف حوزه فرکانس سیگنال');
xlabel('فرکانس (Hz)'); ylabel('دامنه');
grid on;
%% A04_B
clear; close all; clc;

T = 0.1;
Fs_high = 200000;
t_high = 0:1/Fs_high:T-1/Fs_high;
x_cont = 5*cos(2*pi*2500*t_high) + 2*cos(2*pi*4500*t_high);

figure;
t = 0 : 1/8000 : T - 1/8000;
x = 5*cos(2*pi*2500*t) + 2*cos(2*pi*4500*t);
plot(t, x, 'LineWidth',2);
title('نرخ نمونه برداری ۸۰۰۰')
figure;
x = 5*cos(2*pi*2500*t) + 2*cos(2*pi*4500*t);
plot(t_high, x_cont, 'LineWidth',2);
title('نرخ نمونه برداری بسیار بالا')

order = 2;
cutoff = 4000; 
Wn = cutoff / (Fs_high/2);
[b, a] = butter(order, Wn, 'low');
x_filtered_high = filter(b, a, x_cont);

N = length(x_cont);
X = fft(x_cont);
f_axis = (0:N-1)*(Fs_high/N);

figure;
stem(f_axis, abs(X)/N, 'b', 'LineWidth', 1.5);
title('طیف حوزه فرکانس سیگنال سیگنال با فرکانس بسیار بالا (سیگنال پیوسته)');
xlabel('فرکانس (Hz)'); ylabel('دامنه');
grid on;

N = length(x_filtered_high);
X = fft(x_filtered_high);
f_axis = (0:N-1)*(Fs_high/N);
figure;
stem(f_axis, abs(X)/N, 'b', 'LineWidth', 1.5);
title('طیف حوزه فرکانس سیگنال فیلتر شده');
xlabel('فرکانس (Hz)'); ylabel('دامنه');
grid on;

% انتخاب هر ۲۵ نمونه - برای داون سمپل
Fs_sample = 8000;
decim_factor = Fs_high / Fs_sample;
indices = 1:decim_factor:length(x_filtered_high);
x_sampled = x_filtered_high(indices);
t_sampled = t_high(indices);

t_recon = t_high;
x_recon = interp1(t_sampled, x_sampled, t_recon, 'spline');

% ---------- رسم سیگنال بازسازی شده در حوزه زمان ----------
figure('Name', 'بازسازی سیگنال آنالوگ');
plot(t_high, x_cont, 'b', 'LineWidth', 1); hold on;
plot(t_recon, x_recon, 'r--', 'LineWidth', 1.5);
legend('سیگنال اصلی پیوسته', 'سیگنال بازسازی شده (پس از فیلتر و نمونه‌برداری)');
title('مقایسه سیگنال اصلی و بازسازی شده با فیلتر آنتی الیاسینگ');
xlabel('زمان (s)'); ylabel('دامنه'); grid on;
xlim([0 0.01]);

%% A05
clc; clear; close all;
% Upsampling

%% Activity 5
clc; clear; close all;

fs = 100; 
T = 1;
t = 0 : 1/fs : T - 1/fs;
x = sin(2*pi*10*t);   % 10 Hz

L_vals = [2, 3, 5];
for L = L_vals
    x_up = zeros(1, L*length(x));
    x_up(1:L:end) = x;
    fs_up = L * fs;
    t_up = 0 : 1/fs_up : T - 1/fs_up;

    N = length(x);
    N_up = length(x_up);
    X = fft(x);
    X_up = fft(x_up);
    
    f_axis = (0:N-1)*(fs/N);
    f_axis_up = (0:N_up-1)*(fs*L/N_up);
    
    figure;
    subplot(2,1,1);
    stem(t, x, 'filled', 'MarkerSize', 3);
    title(sprintf('سیگنال اصلی (fs=%d Hz)', fs));
    xlabel('t'); ylabel('x');
    grid on;

    subplot(2,1,2);
    stem(t_up, x_up, 'filled', 'MarkerSize', 3);
    title(sprintf('سیگنال اصلی آپ سمپل شده (L=%d)', L));
    xlabel('t'); ylabel('x');
    grid on;

    figure
    subplot(2,1,1);
    stem(f_axis, abs(X)/N, 'filled', 'MarkerSize', 3);
    title(sprintf('طیف سیگنال اصلی (fs=%d Hz)', fs));
    xlabel('فرکانس (Hz)'); ylabel('دامنه');
    grid on;
    xlim([0, fs]);
    
    subplot(2,1,2);
    stem(f_axis_up, abs(X_up)/N_up, 'b');
    title(sprintf('طیف سیگنال upsampled با L=%d', L));
    xlabel('فرکانس (Hz)'); ylabel('دامنه');
    grid on;
    xlim([0, L*fs]);
end
%% A06
clc; clear; close all;

fs = 100; 
T = 1;
t = 0 : 1/fs : T - 1/fs;
x = sin(2*pi*10*t);   % 10 Hz

M_vals = [2, 3, 5];
for M = M_vals
    x_down = x(1:M:end);
    t_down = t(1:M:end);
    fs_down = fs / M;

    % محاسبه طیف
    N = length(x);
    N_down = length(x_down);
    X = fft(x);
    X_down = fft(x_down);
    
    f_axis = (0:N-1)*(fs/N);
    f_axis_down = (0:N_down-1)*(fs_down/N_down);
    

    figure;
    subplot(2,1,1);
    stem(t, x, 'filled', 'MarkerSize', 3);
    title(sprintf('سیگنال اصلی (fs=%d Hz)', fs));
    xlabel('t'); ylabel('x');
    grid on;

    subplot(2,1,2);
    stem(t_down, x_down, 'filled', 'MarkerSize', 3);
    title(sprintf('سیگنال داون سمپل شده (M=%d) (fs=%f)', M, fs_down));
    xlabel('t'); ylabel('x');
    grid on;

    figure;
    subplot(2,1,1);
    stem(f_axis, abs(X)/N, 'b');
    title(sprintf('طیف سیگنال اصلی (fs=%d Hz)', fs));
    xlabel('فرکانس (Hz)'); ylabel('دامنه');
    grid on;
    xlim([0, fs/2]);
    
    subplot(2,1,2);
    stem(f_axis_down, abs(X_down)/N_down, 'r');
    title(sprintf('طیف سیگنال داون سمپل شده (M=%d) (fs=%f)', M, fs_down));
    xlabel('فرکانس (Hz)'); ylabel('دامنه');
    grid on;
    xlim([0, fs_down/2]);
end