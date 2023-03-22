Lena = double(imread('Lena.gif')); % 512x512
Text = double(imread('Text.gif')); % 256x256
Boat = double(imread('Boat.gif')); % 512x512

%Zaszumiamy rozkladem normalnym przemnożonym
Boat_noise = Boat + 100*randn(512);

colormap(gray(256));

%image(Boat_noise)

%wygładzanie obrazu
mask = 1/159 * [2  4  5  4 2;
                4  9 12  9 4;
                5 12 15 12 5;
                4  9 12  9 4;
                2  4  5  4 2];
            
convolution = conv2(Boat, mask);
convolution_noise = conv2(Boat_noise, mask);
%size(convolution) 516x516

%image(convolution);
%image(convolution_noise);

%wykrywanie krawedzi
[ca, ch, cv, cd] = dwt2(Boat, 'db2'); % [srednie,horizontal,vertical,diagonal]
%[cca, cch, ccv, ccd] = dwt2(ca, 'db45');
%image(ca)

%Algorytm canny
convolution2 = conv2(Boat, mask, 'same');
table_x = [-1 0 1;
           -2 0 2;
           -1 0 1]; %maska Previta
table_y = table_x';
gradient_x = conv2(Boat, table_x, 'same');
gradient_y = conv2(Boat, table_y, 'same');
modules = sqrt(gradient_x.^2 + gradient_y.^2);
%image(modules)

directions = zeros(size(gradients_x,1));
for i=1:512
    for j=1:512
        if gradient_x(i,j)==0;
            directions(i,j)=0;
        end;
    end;
end;

