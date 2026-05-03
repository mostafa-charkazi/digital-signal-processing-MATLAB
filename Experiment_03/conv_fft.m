function y = conv_fft(x, h)
    Nx = length(x);
    Nh = length(h);
    N = Nx + Nh - 1;  % طول مورد نیاز برای کانولوشن خطی
    
    % FFT با صفرپردازی
    X = fft(x, N);
    H = fft(h, N);
    
    % ضرب در فرکانس
    Y = X .* H;
    
    % تبدیل معکوس
    y = ifft(Y, N);
    y = real(y);
end