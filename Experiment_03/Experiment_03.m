%% A01
clear; close all; clc;

% ضرایب تابع تبدیل
num = [2 1];
den = [1 -0.6];

% محاسبه پاسخ فرکانسی با freqz
[H, w] = freqz(num, den, 1024);

% رسم دامنه و فاز
figure;
subplot(2,1,1);
plot(w, abs(H));
title('دامنه پاسخ فرکانسی');
xlabel('فرکانس نرمال‌شده (rad/sample)');
ylabel('|H(e^{j\omega})|');
grid on;

subplot(2,1,2);
plot(w, angle(H));
title('فاز پاسخ فرکانسی');
xlabel('فرکانس نرمال‌شده (rad/sample)');
ylabel('فاز (rad)');
grid on;
%% A02
clear; close all; clc;
R = [1 4 7 10 13 16 19 22 25 28];

% محاسبه DTFT (تخمینی) با freqz
[H, w] = freqz(R, 1, 1024);

figure;
subplot(2,1,1);
plot(w, abs(H));
title('دامنه DTFT سیگنال R[n]');
xlabel('\omega (rad/sample)');
ylabel('|X(e^{j\omega})|');
grid on;

subplot(2,1,2);
plot(w, rad2deg(angle(H))); % فاز بر حسب درجه
title('فاز DTFT سیگنال R[n]');
xlabel('\omega (rad/sample)');
ylabel('Phase (degrees)');
grid on;
%% A03
clear; close all; clc;
R = [1 4 7 10 13 16 19 22 25 28];
R_shift = [zeros(1,3) R]; % شیفت به اندازه 3 نمونه

[H_org, w] = freqz(R, 1, 1024);
[H_shift, w_shift] = freqz(R_shift, 1, 1024);

figure;
subplot(2,2,1);
plot(w, abs(H_org), 'b', 'LineWidth', 2);
title('اندازه سیگنال اصلی');
grid on;

subplot(2,2,2);
plot(w_shift, abs(H_shift), 'r', 'LineWidth', 2);
title('اندازه سیگنال شیفت یافته');
grid on;

subplot(2,2,3);
plot(w_shift, angle(H_org), 'b', 'LineWidth', 2);
title('زاویه سیگنال اصلی');
grid on;

subplot(2,2,4);
plot(w_shift, angle(H_shift), 'r', 'LineWidth', 2);
title('زاویه سیگنال شیفت یافته');
grid on;

%% A04
clear; close all; clc;
shift_vals = [5 10];
Rs = [[10 2 7 3 15 1 9 2 5 8];
      [1 2 1 2 3 6 9 6 5 9]];
i=1;
for k = 1:4
    R = Rs(i,:);
    R_shift = [zeros(1, shift_vals(i)) R]; % شیفت به اندازه 3 نمونه
    
    [H_org, w] = freqz(R, 1, 1024);
    [H_shift, w_shift] = freqz(R_shift, 1, 1024);
    
    figure;
    subplot(2,2,1);
    plot(w, abs(H_org), 'b', 'LineWidth', 2);
    title('اندازه سیگنال اصلی');
    grid on;
    
    subplot(2,2,2);
    plot(w_shift, abs(H_shift), 'r', 'LineWidth', 2);
    title('اندازه سیگنال شیفت یافته');
    grid on;
    
    subplot(2,2,3);
    plot(w_shift, angle(H_org), 'b', 'LineWidth', 2);
    title('زاویه سیگنال اصلی');
    grid on;
    
    subplot(2,2,4);
    plot(w_shift, angle(H_shift), 'r', 'LineWidth', 2);
    title('زاویه سیگنال شیفت یافته');
    grid on;
    
    if k == 2
        i = i+1;
    end
end

%% A05
clear; close all; clc;

n = 0:99;
x = sin(0.2*pi*n) + 0.5*cos(0.5*pi*n);

omega0_vals = [0, pi/8, pi/4, pi/2];
colors = {'b', 'r', 'g', 'm'};

figure;
for i = 1:length(omega0_vals)
    subplot(length(omega0_vals), 1, i);
    omega0 = omega0_vals(i);
    x_shifted = x .* exp(1j*omega0*n);
    [H, w] = freqz(x_shifted, 1, 1024);
    plot(w, abs(H), colors{i}, 'LineWidth', 1.5);
    title('تاثیر شیفت فرکانسی بر دامنه');
    legend(['\omega = \pi/' num2str(1/ (omega0_vals(i)/pi))])
    xlabel('\omega (rad/sample)');
    ylabel('|X(e^{j\omega})|');
    grid on;
end

figure;
for i = 1:length(omega0_vals)
    subplot(length(omega0_vals), 1, i);
    omega0 = omega0_vals(i);
    x_shifted = x .* exp(1j*omega0*n);
    [H, w] = freqz(x_shifted, 1, 1024);
    plot(w, angle(H), colors{i}, 'LineWidth', 1.5);
    title('تاثیر شیفت فرکانسی بر فاز');
    legend(['\omega = \pi/' num2str(1/ (omega0_vals(i)/pi))])
    xlabel('\omega (rad/sample)');
    ylabel('angle X(e^{j\omega})');
    grid on;
end

%% A06_1
clear; close all; clc;
x = [1 2 3];
y = [1 1 1];

conv_time = conv(x, y);

X = fft(x, 5);
Y = fft(y, 5);
conv_freq = ifft(X .* Y);

disp('کانولوشن در زمان:'); disp(conv_time);
disp('حاصل ضرب در فرکانس و تبدیل معکوس:'); disp(conv_freq);

%% A06_2
clear; close all; clc;
x = [3 2 3 5 7];
y = [1 5 6 1 2];

conv_time = conv(x, y);

X = fft(x, 9);
Y = fft(y, 9);
conv_freq = ifft(X .* Y);

disp('کانولوشن در زمان:'); disp(conv_time);
disp('حاصل ضرب در فرکانس و تبدیل معکوس:'); disp(conv_freq);
%% A07
clear; close all; clc;

x1 = [1 2 3 4];
x2 = [3 2 1 0];

% ضرب در حوزه زمان
prod_time = x1 .* x2;

% محاسبه کانولوشن چرخشی در حوزه فرکانس
N = length(x1);
X1 = fft(x1, N);
X2 = fft(x2, N);
conv_freq_circ = cconv(X1, X2, N) / N;
prod_freq = ifft(conv_freq_circ);

% نمایش نتایج
disp('ضرب در حوزه زمان:');
disp(prod_time);
disp('حاصل از کانولوشن در فرکانس: ');
disp(prod_freq);
%% A07_2
clear; close all; clc;

Fs = 1000;
t = 0:1/Fs:1-1/Fs;
f1 = 50;
f2 = 120;
x_sin1 = cos(2*pi*f1*t);
x_sin2 = cos(2*pi*f2*t);

% ضرب در زمان
prod_sin_time = x_sin1 .* x_sin2;

% کانولوشن در فرکانس
Nfft = length(t);
X_sin1 = fft(x_sin1, Nfft);
X_sin2 = fft(x_sin2, Nfft);
conv_sin_freq = cconv(X_sin1, X_sin2, Nfft) / Nfft;
prod_sin_freq = ifft(conv_sin_freq);

figure;
subplot(2,1,1);
plot(t(1:200), prod_sin_time(1:200));
title('ضرب دو سینوسی در حوزه زمان');
xlabel('زمان (ثانیه)');
ylabel('دامنه');
grid on;

subplot(2,1,2);
plot(t(1:200), real(prod_sin_freq(1:200)));
title('بازسازی از کانولوشن در فرکانس');
xlabel('زمان (ثانیه)');
ylabel('دامنه');
grid on;
%% A08
clc; clear; close all;
x = [1 2 3 4 5 6 7 8 9 10];
x_rev = fliplr(x);

X = fft(x);
X_rev = fft(x_rev);

figure;
subplot(2,2,1); stem(abs(X)); title('abs FFT x[n]');
subplot(2,2,2); stem(abs(X_rev)); title('abs FFT x[-n]');
subplot(2,2,3); stem(angle(X)); title('angle FFT x[n]');
subplot(2,2,4); stem(angle(X_rev)); title('angle FFT x[-n]');

x = [5 6 3 2 4 1 3 2 6 5];
x_rev = fliplr(x);

X = fft(x);
X_rev = fft(x_rev);

figure;
subplot(2,2,1); stem(abs(X)); title('abs FFT x[n]');
subplot(2,2,2); stem(abs(X_rev)); title('abs FFT x[-n]');
subplot(2,2,3); stem(angle(X)); title('angle FFT x[n]');
subplot(2,2,4); stem(angle(X_rev)); title('angle FFT x[-n]');

%% A09
clear; close all; clc;

N = 20;
n = 0:N-1;

x = sin(0.3*pi*n) + 0.7*sin(0.8*pi*n) + 0.3*cos(0.15*pi*n);

L_vals = [20, 50, 200, 1000];

for i = 1:length(L_vals)
    L = L_vals(i);
    X = fft(x, L);
    x_recon = ifft(X, L);
    x_recon = real(x_recon(1:N));
    
    % رسم
    figure;
    subplot(2, 1, 1);
    k = 0:L-1;
    wk = k * (2*pi/L);  % فرکانس‌های نرمال‌شده
    stem(wk, abs(X), 'b', 'Marker', 'none', 'LineWidth', 0.5);
    title(sprintf('FFT (L = %d)', L));
    xlabel('\omega (rad/sample)');
    ylabel('|X[k]|');
    xlim([0, pi]);
    grid on;
    subplot(2, 1, 2);
    stem(x_recon, 'b', 'Marker', 'none', 'LineWidth', 0.5);
    title(sprintf('iFFT (L = %d)', L));
    grid on;
end
%% A10 
clc; clear; close all;
x_test = [1 2 3 4 5];
N_test = length(x_test);
m_test = 2;

y_test = circshift1(x_test, m_test);
disp('سیگنال اصلی x:'); disp(x_test);
disp('سیگنال شیفت یافته y:'); disp(y_test);
%%
clc; clear; close all;
x_test = [1 2 3 4 5];
N_test = length(x_test);
m_test = 2;

y_test = circshift1(x_test, m_test);

X_fft = fft(x_test);
Y_fft = fft(y_test);

subplot(3,2,1);
stem(x_test, 'filled', 'LineWidth', 1.5);
title('x[n]');
grid on;

subplot(3,2,2);
stem(y_test, 'filled', 'LineWidth', 1.5);
title('y[n]');
grid on;

subplot(3,2,3);
stem(abs(X_fft), 'filled', 'LineWidth', 1.5);
title('abs fft x[n]');
grid on;

subplot(3,2,4);
stem(abs(Y_fft), 'filled', 'LineWidth', 1.5);
title('abs fft y[n]');
grid on;

subplot(3,2,5);
stem(angle(X_fft), 'filled', 'LineWidth', 1.5);
title('angle fft x[n]');
grid on;

subplot(3,2,6);
stem(angle(Y_fft), 'filled', 'LineWidth', 1.5);
title('angle fft y[n]');
grid on;

%% A11
clc; clear; close all;

x1 = [1 2 3];
h1 = [1 1 1];
y1 = circconv1(x1, h1);

disp('مثال 1:');
disp(['x = ', num2str(x1)]);
disp(['h = ', num2str(h1)]);
disp('کانولوشن چرخشی:'); disp(y1);

x2 = [1 1 1 1];
h2 = [1 1 1 1];
y2_circ = circconv1(x2, h2);

disp('مثال 2:');
disp(['x = ', num2str(x2)]);
disp(['h = ', num2str(h2)]);
disp('کانولوشن چرخشی:'); disp(y2_circ);
%% A12
clc; clear; close all;

x1 = [1 2 3];
h1 = [4 5];
y1_true = conv(x1, h1);
y1_circ_method = linear_conv_using_circconv1(x1, h1);

disp('x = [1 2 3], h = [4 5]');
y1_true
y1_circ_method

x2 = [1 1 1];
h2 = [1 1 1];
y2_true = conv(x2, h2);
y2_circ_method = linear_conv_using_circconv1(x2, h2);

disp('x = [1 1 1], h = [1 1 1]');
y2_true
y2_circ_method
%% A13
clear; close all; clc;
x1 = [1 2 3];
h1 = [4 5];
y1_fft = conv_fft(x1, h1);
y1_conv = conv(x1, h1);

disp('x = [1 2 3], h = [4 5]');
disp('کانولوشن با FFT:'); disp(y1_fft);
disp('کانولوشن مستقیم:'); disp(y1_conv);

x2 = [1 -1 2 -2 3 -3 4 -4];
h2 = [0.2 0.5 0.8 0.5 0.2];
y2_fft = conv_fft(x2, h2);
y2_conv = conv(x2, h2);
disp('x = [1 -1 2 -2 3 -3 4 -4], h = [0.2 0.5 0.8 0.5 0.2]');
disp('کانولوشن با FFT:'); disp(y2_fft);
disp('کانولوشن مستقیم:'); disp(y2_conv);
