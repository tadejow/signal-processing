% Zapisanie obrazka w postaci macierzy:

lena = imread('Lena.gif', 'gif'); % Save a file in variable 'lena';
[lena, map] = imread('Lena.gif', 'gif'); % Variable map saves a colormap of the image;

figure(1); colormap(map); image(lena) %Allows multiple plots; Set colormap; Show the image

lena = double(lena); % Usually it's required to have double format instead of int's
lena_fft = fft2(lena); % Fourier Transform of the image
lena_fft_abs = uint8(abs(lena_fft)/20); % Module of FT
%figure(2); colormap(map); image(lena_fft) % Doesn't work due to complex values
figure(3); colormap(map); image(lena_fft_abs)
lena_fft_shifted = fftshift(lena_fft_abs); % Shifts white areas, important frequencies are in center
figure(4); colormap(map); image(lena_fft_shifted)
