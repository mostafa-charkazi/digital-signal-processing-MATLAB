function y_linear = linear_conv_using_circconv1(x, h)
    Nx = length(x);
    Nh = length(h);
    N = Nx + Nh - 1;  % طول مورد نیاز
    
    % صفرپردازی (Zero Padding)
    x_pad = [x, zeros(1, N - Nx)];
    h_pad = [h, zeros(1, N - Nh)];
    
    % کانولوشن چرخشی روی سیگنال‌های صفرپردازی شده
    y_circ = circconv1(x_pad, h_pad);
    y_linear = real(y_circ);  % حذف خطای عددی موهومی
end
