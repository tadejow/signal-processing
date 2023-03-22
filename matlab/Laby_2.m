Lena = imread('Boat.gif');
%Text = imread('Text.gif');
Lena = double(Lena);
%Text = double(Text);
Lena_fft = fft2(Lena);
%Text_fft = fft2(Text);
%image(abs(Lena_fft)/20);
%image(abs(Text_fft)/20);
Lena_fft_shifted = fftshift(Lena_fft);
%Text_fft_shifted = fftshift(Text_fft);
%image(abs(Lena_fft_shifted)/20);
colormap(gray(256));
%image((pi + angle(Lena_fft_shifted))*128/pi);

%Maskowanie
mask = zeros(512);
mask(193:321, 193:321) = 1;
%image(mask*100);

Lena_shifted_masked = Lena_fft_shifted .* mask;
Lena_masked = ifftshift(Lena_shifted_masked);

Lena_128x128 = ifft2(Lena_masked);
%image(Lena_128x128)

%Progowanie
delta = sum(sum(abs(Lena_fft)))/(512*512)/2;
for i=1:512
    for j=1:512
        if (abs(Lena_fft(i,j)))<delta
            Lena_fft(i,j) = 0;
        end;
    end;
end;

Lena_prog = ifft2(Lena_fft);
image(Lena_prog)

