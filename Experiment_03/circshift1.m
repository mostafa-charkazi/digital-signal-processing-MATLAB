function y = circshift1(x, m)
    % circshift1: شیفت چرخشی سیگنال
    % x: بردار ورودی
    % m: مقدار شیفت
    N = length(x);
    m = mod(m, N);
    if m == 0
        y = x;
    else
        y = [x(N-m+1:end), x(1:N-m)];
    end
end