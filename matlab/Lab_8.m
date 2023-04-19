A = double(imread('Lena.gif'));
[CA, CH, CV, CD] = dwt2(A,'db4', 'mode', 'per');
B = zeros(size(A,1));
B(1:256,1:256) = CA;
B(1:256, 257:512) = CH;
B(257:512,1:256) = CV;
B(257:512, 257:512) = CD;
%figure(1); colormap(gray(256)); image(A);
%figure(2); colormap(gray(512)); image(B);
% próba inaczej ale to nie da się oglądać bo jest wektorem

% figure(3); colormap(gray(256)); image(C);
% powrót do poprzedniego sposobu
[DA, DH, DV, DD] = dwt2(CA, 'db4', 'mode', 'per');
%figure(2); colormap(gray(512)); image(CA);
%figure(3); colormap(gray(2*512)); image(DA);
[EA, EH, EV, ED] = dwt2(DA, 'db4', 'mode', 'per');
%figure(4); colormap(gray(4*512)); image(EA);
[FA, FH, FV, FD] = dwt2(EA, 'db4', 'mode', 'per');
%figure(5); colormap(gray(8*512)); image(FA);
[GA, GH, GV, GD] = dwt2(FA, 'db4', 'mode', 'per');
%figure(6); colormap(gray(16*512)); image(GA);

[C,S] = wavedec2(A, 9, 'db4');
n=size(C,1);
thresh=max(C)/15000; % thresh=max(C)/200;
k=sum(C<=thresh)/n;
C(C<=thresh)=0;
X = waverec2(C, S, 'db4');
image(X);

