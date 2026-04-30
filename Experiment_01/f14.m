function [mean_value, var_value] = f14(signal)
    mean_value = mean(signal);
    var_value = var(signal);

    disp(['miangin: ' num2str(mean_value)]);
    disp(['variance: ' num2str(var_value)]);
end