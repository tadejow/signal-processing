clc
clear

prompt = "Insert a name of an image to convert:\n";
txt = input(prompt, 's');
name_of_img = strcat('.\Datasets\', txt);
img = double(imread(name_of_img, 'gif'));

n = size(img, 1);
e_high = 100;
e_low = 80;

mask = 1/159 * [2  4  5  4 2;
                4  9 12  9 4;
                5 12 15 12 5;
                4  9 12  9 4;
                2  4  5  4 2];
					 
for i=1:5
	img = conv2(img, mask, 'same');
endfor;	

Dx = [-1 0 1;
		-2 0 2;
		-1 0 1]; %maska Previta
Dy = Dx';
Gx = conv2(img, Dx, 'same');
Gy = conv2(img, Dy, 'same');
G = abs(complex(Gx, Gy));

name_to_write = strcat('.\Images\', txt, '-gradient.gif');
imwrite(uint8(255-G), name_to_write);
figure(1); colormap(gray(256)); image((255-G));	

T = angle(complex(Gx, Gy));
for i=1:n
	for j=1:n
		if T(i,j)<0
			T(i,j) = T(i,j) + pi;
		endif
		if abs(T(i,j))<=pi/8 || abs(T(i,j))>=7*pi/8
            T(i,j)=1;
		  elseif T(i,j)>=5*pi/8
				T(i,j)=2;
		  elseif T(i,j)>=3*pi/8
				T(i,j)=3;
		  else
				T(i,j)=4;
		endif
	endfor
endfor
	
Edges = zeros(n);

for i=2:(n-1)
	for j=2:(n-1)
		if T(i,j)==1
			u = 0;
			v = 1;
		elseif T(i,j)==4
			u = -1;
			v = 1;
		elseif T(i,j)==3
			u=1;
			v=0;
		else
			u=1;
			v=1;
		endif
		if (G(i,j)>=G(i+u,j+v)) && (G(i,j)>=G(i-u,j-v))
			Edges(i,j)= G(i,j);
		endif
	endfor
endfor
figure(2); colormap(gray(256)); image((255-Edges));

Edges(Edges>e_high)=255;
Edges(Edges<=e_high)=0;

name_to_write2 = strcat('.\Images\', txt, '-initial.gif');
imwrite(uint8(255-Edges), name_to_write2, 'gif');
for k=1:3
	E = Edges;
	for i=2:n-1
		for j=2:n-1
			for u=-1:1
				for r=-1:1
					if G(i+u,j+r)>=e_low
						E(i+u,j+r) = 255;
					endif
				endfor
			endfor
		endfor
	endfor
	Edges = E;
endfor

name_to_write3 = strcat('.\Images\', txt, '-final.gif');
imwrite(uint8(255-Edges), name_to_write3, 'gif');
figure(3); colormap(gray(256)); image((255-Edges));