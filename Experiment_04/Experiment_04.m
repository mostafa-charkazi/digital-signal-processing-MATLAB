%% A01
clc; clear; close all;
b = [1, -0.5];
a = [1, -1.2, 0.8];
figure;
subplot(1,2,1);
zplane(b, a);
title('zplane(b,a)');

[z, p, k] = tf2zp(b, a);
subplot(1,2,2);
zplane(z, p);
title('zplane(z,p)');
%% A02
clear; close all; clc;

num = [2, 5, 9, 5, 3];
den = [5, 45, 2, 1, 1];

% رسم نمودار قطب و صفر
figure;
zplane(num, den);
title('نمودار قطب‌ها و صفرها');
grid on;
%% A03
clear; close all; clc;
num = [2, 5, 9, 5, 3];
den = [5, 45, 2, 1, 1];
[z, p, k] = tf2zp(num, den);

disp('صفرها:'); disp(z);
disp('قطب‌ها:'); disp(p);
disp('بهره:'); disp(k);
%% A04
clc; clear; close all;
b = [2, 5, 9, 5, 3];
a = [5, 45, 2, 1, 1];

[z, p, k] = tf2zp(b, a);
disp('[z, p, k] = tf2zp(b, a): ');
disp('z:'); disp(z);
disp('p:'); disp(p);
disp('k:'); disp(k);

[b2, a2] = zp2tf(z, p, k);
disp('[b2, a2] = zp2tf(z, p, k): ');
disp('b:'); disp(b2);
disp('a:'); disp(a2);

[r, p_res, k_res] = residuez(b, a);
disp('[r, p_res, k_res] = residuez(b, a): ');
disp('r:'); disp(r);
disp('p:'); disp(p_res);
disp('k:'); disp(k_res);

%% A05
clear; close all; clc;

omega_c1 = 0.25;
N1 = 20;
N2 = 50;

h1 = fir_lp(omega_c1, N1);
h2 = fir_lp(omega_c1, N2);

omega_c2 = 0.45;
h3 = fir_lp(omega_c2, N1);

figure;
subplot(2,2,1);
stem(0:N1, h1);
title(sprintf('FIR LP, \\omega_c = %.2f, N=%d', omega_c1, N1));
xlabel('n'); ylabel('h[n]'); grid on;

subplot(2,2,2);
stem(0:N2, h2);
title(sprintf('FIR LP, \\omega_c = %.2f, N=%d', omega_c1, N2));
xlabel('n'); ylabel('h[n]'); grid on;

subplot(2,2,3);
stem(0:N1, h3);
title(sprintf('FIR LP, \\omega_c = %.2f, N=%d', omega_c2, N1));
xlabel('n'); ylabel('h[n]'); grid on;

% رسم پاسخ فرکانسی برای مقایسه
[H1, w] = freqz(h1, 1, 1024);
[H3, w] = freqz(h3, 1, 1024);
subplot(2,2,4);
plot(w/pi, abs(H1), 'b', w/pi, abs(H3), 'r');
title('پاسخ فرکانسی فیلترها');
xlabel('فرکانس نرمال‌شده');
ylabel('|H(e^{j\omega})|');
legend('\omega_c=0.25', '\omega_c=0.45');
grid on;
%% A06
clear; close all; clc;

M = 5;
b = (1/M) * ((-1).^(0:M-1));
a = 1;

[H, w] = freqz(b, a, 1024);
gain_dB = 20 * log10(abs(H));

figure;
plot(w/pi, gain_dB);
title(sprintf('بهره فیلتر بالاگذر با M=%d', M));
xlabel('فرکانس نرمال‌شده');
ylabel('بهره (dB)');
grid on;
hold on;

f_3db = max(gain_dB) - 3;
y_3db = ones(1, length(gain_dB)) * f_3db;
plot(w/pi ,y_3db);

%% A07
clear; close all; clc;

b = 1;
a1 = [1, -1.848, 0.85];
a2 = [1, -1.85, 0.85];

figure;
subplot(1,2,1);
zplane(b, a1);
title('H1(z)');
subplot(1,2,2);
zplane(b, a2);
title('H2(z)');

[z1, p1, k1] = tf2zp(b, a1);
[z2, p2, k2] = tf2zp(b, a2);
disp('قطب‌های H1:'); disp(p1);
disp('قطب‌های H2:'); disp(p2);

stable1 = all(abs(p1) < 1);
stable2 = all(abs(p2) < 1);
fprintf('H1 stablity: %s\n', string(stable1));
fprintf('H2 stablity: %s\n', string(stable2));

k1_rc = poly2rc(a1);
k2_rc = poly2rc(a2);
disp('poly2rc H1:'); disp(k1_rc);
disp('poly2rc H2:'); disp(k2_rc);
stable1_rc = all(abs(k1_rc) < 1);
stable2_rc = all(abs(k2_rc) < 1);
disp('poly2rc stablity:');
fprintf('H1 stablity: %s\n', string(stable1_rc));
fprintf('H2 stablity: %s\n', string(stable2_rc));