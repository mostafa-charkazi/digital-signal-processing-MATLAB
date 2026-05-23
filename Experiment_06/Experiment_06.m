%% A02
clc; clear; close all;

fs = 40000; fp = 4000; fst = 8000; Rp = 0.5; Rs = 40;
Wp = fp / (fs/2); Ws = fst / (fs/2);

% 1. باترورث
[N_but, Wn_but] = buttord(Wp, Ws, Rp, Rs);
fprintf('باترورث: N = %d, Wn = %.4f\n', N_but, Wn_but);

% 2. چبی‌شف نوع 1 (ریپل در باند عبور)
[N_ch1, Wn_ch1] = cheb1ord(Wp, Ws, Rp, Rs);
fprintf('چبی‌شف نوع 1: N = %d, Wn = %.4f\n', N_ch1, Wn_ch1);

% 3. چبی‌شف نوع 2 (ریپل در باند توقف)
[N_ch2, Wn_ch2] = cheb2ord(Wp, Ws, Rp, Rs);
fprintf('چبی‌شف نوع 2: N = %d, Wn = %.4f\n', N_ch2, Wn_ch2);

% 4. بیضوی (الپتیک)
[N_ell, Wn_ell] = ellipord(Wp, Ws, Rp, Rs);
fprintf('بیضوی: N = %d, Wn = %.4f\n', N_ell, Wn_ell);


%% A04
clc; clear; close all;

fs = 3500; wp = 1050; ws = 600; Rp = 1; Rs = 50;
Wp_norm = wp / (fs/2); Ws_norm = ws / (fs/2);

[N, Wn] = cheb2ord(Wp_norm, Ws_norm, Rp, Rs);
disp(['Order: ', num2str(N)]);
disp(['Wn: ', num2str(Wn)]);

% Design high-pass filter
[num, den] = cheby2(N, Rs, Wn, 'high');

% پاسخ فرکانسی
[H, w] = freqz(num, den, 1024, fs);

% رسم پاسخ دامنه (بر حسب dB)
figure;
subplot(2,1,1);
plot(w, 20*log10(abs(H)), 'b', 'LineWidth', 1.5);
grid on;
xlabel('فرکانس (Hz)');
ylabel('بهره (dB)');
title('پاسخ دامنه فیلتر بالاگذر چبی‌شف نوع 2');

hold on;
plot([ws ws], [-60 5], 'r--', 'LineWidth', 1);
plot([wp wp], [-60 5], 'g--', 'LineWidth', 1);
legend('پاسخ فیلتر', 'لبه باند توقف (600 Hz)', 'لبه باند عبور (1050 Hz)');

% رسم پاسخ فاز
subplot(2,1,2);
plot(w, unwrap(angle(H))*180/pi, 'b', 'LineWidth', 1.5);
grid on;
xlabel('فرکانس (Hz)');
ylabel('فاز (درجه)');
title('پاسخ فاز فیلتر');

% رسم قطب و صفرها
figure;
zplane(num, den);
title('نمودار قطب و صفر فیلتر بالاگذر چبی‌شف نوع 2');

% بررسی پایداری
poles = roots(den);
if all(abs(poles) < 1)
    disp('فیلتر پایدار است (همه قطب‌ها درون دایره واحد).');
else
    disp('هشدار: فیلتر ناپایدار است!');
end