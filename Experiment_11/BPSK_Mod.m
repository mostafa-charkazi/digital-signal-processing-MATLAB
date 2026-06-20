function [t, s, m] = BPSK_Mod(bits, fc, Rb, Fs, A)

    Tb = 1/Rb;
    Ns = round(Fs * Tb);
    Nbits = length(bits);

    total_samples = Nbits * Ns;
    t = (0:total_samples-1) / Fs;

    % بیت 1 -> +1
    % بیت 0 -> -1
    symbols = 2*bits - 1;

    m = repelem(symbols, Ns);

    carrier = cos(2*pi*fc*t);

    s = A * m .* carrier;

end
