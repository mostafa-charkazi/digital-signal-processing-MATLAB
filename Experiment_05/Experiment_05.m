%% A01
clc; clear; close all;

Fs = 10000;
Fpass = 2000;
Fstop = 2500;
Rp = 0.005;
Rs = 0.005;

% تخمین مرتبه فیلتر
[N, Wn, beta, ftype] = kaiserord([Fpass Fstop], [1 0], [Rp Rs], Fs);

% طراحی فیلتر با پنجره مستطیلی (بدون پنجره‌گذاری)
b = fir1(N, Wn, ftype, rectwin(N+1));   % ← rectwin = همه ضرایب 1

[H, f] = freqz(b, 1, 1024, Fs);
mag_dB = 20*log10(abs(H));
phase_deg = unwrap(angle(H)) * 180/pi;

figure;
subplot(2,1,1);
plot(f, mag_dB); grid on;
title('پاسخ فرکانسی فیلتر FIR (پنجره مستطیلی - بدون پنجره‌گذاری)');
xlabel('Hz'); ylabel('dB');
xlim([0 Fs/2]);
line([Fpass Fpass], [-100 10], 'Color','r','LineStyle','--');
line([Fstop Fstop], [-100 10], 'Color','r','LineStyle','--');
legend('بهره', 'Fpass', 'Fstop');

subplot(2,1,2);
plot(f, phase_deg); grid on;
xlabel('Hz'); ylabel('فاز (درجه)');
xlim([0 Fs/2]);
%% A02
clc; clear; close all;

Fs = 10000;
Fpass = 2000;
Fstop = 2500;
Rp = 0.005;
Rs = 0.005;

% تخمین مرتبه فیلتر
[N, Wn, beta, ftype] = kaiserord([Fpass Fstop], [1 0], [Rp Rs], Fs);

% پنجره Hamming
b_hamm = fir1(N, Wn, ftype, hamming(N+1));
% پنجره Blackman
b_black = fir1(N, Wn, ftype, blackman(N+1));


b = b_hamm;
[H, f] = freqz(b, 1, 1024, Fs);
mag_dB = 20*log10(abs(H));
phase_deg = unwrap(angle(H)) * 180/pi;

figure;
subplot(2,1,1);
plot(f, mag_dB); grid on;
title('پاسخ فرکانسی فیلتر FIR (پنجره همینگ)');
xlabel('Hz'); ylabel('dB');
xlim([0 Fs/2]);
line([Fpass Fpass], [-100 10], 'Color','r','LineStyle','--');
line([Fstop Fstop], [-100 10], 'Color','r','LineStyle','--');
legend('بهره', 'Fpass', 'Fstop');

subplot(2,1,2);
plot(f, phase_deg); grid on;
xlabel('Hz'); ylabel('فاز (درجه)');
xlim([0 Fs/2]);

b = b_black;
[H, f] = freqz(b, 1, 1024, Fs);
mag_dB = 20*log10(abs(H));
phase_deg = unwrap(angle(H)) * 180/pi;

figure;
subplot(2,1,1);
plot(f, mag_dB); grid on;
title('پاسخ فرکانسی فیلتر FIR (پنجره بلک من)');
xlabel('Hz'); ylabel('dB');
xlim([0 Fs/2]);
line([Fpass Fpass], [-100 10], 'Color','r','LineStyle','--');
line([Fstop Fstop], [-100 10], 'Color','r','LineStyle','--');
legend('بهره', 'Fpass', 'Fstop');

subplot(2,1,2);
plot(f, phase_deg); grid on;
xlabel('Hz'); ylabel('فاز (درجه)');
xlim([0 Fs/2]);


%% A03
clear; close all; clc;

fs = 1000;           % فرکانس نمونه‌برداری (Hz)
f0 = 50;             % فرکانس سیگنال (Hz)
t = 0:1/fs:1-1/fs;   % طول 1 ثانیه
x = sin(2*pi*f0*t);

% DFT با پنجره مستطیلی (بدون ضرب در پنجره)
X = fft(x);
N = length(x);
f = (0:N-1)*(fs/N);

% نمایش طیف
figure;
stem(f(1:N/2), abs(X(1:N/2)));
xlabel('فرکانس (Hz)'); ylabel('دامنه');
title('طیف سیگنال سینوسی 50Hz – پنجره مستطیلی');
grid on;

%% A04
clc; clear; close all;

fs = 1000;           % فرکانس نمونه‌برداری (Hz)
f0 = 50;             % فرکانس سیگنال (Hz)
t = 0:1/fs:1-1/fs;   % طول 1 ثانیه
x = sin(2*pi*f0*t);

N = length(x);
f = (0:N-1)*(fs/N);

% پنجره هانینگ
win_hann = hann(length(x))';
x_hann = x .* win_hann;
X_hann = fft(x_hann);

% پنجره مستطیلی (همان x)
X_rect = fft(x);

figure;
subplot(2,1,1);
stem(f(1:N/2), abs(X_rect(1:N/2)), 'b');
title('پنجره مستطیلی'); ylabel('دامنه');
subplot(2,1,2);
stem(f(1:N/2), abs(X_hann(1:N/2)), 'r');
title('پنجره هانینگ'); xlabel('فرکانس (Hz)'); ylabel('دامنه');

%% A05
clear; close all; clc;

fs = 1000;           % فرکانس نمونه‌برداری (Hz)
f0 = 50;             % فرکانس سیگنال (Hz)
t = 0:1/fs:1-1/fs;   % طول 1 ثانیه
x = sin(2*pi*f0*t);

N = length(x);
f = (0:N-1)*(fs/N);

beta_vals = [2 5 10 15];
figure;
for i = 1:4
    win = kaiser(N, beta_vals(i));
    x_win = x .* win';
    X_win = fft(x_win);
    subplot(4,1,i);
    plot(f(1:N/2), 20*log10(abs(X_win(1:N/2))));
    title(['\beta = ' num2str(beta_vals(i))]);
    ylabel('dB'); grid on;
end
xlabel('فرکانس (Hz)');

%% A06
clear; close all; clc;

fs = 1000; 
t = 0:1/fs:1-1/fs;
f0 = 45.5;
x = sin(2*pi*f0*t);
N = length(x);
f = (0:N-1)*(fs/N);

windows = {rectwin(N), hann(N), hamming(N), kaiser(N,5)};
names = {'مستطیلی', 'هانینگ', 'همینگ', 'kaiser (\beta=5)'};

figure;
for i = 1:4
    xw = x .* windows{i}';
    Xw = fft(xw);
    subplot(2,2,i);
    plot(f(1:N/2), 20*log10(abs(Xw(1:N/2))));
    title(names{i}); xlabel('Hz'); ylabel('dB');
    grid on;
end

%% A07
clear; close all; clc;

% خواندن فایل صوتی
[original, Fs] = audioread('song.mp3');
if size(original,2) > 1
    original = mean(original,2);   % تبدیل به مونو
end

% انتخاب ۳ ثانیه اول برای سرعت
duration = 30;
N_samples = min(length(original), duration*Fs);
x = original(1:N_samples);

% مشخصات فیلتر
Fpass = 2000;   % فرکانس باند عبور (Hz)
Fstop = 2500;   % فرکانس باند توقف (Hz)
Fs = Fs;        % فرکانس نمونه‌برداری
Rp = 0.005;     % ریپل باند عبور (خطی)
Rs = 0.005;     % ریپل باند توقف (خطی)

% تخمین مرتبه فیلتر
[N, Wn, beta, ftype] = kaiserord([Fpass Fstop], [1 0], [Rp Rs], Fs);
N = N + mod(N,2);  % مرتبه زوج برای فاز خطی

% تعریف پنجره‌های مختلف
windows = {'rectwin', 'hamming', 'blackman', 'kaiser'};
params = {[], [], [], beta};  % پارامتر β فقط برای کیسر
colors = {'b', 'g', 'r', 'm'};
legend_str = {};

figure_grpdelay = figure;

for i = 1:length(windows)
    % ساخت پنجره
    switch windows{i}
        case 'rectwin'
            win = rectwin(N+1);
        case 'hamming'
            win = hamming(N+1);
        case 'blackman'
            win = blackman(N+1);
        case 'kaiser'
            win = kaiser(N+1, params{i});
    end
    
    % طراحی فیلتر
    b = fir1(N, Wn, ftype, win);
    coeffs{i} = b;

    % محاسبه و رسم تاخیر گروه
    [gd, w] = grpdelay(b, 1, 1024);
    f_gd = w * (Fs/(2*pi));  % تبدیل به Hz
    
    figure(figure_grpdelay);
    subplot(2,2,i);
    plot(f_gd, gd, colors{i}, 'LineWidth', 1.5);
    grid on;
    xlabel('فرکانس (Hz)'); ylabel('تاخیر گروه (نمونه)');
    title(sprintf('تاخیر گروه - پنجره %s', windows{i}));
    xlim([0 Fs/2]);

end


% پخش سیگنال اصلی
disp('پخش سیگنال اصلی...');
player_orig = audioplayer(x, Fs);
play(player_orig);
pause(length(x)/Fs + 1);

% پخش سیگنال‌های فیلتر شده
for i = 1:length(windows)
    b = coeffs{i};
    y_filtered = filter(b, 1, x);

    disp(['پخش سیگنال فیلتر شده با پنجره ' windows{i} '...']);
    player_filt = audioplayer(y_filtered, Fs);
    play(player_filt);
    pause(length(y_filtered)/Fs + 1);
end

%% A08
clear; close all; clc;

fs = 2000;
t = 0:1/fs:2;
x = [sin(2*pi*200*t(t<1)), sin(2*pi*800*t(t>=1))];
figure;
spectrogram(x, hamming(256), 200, 512, fs, 'yaxis');
title('STFT سیگنال با دو فرکانس');

%% A09

% Num -> fdatool: FIR, LOWPASS, HAMMING, Fs=1000, Fc=100
fs=1000;
t = 0:1/fs:1;

x = randn(size(t));

% اعمال فیلتر FIR
y = filter(Num, 1, x);

% رسم سیگنال ها
figure;
subplot(2,1,1);
plot(t, x);
title('سیگنال اصلی (تصادفی)');
xlabel('زمان (ثانیه)'); ylabel('دامنه');

subplot(2,1,2);
plot(t, y);
title('سیگنال فیلتر شده');
xlabel('زمان (ثانیه)'); ylabel('دامنه');

%% A10
% Num -> fdatool: FIR, BANDPASS, Fs=5000, Fc=1000,2000

fs=5000;

t = 0:1/fs:0.1;

f0 = 500;
f1 = 1500;
f2 = 2300;

noise = 0.5 * rand(size(t));
x = sin(2*pi*f0*t) + 3*cos(2*pi*f1*t) + sin(2*pi*f2*t) + noise;

% اعمال فیلتر FIR
y = filter(Num, 1, x);

% رسم سیگنال ها
figure;
subplot(2,1,1);
plot(t, x);
title('سیگنال اصلی');
xlabel('زمان (ثانیه)'); ylabel('دامنه');

subplot(2,1,2);
plot(t, y);
title('سیگنال فیلتر شده');
xlabel('زمان (ثانیه)'); ylabel('دامنه');

X = fft(x);
Y = fft(y);
N = length(x);
f = (0:N-1)*(fs/N);

% نمایش طیف
figure;
subplot(2,1,1);
stem(f(1:N/2), abs(X(1:N/2)));
xlabel('فرکانس (Hz)'); ylabel('دامنه');
title('طیف فرکانسی سیگنال اصلی');
grid on;

subplot(2,1,2);
stem(f(1:N/2), abs(Y(1:N/2)));
xlabel('فرکانس (Hz)'); ylabel('دامنه');
title('طیف فرکانسی سیگنال فیلتر شده');
grid on;
