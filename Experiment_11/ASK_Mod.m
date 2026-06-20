function [t, s, m] = ASK_Mod(bits, fc, Rb, Fs, A)

    Tb = 1/Rb;
    Ns = round(Fs * Tb);
    Nbits = length(bits);

    total_samples = Nbits * Ns;
    t = (0:total_samples-1) / Fs;

    m = repelem(bits, Ns);

    carrier = cos(2*pi*fc*t);
    
    s = A * m .* carrier;

end