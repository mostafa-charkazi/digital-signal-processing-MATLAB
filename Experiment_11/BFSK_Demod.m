function bits_hat = BFSK_Demod(r, f0, f1, Rb, Fs)

    Tb = 1/Rb;
    Ns = round(Fs * Tb);
    Nbits = floor(length(r) / Ns);

    bits_hat = zeros(1, Nbits);

    for k = 1:Nbits
        idx = (k-1)*Ns + 1 : k*Ns;
        t_bit = (0:Ns-1) / Fs;

        c0 = cos(2*pi*f0*t_bit);
        c1 = cos(2*pi*f1*t_bit);

        % محاسبه همبستگی با هر دو فرکانس
        z0 = sum(r(idx) .* c0);
        z1 = sum(r(idx) .* c1);

        if z1 > z0
            bits_hat(k) = 1;
        else
            bits_hat(k) = 0;
        end
    end

end
