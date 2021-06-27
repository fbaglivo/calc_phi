function [data_o] = norm_data(data)

infdata = isinf(data);
t = 1:numel(data);
data(infdata) = interp1(t(~infdata), data(~infdata), t(infdata))

data_o = (data - min(data)) / (max(data) - min(data));