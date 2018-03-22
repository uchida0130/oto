x = [1, -0.4, 0.16, -0.1];
h = myinvfilt(x, 60, 1, 0.002);
y = conv(h,x);

[M,Index] = max(y);
y(Index:Index+10)
Index

d = zeros(4+60-1,1);
d(1) = 1;

% error = sum(abs(y-d));