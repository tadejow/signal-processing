function [LL, LH, HL, HH] = dwt2(X, h, g)

% Perform 1D DWT on rows
X = conv2(X, h, 'same');
LL = X(:, 1:2:end);
LH = X(:, 2:2:end);

% Perform 1D DWT on columns
LL = conv2(LL, h', 'same');
HL = conv2(HL, g', 'same');
LH = conv2(LH, h', 'same');
HH = conv2(HH, g', 'same');

% Subsample coefficients
LL = LL(1:2:end, 1:2:end);
HL = HL(1:2:end, 1:2:end);
LH = LH(1:2:end, 1:2:end);
HH = HH(1:2:end, 1:2:end);

end
