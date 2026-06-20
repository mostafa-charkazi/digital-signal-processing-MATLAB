function bits_hat = ASK_Demod(r, fc, Rb, Fs)

    Tb = 1/Rb;
    Ns = round(Fs * Tb);
    Nbits = floor(length(r) / Ns);

    bits_hat = zeros(1, Nbits);

    for k = 1:Nbits
        idx = (k-1)*Ns + 1 : k*Ns;
        t_bit = (0:Ns-1) / Fs;
        carrier = cos(2*pi*fc*t_bit);
        z = sum(r(idx) .* carrier);

        if z > Ns/4
            bits_hat(k) = 1;
        else
            bits_hat(k) = 0;
        end
    end
end