function [p] =calc_ranksum(signal, control_range, test_range)

control = signal(control_range(1):control_range(2));
test = signal(test_range(1):test_range(2));

p = ranksum(control', test');
