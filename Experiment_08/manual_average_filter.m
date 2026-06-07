function out_img = manual_average_filter(in_img, k_size)
    [rows, cols] = size(in_img);
    out_img = zeros(rows, cols);
    
    pad = floor(k_size / 2);
    
    padded_img = zeros(rows + 2*pad, cols + 2*pad);
    padded_img(pad+1:end-pad, pad+1:end-pad) = in_img;
    
    weight = 1 / (k_size * k_size);
    
    for i = 1:rows
        for j = 1:cols
            window = padded_img(i : i + k_size - 1, j : j + k_size - 1);
            
            pixel_sum = 0;
            for m = 1:k_size
                for n = 1:k_size
                    pixel_sum = pixel_sum + window(m, n) * weight;
                end
            end
            
            out_img(i, j) = pixel_sum;
        end
    end
end