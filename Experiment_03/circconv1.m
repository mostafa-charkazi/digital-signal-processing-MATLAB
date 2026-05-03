function y = circconv1(x, h)
    % circconv1: کانولوشن چرخشی دو سیگنال با طول مساوی
    % x, h: بردارهای ورودی با طول یکسان
    N = length(x);
    if length(h) ~= N
        error('طول دو سیگنال باید برابر باشد');
    end
    
    % روش 1
    X = fft(x, N);
    H = fft(h, N);
    y = ifft(X .* H, N);
    
    % روش 2
    % y = zeros(1, N);
    % for n = 1:N
    %     for m = 1:N
    %         idx = mod(n-m, N) + 1;
    %         y(n) = y(n) + x(m) * h(idx);
    %     end
    % end
end
