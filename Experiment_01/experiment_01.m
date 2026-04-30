%% Q1
clc;clear;close all;

x = input("Enter a number:");
y = x^2 + 3*x + 10;

ang = angle(y);
magnitude = abs(y);

disp(['Result = ' num2str(y)]);
fprintf("Angle (rad) = %f\n", ang);
fprintf("Angle (degree) = %f\n", rad2deg(ang));
fprintf("Magnitude = %f\n", magnitude);

%% Q2
clc;clear;close all;

zoj_do_ragham = 10:2:99;
zoj_yek_ragham = linspace(0, 8, 5);

zoj = [zoj_yek_ragham, zoj_do_ragham];
disp(['zoj yek ragham = ' num2str(zoj_yek_ragham)])
disp(['zoj do ragham = ' num2str(zoj_do_ragham)])
disp(['zoj concatination= ' num2str(zoj)])
%% Q3
clc;clear;close all;

n = input("Enter n: ");
x = -2*n*pi : 0.1 : 2*n*pi;
y = abs(sin(x)) + 5 .* x.^3 + 20;

disp(['x = ' num2str(x)])
disp(['y = ' num2str(y)])
%% Q4
clc; clear; close all;

numbers = 1:10;
mat = repmat(numbers, 10,1)
%% Q5
clc; clear; close all;

% mat = [ 19, 3
%         20, 3
%         15, 3
%         17, 3
%         20, 1 ];

mat = input("enter a mat: ");
vahedha = sum(mat(:, 2));
moadel = sum(mat(:,1) .* mat(:,2)) / vahedha;

disp(['Vahedha: ' num2str(vahedha)]);
disp(['Moadel: ' num2str(moadel)]);
%% Q6
clc; clear; close all;

x = [];

for n=1:10
    x(n) = sin(n * pi / 10);
end

disp(['x = ' num2str(x)])

ages = input('Ages = ');
k = length(ages);

for i=1:k
    if ages(i) < 17
        disp('Teen');
    elseif ages(i) > 17 && ages(i) < 40
        disp('Young')
    elseif ages(i) > 40 && ages(i) < 60
        disp('Middle-aged')
    end
end
%% Q7
% grade_analyzer.m is the function
clc; clear; close all;
scores = randi([10, 20], 10, 5)
ids = 101:110
[avg, gpa] = grade_analyzer(scores, ids);
%% Q8
clc; clear; close all;

mat = randn(3);

trace_mat = trace(mat)
pseudoinverse_mat = pinv(mat)
inverse_mat = inv(mat)
det_mat = det(mat)
%% Q9
clc; clear; close all;

N = 20;
M = 5;
n = 0:N-1;
A = 2;
c = -0.1;

delta = [1, zeros(1, N-1)];
u = ones(1, N);
delta_M = [zeros(1, M), 1, zeros(1, N - M - 1)];
exponential = A * exp(n * c);

E_delta = sum(delta .* delta);
E_u = sum(u .* u);
E_delta_M = sum(delta_M .* delta_M);
E_exp = sum(exponential .* exponential);

disp(['انرژی ضربه: ' num2str(E_delta)]);
disp(['انرژی پله: ' num2str(E_u)]);
disp(['انرژی ضربه تاخیر یافته: ' num2str(E_delta_M)]);
disp(['انرژی نمایی: ' num2str(E_exp)]);

figure; grid on;
subplot(2,2,1);
stem(n, delta, 'filled', 'LineWidth', 2);
title('تابع ضربه');

subplot(2,2,2);
stem(n, u,  'filled', 'LineWidth', 2);
title('تابع پله واحد');

subplot(2,2,3);
stem(n, delta_M, 'filled', 'LineWidth', 2);
title(['ضربه با تاخیر M=' num2str(M)]);

subplot(2,2,4);
stem(n, exponential, 'filled', 'LineWidth', 2);
title('تابع نمایی');
%% Q10
clc; clear; close all;

fs = 10;
t = 0:1/fs:10;
A = 1;

f1 = 0.9;
signal1 = A * cos(2 * pi * f1 * t);

f2 = 1.1;
phase_shift = pi/2;
signal2 = A * cos(2 * pi * f2 * t + phase_shift);


figure;
stem(t, signal1, 'b', 'DisplayName', 'Signal 1', 'LineWidth', 2);
hold on;
stem(t, signal2, 'r', 'DisplayName', 'Signal 2', 'LineWidth', 2);
legend('f=0.9', 'f=1.1 (\phi=90^\circ)');

mean_power1 = mean(signal1.^2);
mean_power2 = mean(signal2.^2);

disp(['توان متوسط سیگنال ۱: ', num2str(mean_power1)]);
disp(['توان متوسط سیگنال ۲: ', num2str(mean_power2)]);
%% Q11
clc; clear; close all;

N = 50;
f = 0.08;
A = 2.5;
phi = pi/2;

n = 0:N-1; 
x = A * cos(2 * pi * f * n + phi);


% رسم
figure;
stem(n, x, 'filled', 'LineWidth', 1.5);
title('A=2.5, f=0.08, \phi=90^\circ');
xlabel('n');
ylabel('Amplitude');
grid on;

%% Q12
clc; clear; close all;

N = 30;
n = 0:N-1;
signal = cos(2*pi*0.1*n);

figure;
subplot(3,1, 1); plot(n, signal, 'LineWidth', 2); title('plot');
subplot(3,1, 2); stem(n, signal, 'LineWidth', 2); title('stem');
subplot(3,1, 3);stairs(n, signal,'LineWidth', 2); title('stairs');
%% Q13
clc; clear; close all;

N1 = 100;
N2 = 75;

signal_uniform = -2 + 4 * rand(1, N1);
signal_normal = sqrt(3) * randn(1, N2);

N_max = max(N1, N2);
signal_uniform_padded = [signal_uniform, zeros(1, N_max - N1)];
signal_normal_padded = [signal_normal, zeros(1, N_max - N2)];

figure;
plot(signal_uniform_padded, 'b', 'DisplayName', 'Signal Uniform');
hold on;
plot(signal_normal_padded, 'r', 'DisplayName', 'Signal Normal');
legend show;
title('Random Signals');
grid on;

fprintf('signal_uniform_padded:\n')
f14(signal_uniform_padded);
fprintf('\nsignal_normal_padded:\n');
f14(signal_normal_padded);

%% Q14
% function is f14.m file

% function [mean_value, var_value] = f14(signal)
%     mean_value = mean(signal);
%     var_value = var(signal);
% 
%     disp(['miangin: ' num2str(mean_value)]);
%     disp(['variance: ' num2str(var_value)]);
% end

%% Q15
clc; clear; close all;

N = 50;
n = 0:N-1;
f = 0.1; 

n_samples = 5;

figure;
for k = 1:n_samples
    A = rand(1) * 80;
    phi = rand(1) * 2*pi;
    
    x = A * cos(2 * pi * f * n + phi);
    
    subplot(5,1,k);
    stem(n, x, 'filled', 'LineWidth', 1.2);
    title(['Sample ', num2str(k), ': A=', num2str(A,2), ', \phi=', num2str(phi,2)]);
    ylabel('Amplitude');
    if k == 5, xlabel('n'); end
    grid on;
end
%% Q16
clc; clear; close all;

N = 51;
n = 0:N-1;
sig = 2 * n .* (0.9).^n;

noise = 0.8 * randn(size(n));
noisy_sig = sig + noise;


% y[n] = (1/3) * (x[n-1] + x[n] + x[n+1])
y = zeros(size(n));
for n_idx = 2:N-1
    y(n_idx) = (1/3) * (noisy_sig(n_idx-1) + noisy_sig(n_idx) + noisy_sig(n_idx+1));
end

figure;
grid on;

subplot(3,1,1);
plot(n, sig);
title('Signal');

subplot(3,1,2);
plot(n, noisy_sig);
title('Signal With Noise');

subplot(3,1,3);
plot(n, y);
title('Output signal');

%% Q16 b (Soale Tamrin)
clc; clear; close all;

N = 50;
n = 0:N-1;
f = 0.1; 

n_samples = 5;

figure;
for k = 1:n_samples
    A = rand(1) * 80;
    phi = rand(1) * 2*pi;
    
    x = A * cos(2 * pi * f * n + phi);
    y = zeros(size(n));
    for n_idx = 2:N-1
        y(n_idx) = (1/3) * (x(n_idx-1) + x(n_idx) + x(n_idx+1));
    end
    
    subplot(5,2, 2*k-1);
    stem(n, x, 'filled', 'LineWidth', 1.2);
    title(['Input sample ', num2str(k), ': A=', num2str(A,2), ', \phi=', num2str(phi,2)]);
    ylabel('Amplitude');

    subplot(5,2, 2*k);
    stem(n, y, 'filled', 'LineWidth', 1.2);
    title(['Output sample ', num2str(k), ': A=', num2str(A,2), ', \phi=', num2str(phi,2)]);
    ylabel('Amplitude');

    
    if k == 5, xlabel('n'); end
    grid on;
    
end

%% Q17 a (jozve)
clc; clear; close all;

n = 0:100;
a = pi/200; b = 0;

arg = a* n .* n + b * n;
x = cos(arg);
stem(n, x);
axis([0, 100, -1.5, 1.5]);
title('Signal');
xlabel('Time');
ylabel('Amplitude');

%% Q17 b
n = 0:100;
a = 0.002;
b = 0.2;

arg = 2 * pi * (a * n.^2 + b * n);
x = cos(arg);

stem(n, x, 'filled', 'LineWidth', 1.2);
axis([0, 100, -1.5, 1.5]);
title('Chirp Signal (Linear Frequency Modulation)');
xlabel('n');
ylabel('Amplitude');
grid on;

%% Q18
clc; clear; close all;

N = 100;
f_min = 0.2;
f_max = 0.6;

frequencies = (f_max - f_min) * rand(N, 1) + f_min;

n = 0:N-1;
t = n / N;

x = zeros(1, N);
for i = 1:N
    arg = 2 * pi * frequencies(i) * t(i);
    x(i) = cos(arg);
end

stem(n, x);
axis([0, N-1, -1.5, 1.5]);
title('Signal with Varying Frequency');
xlabel('Time');
ylabel('Amplitude');

grid on;

%% Q19
clc; clear; close all;

n = 0:200;
fc = 0.2;
fm = 0.01;
A = 1;
m = 0.5;

xL = cos(2*pi*fm*n); % سیگنال پیام
xH = cos(2*pi*fc*n); % حامل
y = A * (1 + m * xL) .* xH;

figure;
subplot(3,1,1); plot(n, xL);
title('سیگنال پیام'); ylim([-1.5 1.5]); grid on;
subplot(3,1,2); plot(n, xH);
title('سیگنال حامل'); ylim([-1.5 1.5]); grid on;
subplot(3,1,3); plot(n, y);
title('سیگنال مدوله شده AM'); ylim([-2 2]); grid on;

%% Q20
clc; clear; close all;

t = linspace(0, 6*pi - 1, 100);

A = sawtooth(t) - sawtooth(t-20) + 0.7;
B = sawtooth(t-20) - sawtooth(t) - 0.7;
C = sawtooth(t);
D = square(t) .* sawtooth(t) + 0.5;


figure; grid on;
subplot(4,1,1); stem(t, A, 'LineWidth', 2);
subplot(4,1,2); stem(t, B, 'LineWidth', 2);
subplot(4,1,3); stem(t, C, 'LineWidth', 2);
subplot(4,1,4); stem(t, D, 'LineWidth', 2);