Boat = double(imread('Boat.gif')); % 512x512

mask = 1/159 * [2  4  5  4 2;
                4  9 12  9 4;
                5 12 15 12 5;
                4  9 12  9 4;
                2  4  5  4 2];

for i=1:100
	Boat = conv2(Boat, mask, 'same');
end;
figure(1); colormap(gray(256)); image(Boat);



