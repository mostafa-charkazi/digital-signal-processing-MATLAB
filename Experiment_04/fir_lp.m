function h = fir_lp(omega_c, N)
    n = 0:N;
    center = N/2;
    h = sin(omega_c * (n - center)) ./ (pi * (n - center));
    
    % zero dev: n = center
    h(center+1) = omega_c / pi;
end
