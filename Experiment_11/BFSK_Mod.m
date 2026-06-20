function [t, s, m] = BFSK_Mod(bits, f0, f1, Rb, Fs, A)

    Tb = 1/Rb;
    Ns = round(Fs * Tb);
    Nbits = length(bits);

    total_samples = Nbits * Ns;
    t = (0:total_samples-1) / Fs;

    m = repelem(bits, Ns);

    s = zeros(1, total_samples);

    for k = 1:Nbits
        idx = (k-1)*Ns + 1 : k*Ns;
        t_bit = (0:Ns-1) / Fs;

        if bits(k) == 1
            s(idx) = A * cos(2*pi*f1*t_bit);
        else
            s(idx) = A * cos(2*pi*f0*t_bit);
        end
    end

end

