clc; clear; close all;

b_main = [0.06, -0.19, 0.27, -0.26, 0.12];
a_main = [1, 1.6, 2.28, 1.325, 0.68];

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
