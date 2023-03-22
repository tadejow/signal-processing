Boat = double(imread('Boat.gif')); % 512x512
%Boat = imbinarize(double(imread('znak.png')/256)); % 688x547 
figure(1); colormap(gray(256)); image(Boat)

mask = 1/159 * [2  4  5  4 2;
                4  9 12  9 4;
                5 12 15 12 5;
                4  9 12  9 4;
                2  4  5  4 2];


%figure(1); colormap(gray(256)); image(Boat)

image_after_conv = conv2(Boat, mask, 'same');
Boat2 = image_after_conv;

figure(2); colormap(gray(256)); image(image_after_conv)

%Algorytm canny
table_x = [-1 0 1;
           -2 0 2;
           -1 0 1]; %maska Previta
table_y = table_x';
gradient_x = conv2(Boat2, table_x, 'same');
gradient_y = conv2(Boat2, table_y, 'same');
modules = sqrt(gradient_x.^2 + gradient_y.^2);
T = angle(gradient_x + i*gradient_y);
figure(3); colormap(gray(256)); image(100*(T + pi))

%figure(3); colormap(gray(256)); image(modules)


for i=1:512
    for j=1:512
        if abs(T(i,j))<=pi/8 || abs(T(i,j))>=7*pi/8
            T(i,j)=1;
        else
            if T(i,j)>=5*pi/8 || T(i,j)>=-3*pi/8
                T(i,j)=2;
            else
                if T(i,j)>=3*pi/8 || T(i,j)>=-5*pi/8
                    T(i,j)=3;
                else
                    T(i,j)=4;
                end;
            end;
        end;
    end;
end;
figure(4); colormap(gray(256)); image(50*T)

