%% 1
clc; clear; close all;

N = 100;
n = 0:N-1;
f_signal = 0.02;
f_noise = 0.3;

x = sin(2*pi*f_signal*n) + 0.3*sin(2*pi*f_noise*n);


M_values = [3, 5, 10];

figure;
subplot(length(M_values)+1, 1, 1);
stem(n, x, 'filled', 'LineWidth', 1.2);
title('سیگنال ورودی (سینوسی + نویز فرکانس بالا)');
xlabel('n'); ylabel('Amplitude');
grid on;

for idx = 1:length(M_values)
    M = M_values(idx);
    b = ones(1, M) / M;
    a = 1;
    y = filter(b, a, x);
    
    subplot(length(M_values)+1, 1, idx+1);
    stem(n, y, 'filled', 'LineWidth', 1.2);
    title(['خروجی فیلتر میانگین با M = ', num2str(M)]);
    xlabel('n'); ylabel('Amplitude');
    grid on;
end


%% 2
clc; clear; close all;

N = 100;
n = 0:N-1;
f_signal = 0.02;
f_noise = 0.3;

x = sin(2*pi*f_signal*n) + 0.3*sin(2*pi*f_noise*n);

% y[n] = 0.5*(x[n] - x[n-1])
b_diff = [0.5, -0.5];
a_diff = 1;
y_diff = filter(b_diff, a_diff, x);

figure;
subplot(3,1,1);
stem(n, x, 'filled');
title('سیگنال ورودی');
xlabel('n'); ylabel('Amplitude');
grid on;

subplot(3,1,2);
b_avg = [0.5, 0.5];
y_avg = filter(b_avg, 1, x);
stem(n, y_avg, 'filled');
title('M=2 y-avg');
xlabel('n'); ylabel('Amplitude');
grid on;

subplot(3,1,3);
stem(n, y_diff, 'filled');
title('y[n] = 0.5(x[n] - x[n-1])');
xlabel('n'); ylabel('Amplitude');
grid on;

%% 2 b 
clc; clear; close all;

N = 100;
n = 0:N-1;

a = 0.0025;
b = 0;
arg = 2*pi * (a * n.^2 + b * n);
x_chirp = cos(arg);

M = 5;
b_avg = ones(1, M)/M;
y_avg_chirp = filter(b_avg, 1, x_chirp);

b_diff = [0.5, -0.5];
y_diff_chirp = filter(b_diff, 1, x_chirp);

figure;
subplot(3,1,1);
stem(n, x_chirp, 'filled', 'LineWidth', 1);
title('سیگنال ورودی (فرکانس 0 تا 0.5)');
xlabel('n'); ylabel('Amplitude');
grid on;

subplot(3,1,2);
stem(n, y_avg_chirp, 'filled', 'LineWidth', 1);
title('خروجی فیلتر میانگین (پایین‌گذر)');
xlabel('n'); ylabel('Amplitude');
grid on;

subplot(3,1,3);
stem(n, y_diff_chirp, 'filled', 'LineWidth', 1);
title('خروجی فیلتر تفاضل‌گیر (بالاگذر)');
xlabel('n'); ylabel('Amplitude');
grid on;


%% 3
clc; clear; close all;

N = 100;
n = 0:N-1;

x_dc = 2 * ones(1, N);
y_dc = zeros(1, N);
for i = 2:N-1
    y_dc(i) = x_dc(i)^2 - x_dc(i-1)*x_dc(i+1);
end

figure;
subplot(3,2,1);
stem(n, x_dc, 'filled');
title('ورودی DC');
grid on;
subplot(3,2,2);
stem(n, y_dc, 'filled');
title('خروجی برای ورودی DC');
grid on;

f = 0.05;
x_sin = cos(2*pi*f*n);
y_sin = zeros(1, N);
for i = 2:N-1
    y_sin(i) = x_sin(i)^2 - x_sin(i-1)*x_sin(i+1);
end

subplot(3,2,3);
stem(n, x_sin, 'filled');
title('ورودی سینوسی');
grid on;
subplot(3,2,4);
stem(n, y_sin, 'filled');
title('خروجی برای ورودی سینوسی');
grid on;

x_comb = x_dc + x_sin;
y_comb = zeros(1, N);
for i = 2:N-1
    y_comb(i) = x_comb(i)^2 - x_comb(i-1)*x_comb(i+1);
end

subplot(3,2,5);
stem(n, x_comb, 'filled');
title('ورودی ترکیبی (DC + سینوسی)');
grid on;
subplot(3,2,6);
stem(n, y_comb, 'filled');
title('خروجی برای ورودی ترکیبی');
grid on;

% y_comb = y_dc + y_sin ?
y_sum = y_dc + y_sin;
difference = y_comb - y_sum;

figure;
subplot(2,1,1);
stem(n, y_sum, 'filled');
title('y_{DC} + y_{sin}');
xlabel('n'); ylabel('y_sum');

subplot(2,1,2);
stem(n, difference, 'filled');
title('Difference');
xlabel('n'); ylabel('Difference');
grid on;

%% 4
clc; clear; close all;

N = 100;
n = 0:N-1;

b = [2.24, 2.49, 2.24];
a = [1, -0.4, -0.75];

x1 = cos(2*pi*0.05*n);
x2 = cos(2*pi*0.15*n);

y1 = filter(b, a, x1);
y2 = filter(b, a, x2);

alpha = 2;
beta = 3;
x_combined = alpha*x1 + beta*x2;
y_combined = filter(b, a, x_combined);

y_sum = alpha*y1 + beta*y2;

difference = y_combined - y_sum;

figure;
subplot(2,1,1);
plot(n, y_combined, 'b', n, y_sum, 'r--', 'LineWidth', 1.5);
legend('y(αx_1+βx_2)', 'αy(x_1)+βy(x_2)');
title('مقایسه خروجی‌ها');
grid on;

subplot(2,1,2);
plot(n, difference, 'LineWidth', 1.5);
title('تفاوت دو خروجی');
xlabel('n');
grid on;

%% 5
clc; clear; close all;

N = 50;
n = 0:N-1;

x1 = ones(1, N);
x2 = cos(2*pi*0.1*n);
alpha = 1;
beta = 1;

y1 = zeros(1, N);
y2 = zeros(1, N);
for i = 2:N
    y1(i) = x1(i) * x1(i-1);
    y2(i) = x2(i) * x2(i-1);
end

% ترکیب خطی
x_comb = alpha*x1 + beta*x2;
y_comb = zeros(1, N);
for i = 2:N
    y_comb(i) = x_comb(i) * x_comb(i-1);
end

y_sum = alpha*y1 + beta*y2;

% مقایسه
difference = y_comb - y_sum;

figure;
subplot(2,1,1);
plot(n, y_sum, 'r', 'LineWidth', 1.5);
title('y_{sum} (red) , y_{comb} (blue)');
xlabel('n'); ylabel('y');
hold on;
plot(n, y_comb, 'b', 'LineWidth', 1.5);
xlabel('n'); ylabel('y');

grid on;
subplot(2,1,2);
plot(n, difference, 'LineWidth', 1.5);
title('Difference');
xlabel('n'); ylabel('Difference');
grid on;

%% 6
clc; clear; close all;

N = 100;
n = 0:N-1;

b = [2.24, 2.49, 2.24];
a = [1, -0.4, -0.75];

x1 = cos(2*pi*0.05*n);
x2 = cos(2*pi*0.15*n);

Zi = randn(2, 1);

y1_ic = filter(b, a, x1, Zi);
y2_ic = filter(b, a, x2, Zi);

x_comb = x1 + x2;
y_comb_ic = filter(b, a, x_comb, Zi);

y_sum_ic = y1_ic + y2_ic;

difference = y_comb_ic - y_sum_ic;

figure;
plot(n, difference, 'LineWidth', 1.5);
title('تفاوت با شرایط اولیه غیرصفر');
grid on;

%% 7
clc; clear; close all;

N = 100;
n = 0:N-1;

b = [2.24, 2.49, 2.24];
a = [1, -0.4, -0.75];

x = cos(2*pi*0.05*n);

D = 10;
x_delayed = [zeros(1, D), x(1:end-D)];

y_original = filter(b, a, x);
y_delayed_input = filter(b, a, x_delayed);

y_original_delayed = [zeros(1, D), y_original(1:end-D)];

difference = y_delayed_input - y_original_delayed;

figure;
subplot(3,1,1);
stem(n, y_delayed_input, 'b', 'filled');
title('خروجی برای ورودی تاخیر یافته y1');
grid on;

subplot(3,1,2);
stem(n, y_original_delayed, 'r', 'filled');
title('خروجی اصلی تاخیر یافته y2');
grid on;

subplot(3,1,3);
stem(n, difference, 'filled');
title(['تفاوت (D = ', num2str(D), ')']);
grid on;

%% 8
clc; clear; close all;

N = 100;
n = 0:N-1;
D = 10;

b = [2.24, 2.49, 2.24];
a = [1, -0.4, -0.75];

x = cos(2*pi*0.05*n);
x_delayed = [zeros(1, D), x(1:end-D)];

Zi = [0.5; -0.3];  % شرایط اولیه غیرصفر

y_original_ic = filter(b, a, x, Zi);
y_delayed_input_ic = filter(b, a, x_delayed, Zi);
y_original_delayed_ic = [zeros(1, D), y_original_ic(1:end-D)];

difference_ic = y_delayed_input_ic - y_original_delayed_ic;

figure;
plot(n, difference_ic, 'LineWidth', 1.5);
title('تفاوت با شرایط اولیه غیرصفر');
grid on;


%% 9
clc; clear; close all;

N = 50;
n = 0:N-1;
D = 10;

x = cos(2*pi*0.1*n);
x_delayed = [zeros(1, D), x(1:end-D)];

% خروجی برای ورودی اصلی
y_original = zeros(1, N);
for i = 2:N
    y_original(i) = n(i)*x(i) + x(i-1);
end

% خروجی برای ورودی تاخیر یافته
y_delayed = zeros(1, N);
for i = 2:N
    y_delayed(i) = n(i)*x_delayed(i) + x_delayed(i-1);
end

% تاخیر خروجی اصلی
y_original_shifted = [zeros(1, D), y_original(1:end-D)];

difference = y_delayed - y_original_shifted;

figure;
subplot(3,1,1);
plot(n, difference, 'LineWidth', 1.5);
title('y original shifted');
grid on;
subplot(3,1,2);
plot(n, y_delayed, 'LineWidth', 1.5);
title('y delayed');
grid on;
subplot(3,1,3);
plot(n, difference, 'LineWidth', 1.5);
title('Difference y[n] = n x[n] + x[n-1]');
grid on;

%% 10 
clc; clear; close all;

% ضرایب سیستم
b = [0.9, -0.45, 0.35, 0.2];
a = [1, 0.71, -0.46, -0.62];

% impz
N_imp = 50;
[h_imp, t_imp] = impz(b, a, N_imp);

% filter
N_filt = 40;
delta = [1, zeros(1, N_filt-1)];  % ورودی ضربه
h_filt = filter(b, a, delta);

% رسم
figure;
subplot(2,1,1);
stem(0:N_imp-1, h_imp, 'filled', 'LineWidth', 1.2);
title('پاسخ ضربه با impz و ۵۰ نمونه');
xlabel('n'); ylabel('h[n]');
grid on;

subplot(2,1,2);
stem(0:N_filt-1, h_filt(1:N_filt), 'filled', 'LineWidth', 1.2);
title('پاسخ ضربه با filter و ۴۰ نمونه');
xlabel('n'); ylabel('h[n]');
grid on;

%% 11
clc; clear; close all;

b = [0.9, -0.45, 0.35, 0.2];
a = [1, 0.71, -0.46, -0.62];

N = 40;

% cumsum
h = impz(b, a, N);
s1 = cumsum(h);

% filter
u = ones(1, N);
s2 = filter(b, a, u);

% رسم
figure;
subplot(2,1,1);
stem(0:N-1, s1, 'filled', 'LineWidth', 1.2);
title('Method 1 - impz');
xlabel('n'); ylabel('s[n]');
grid on;

subplot(2,1,2);
stem(0:N-1, s2, 'filled', 'LineWidth', 1.2);
title('Method 2 - filter');
xlabel('n'); ylabel('s[n]');
grid on;
%% 12
clc; clear; close all;

b = [0.06, -0.19, 0.27, -0.26, 0.12];
a = [1, 1.6, 2.28, -1.35, 0.68];

% sys 1
b1 = [0.3, -0.2, 0.4];
a1 = [1, 0.9, 0.8];

% sys 2
b2 = [0.2, -0.5, 0.3];
a2 = [1, 0.7, 0.85];

b_series = conv(b1, b2);
a_series = conv(a1, a2);

disp('ضرایب سیستم اصلی:');
disp('b = '); disp(b);
disp('a = '); disp(a);

disp('ضرایب سری دو سیستم:');
disp('b_{series} = '); disp(b_series);
disp('a_{series} = '); disp(a_series);
%% 13
clc; clear; close all;

b_main = [0.06, -0.19, 0.27, -0.26, 0.12];
a_main = [1, 1.6, 2.28, -1.35, 0.68];

b1 = [0.3, -0.2, 0.4];
a1 = [1, 0.9, 0.8];

b2 = [0.2, -0.5, 0.3];
a2 = [1, 0.7, 0.85];

b_series = conv(b1, b2);
a_series = conv(a1, a2);

N = 100;
n = 0:N-1;
f = 0.05;
x = cos(2*pi*f*n);

% ========== حالت اول: شرایط اولیه صفر ==========
y_main_zic = filter(b_main, a_main, x);
y_series_zic = filter(b_series, a_series, x);
diff_zic = y_main_zic - y_series_zic;

Z = [0.5; -0.3; 0.8; -0.2];

% اجرای سیستم اصلی با شرایط اولیه غیرصفر
[y_main_ic, ~] = filter(b_main, a_main, x, Z);
[y_series_ic, ~] = filter(b_series, a_series, x, Z);
diff_ic = y_main_ic - y_series_ic;

figure;
subplot(2,2,1);
stem(n, y_main_zic, 'b', 'filled', 'LineWidth', 1);
title('سیستم اصلی - شرایط اولیه صفر');
xlabel('n'); ylabel('y[n]'); grid on;

subplot(2,2,2);
stem(n, y_series_zic, 'r', 'filled', 'LineWidth', 1);
title('سیستم سری - شرایط اولیه صفر');
xlabel('n'); ylabel('y[n]'); grid on;

% حالت دوم: شرایط غیرصفر
subplot(2,2,3);
stem(n, y_main_ic, 'b', 'filled', 'LineWidth', 1);
title('سیستم اصلی - غیر صفر');
xlabel('n'); ylabel('y[n]'); grid on;

subplot(2,2,4);
stem(n, y_series_ic, 'r', 'filled', 'LineWidth', 1);
title('سیستم سری - غیرصفر');
xlabel('n'); ylabel('y[n]'); grid on;

% ========== نمایش مقایسه در یک پنجره ==========
figure;

subplot(2,2,1);
plot(n, y_main_zic, 'b', n, y_series_zic, 'r--', 'LineWidth', 1.5);
legend('اصلی', 'سری');
title('مقایسه - شرایط اولیه صفر');
grid on;

subplot(2,2,2);
plot(n, y_main_ic, 'b', n, y_series_ic, 'r--', 'LineWidth', 1.5);
legend('اصلی', 'سری');
title('مقایسه - غیرصفر');
grid on;

subplot(2,2,3);
plot(n, diff_zic, 'LineWidth', 1.5);
title('تفاوت صفر');
xlabel('n'); grid on;

subplot(2,2,4);
plot(n, diff_ic, 'LineWidth', 1.5);
title('تفاوت غیرصفر');
xlabel('n'); grid on;

%% 14
clc; clear; close all;

b = [0.9, -0.45, 0.35, 0.2];
a = [1, 0.71, -0.46, -0.62];

N = 50;
n = 0:N-1;

% ۱) ورودی ضربه
x_imp = [1, zeros(1, N-1)];

% ۲) ورودی پله
x_step = ones(1, N);

% ۳) ورودی سینوسی
x_sin = cos(2*pi*0.05*n);

% پاسخ ضربه سیستم
h = impz(b, a, N)';

% filter
y_imp_filt = filter(b, a, x_imp);
y_step_filt = filter(b, a, x_step);
y_sin_filt = filter(b, a, x_sin);

% conv
y_imp_conv = conv(x_imp, h);
y_step_conv = conv(x_step, h);
y_sin_conv = conv(x_sin, h);

figure;
subplot(3,2,1);
stem(0:N-1, y_imp_filt, 'b', 'filled'); hold on;
stem(0:length(y_imp_conv)-1, y_imp_conv, 'r--');
title('ورودی ضربه'); legend('filter', 'conv');
grid on;

subplot(3,2,2);
plot(0:N-1, y_imp_filt - y_imp_conv(1:N), 'LineWidth', 1.5);
title('تفاوت (ضربه)'); grid on;

subplot(3,2,3);
stem(0:N-1, y_step_filt, 'b', 'filled'); hold on;
stem(0:length(y_step_conv)-1, y_step_conv, 'r--');
title('ورودی پله'); legend('filter', 'conv');
grid on;

subplot(3,2,4);
plot(0:N-1, y_step_filt - y_step_conv(1:N), 'LineWidth', 1.5);
title('تفاوت (پله)'); grid on;

subplot(3,2,5);
stem(0:N-1, y_sin_filt, 'b', 'filled'); hold on;
stem(0:length(y_sin_conv)-1, y_sin_conv, 'r--');
title('ورودی سینوسی'); legend('filter', 'conv');
grid on;

subplot(3,2,6);
plot(0:N-1, y_sin_filt - y_sin_conv(1:N), 'LineWidth', 1.5);
title('تفاوت (سینوسی)'); grid on;

%% 15
clc; clear; close all;

b1 = [1, -0.8];
a1 = [1, 1.5, 0.9];

N = 100;
h1 = impz(b1, a1, N);

sum_abs_h1 = sum(abs(h1));

figure;
subplot(2,1,1);
zplane(b1, a1);
title('قطب‌ها و صفرهای سیستم ۱');

subplot(2,1,2);
stem(0:N-1, h1, 'filled', 'LineWidth', 1.2);
title('پاسخ ضربه سیستم ۱');
xlabel('n'); ylabel('h[n]');
grid on;

disp(['Q15 - Sum of h[n]: ', num2str(sum_abs_h1)]);

%% 16
b2 = [1, -4, 3];
a2 = [1, -1.76, 1];

h2 = impz(b2, a2, N);
sum_abs_h2 = sum(abs(h2));

figure;
subplot(2,1,1);
zplane(b2, a2);
title('قطب‌ها و صفرهای سیستم ۲');

subplot(2,1,2);
stem(0:N-1, h2, 'filled', 'LineWidth', 1.2);
title('پاسخ ضربه سیستم ۲');
xlabel('n'); ylabel('h[n]');
grid on;

disp(['Q16 - Sum of h[n]: ', num2str(sum_abs_h2)]);
