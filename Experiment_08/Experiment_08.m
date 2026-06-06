%% A01
clc; clear; close all;
image_url = "image/pexels-alessandro-oliverio-611273-1472443.jpg";
a = imread(image_url);

whos a

figure;
imshow(a);

figure;
imhist(a);

%% A02
clc; clear; close all;
image_url = "image/pexels-nicolas-foster-65973708-36673239.jpg";
b = imread(image_url);

whos b

figure;
imshow(b);

figure;
imhist(b);
%% A03


%% A04
clc; clear; close all;
image_url = "image/pexels-dpsinghbhullar-29277520.jpg";
c = imread(image_url);
r = c(:,:,1);
g = c(:,:,2);
b = c(:,:,3);

figure;
imshow(c);
title("Main picture");

figure;
imhist(c);
title("Main picture");

figure;
imshow(r);
title("R picture");
figure;
imhist(r);
title("R picture");


figure;
imshow(g);
title("G picture");
figure;
imhist(g);
title("G picture");


figure;
imshow(b);
title("B picture");
figure;
imhist(b);
title("B picture");

%% A05

%% A06

%% A07

%% A08

%% A09

%% A10

