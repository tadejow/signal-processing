Boat = double(imread('Boat.gif')); % 512x512

mask = 1/159 * [2  4  5  4 2;
                4  9 12  9 4;
                5 12 15 12 5;
                4  9 12  9 4;
                2  4  5  4 2];

%pętla dodana na lab5.1
for i=1:10
	Boat = conv2(Boat, mask, 'same');
end;
%figure(1); colormap(gray(256)); image(Boat)

%figure(2); colormap(gray(256)); image(image_after_conv)

%Algorytm canny
table_x = [-1 0 1;
           -2 0 2;
           -1 0 1]; %maska Previta
table_y = table_x';
gradient_x = conv2(Boat, table_x, 'same');
gradient_y = conv2(Boat, table_y, 'same');
modules = sqrt(gradient_x.^2 + gradient_y.^2);
T = angle(complex(gradient_x, gradient_y));
%figure(3); colormap(gray(256)); image(100*(T + pi))
%figure(3.1); colormap(gray(256)); image(modules)
for i=1:512
    for j=1:512
        if abs(T(i,j))<=pi/8 || abs(T(i,j))>=7*pi/8
            T(i,j)=1;
		  elseif T(i,j)>=5*pi/8 || (T(i,j)>=-3*pi/8 && T(i,j)<0)
				T(i,j)=2;
		  elseif T(i,j)>=3*pi/8 || (T(i,j)>=-5*pi/8 && T(i,j)<0)
				T(i,j)=3;
		  else
				T(i,j)=4;
		  endif;
	endfor;
endfor;
	 

%figure(4); colormap(gray(256)); image(50*T)

%znajdujemy maksima w kierunku gradientów
G = modules;
Gt = zeros(512);
for i=2:511
    for j=2:511
        if T(i,j) == 1
            a = G(i,j-1); b = G(i, j+1);
        else
            if T(i,j) == 2
                a = G(i-1,j-1); b = G(i+1, j+1);
            else
                if T(i,j) == 3
                    a = G(i-1,j); b = G(i+1, j);
                else
                    a = G(i+1,j-1); b = G(i-1, j+1);
                end;
            end;
        end;
        if a <= G(i,j) && b <= G(i,j)
            Gt(i,j)=G(i,j);
        end;
    end;
end;
%figure(6); colormap(gray(256)); image(2*Gt) %mozna zwiekszyc wartosc Gt aby było wiecej widac

%od tego miejsca mamy lab5.1
thresh_high = 30;
Edges = zeros(512);
for i=1:512
	for j=1:512
		if Gt(i,j)>thresh_high
			Edges(i,j)=255;
		endif;
	endfor;
endfor;
figure(7); colormap(gray(256)); image(Edges)

%od tego miejsca mamy lab6
F = Edges;
thresh_low = 5;
for k=1:20
	for i=2:511
		 for j=2:511
			  if Edges(i,j) == 255
				if T(i,j)== 1
					i1 = i-1;
					i2 = i+1;
					j1=j;
					j2=j;
				elseif T(i,j)==2
					i1 = i-1;
					i2 = i+1;
					j1=j+1;
					j2=j-1;
				elseif T(i,j)==3
					i1 = i;
					i2 = i;
					j1=j-1;
					j2=j+1;
				else
					i1 = i-1;
					i2 = i+1;
					j1=j-1;
					j2=j+1;
			  endif
			  if Gt(i1,j1)>thresh_low || Gt(i2,j2)>thresh_low
				Edges(i1,j1)=127;  
			  endif
		  endif
	  endfor
	endfor
endfor
Edges(Edges==127)=255;
figure(8); colormap(gray(256)); image(Edges)	  


