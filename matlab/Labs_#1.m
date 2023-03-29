% Zapisanie obrazka w postaci macierzy:

lena = imread('Lena.gif', 'gif'); % Save a file in variable 'lena';
[lena, map] = imread('Lena.gif', 'gif'); % Variable map saves a colormap of the image;

figure(1); colormap(map); image(lena) %Allows multiple plots; Set colormap; Show the image

lena = double(lena); % Usually it's required to have double format instead of int's
lena_fft = fft2(b); % Fourier Transform of the image
lena_fft_abs = uint8(abs(c)/20); % Module of FT
figure(2); colormap(map); image(lena_fft)
figure(3); colormap(map); image(lena_fft_abs)
%colormap(map)
%e = fftshift(d); % przesuwa obszary bieli, utworzył się torus
%image(e)