%% A01
clc; clear; close all;
image_url = "files/image1.tif";
a = imread(image_url);

whos a

figure;
imshow(a);

figure;
imhist(a);

%% A02
clc; clear; close all;
image_url = "files/image2.tif";
b = imread(image_url);

whos b

figure;
imshow(b);

figure;
imhist(b);
%% A03
clc; clear; close all;

image_url = "files/image2.tif";
img2 = imread(image_url);
img2_double = double(img2);

x_min = min(img2_double(:));
x_max = max(img2_double(:));

% Method a: calculating image_stretch using y=ax+b


a = 255 / (x_max - x_min);
b = - a * x_min;
img2_stretch = a * img2_double + b;
img2_stretch = uint8(img2_stretch);

% for better histogram equalization:
% img2_stretch = uint8((double(img2_double)-121)*255/(184-121));

% Method b: Histogram equalization
img2_histeq = histeq(img2);

% Display results
figure('Name', 'Activity 3 - Enhancement');
subplot(1,3,1); imshow(img2); title('Original');
subplot(1,3,2); imshow(img2_stretch); title('Linear Stretch');
subplot(1,3,3); imshow(img2_histeq); title('Histogram Equalization');

figure('Name', 'Activity 3 - Histograms after enhancement');
subplot(3,1,1); imhist(img2); title('Histogram Original');
subplot(3,1,2); imhist(img2_stretch); title('Stretched Histogram');
subplot(3,1,3); imhist(img2_histeq); title('Equalized Histogram');

%% A04
clc; clear; close all;
image_url = "files/image3.png";

a = imread(image_url);
r = a(:,:,1);
g = a(:,:,2);
b = a(:,:,3);

figure;
subplot(2,1,1); imshow(a); title("Main picture");
subplot(2,1,2); imhist(a); title("Main picture Hist");

figure;
subplot(2,1,1); imshow(r); title("R picture");
subplot(2,1,2); imhist(r); title("R picture Hist");


figure;
subplot(2,1,1); imshow(g); title("G picture");
subplot(2,1,2); imhist(g); title("G picture");


figure;
subplot(2,1,1); imshow(b); title("B picture");
subplot(2,1,2); imhist(b); title("B picture");

%% A05
clc; clear; close all;

image_url = "files/image1.tif";
img1 = imread(image_url);

% Resize to 100x100 using default bicubic interpolation
img_resized = imresize(img1, [100, 100], 'bilinear');
% 'nearest', 'bilinear', 'bicubic'

% Display results
figure('Name', 'Activity 5 - Image Resizing');
subplot(1,2,1);
imshow(img1);
title(['Original: ', num2str(size(img1,1)), 'x', num2str(size(img1,2))]);

subplot(1,2,2);
imshow(img_resized);
title(['Resized: ', num2str(size(img_resized,1)), 'x', num2str(size(img_resized,2))]);
%% A06
clear; close all; clc;

image_url = "files/image1.tif";
img1 = imread(image_url);

rot_30 = imrotate(img1, 30);
rot_45 = imrotate(img1, 45);
rot_90 = imrotate(img1, 90);
rot_180 = imrotate(img1, 180);

% Display results
figure;
subplot(1,5,1); imshow(img1); title('Original');
subplot(1,5,2); imshow(rot_30); title('Rotate 30°');
subplot(1,5,3); imshow(rot_45); title('Rotate 45°');
subplot(1,5,4); imshow(rot_90); title('Rotate 90°');
subplot(1,5,5); imshow(rot_180); title('Rotate 180°');
%% A07
clc; clear; close all;

image_url = "files/image4.jpg";
img4 = imread(image_url);

figure;
subplot(1,2,1); imshow(img4); title("Image Before threshold");
subplot(1,2,2); imhist(img4); title("Histogram Before threshold");


threshold_val = 0.5;
img_bin = (img4 > threshold_val) * 255;
figure;
subplot(1,2,1); imshow(img_bin); title("Image After threshold");
subplot(1,2,2); imhist(img_bin); title("Histogram After threshold");

img_disks = imopen(img_bin, strel('disk',6));
[~,numCC] = bwlabel(img_disks,8);
disp(['Number of cirles: ', num2str(numCC)])
figure; imshow(img_disks);


linDeg0 = imopen(img_bin,strel('line',60,0)); 
linDeg10 = imopen(img_bin,strel('line',60,10));
linDeg20 = imopen(img_bin,strel('line',60,20));
linDeg75 = imopen(img_bin,strel('line',60,75));
linDeg95 = imopen(img_bin,strel('line',40,95));
linDeg135 = imopen(img_bin,strel('line',60,135));
linDeg170 = imopen(img_bin,strel('line',60,170));

img_lines = linDeg0 | linDeg10 | linDeg20 | linDeg75 | linDeg95 | linDeg135 | linDeg170;
figure; imshow(img_lines);

img_final = img_lines | img_disks;
figure; imshow(img_final);
%% A08
clc; clear; close all;

img = imread('files/image6.tif'); 

if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

img_gray = im2double(img_gray); 

output_3x3 = manual_average_filter(img_gray, 3);
output_5x5 = manual_average_filter(img_gray, 5);
output_7x7 = manual_average_filter(img_gray, 7);
output_11x11 = manual_average_filter(img_gray, 11);

figure; imshow(img_gray); title('Original Grayscale Image');
figure;
subplot(2,2,1); imshow(output_3x3); title('Filtered Image (3x3 Manual)');
subplot(2,2,2); imshow(output_5x5); title('Filtered Image (5x5 Manual)');
subplot(2,2,3); imshow(output_7x7); title('Filtered Image (7x7 Manual)');
subplot(2,2,4); imshow(output_11x11); title('Filtered Image (11x11 Manual)');

%% A09
clc; clear; close all;

[img, map] = imread('files/image7.png');
if ~isempty(map)
    img = ind2rgb(img, map);
end
img = im2double(img);

figure;
imshow(img);
title('Original Color Image');

noise_density = [0.002 0.005 0.01, 0.05];

for n = 1:length(noise_density)

    noisy_img = imnoise(img, 'salt & pepper', noise_density(n));
    
    R_channel = noisy_img(:,:,1);
    G_channel = noisy_img(:,:,2);
    B_channel = noisy_img(:,:,3);
    
    % Define the filters using fspecial
    h_average   = fspecial('average', [3 3]);
    h_disk      = fspecial('disk', 3);
    h_gaussian  = fspecial('gaussian', [5 5], 1);
    h_laplacian = fspecial('laplacian', 0.2);
    h_log       = fspecial('log', [5 5], 0.5);
    h_motion    = fspecial('motion', 10, 45);
    h_prewitt   = fspecial('prewitt');
    h_sobel     = fspecial('sobel');
    
    f_average = cat(3, filter2(h_average, R_channel, 'same'), ...
                       filter2(h_average, G_channel, 'same'), ...
                       filter2(h_average, B_channel, 'same'));
                   
    f_disk = cat(3, filter2(h_disk, R_channel, 'same'), ...
                    filter2(h_disk, G_channel, 'same'), ...
                    filter2(h_disk, B_channel, 'same'));
                
    f_gaussian = cat(3, filter2(h_gaussian, R_channel, 'same'), ...
                        filter2(h_gaussian, G_channel, 'same'), ...
                        filter2(h_gaussian, B_channel, 'same'));
                    
    f_laplacian = cat(3, filter2(h_laplacian, R_channel, 'same'), ...
                         filter2(h_laplacian, G_channel, 'same'), ...
                         filter2(h_laplacian, B_channel, 'same'));
                     
    f_log = cat(3, filter2(h_log, R_channel, 'same'), ...
                   filter2(h_log, G_channel, 'same'), ...
                   filter2(h_log, B_channel, 'same'));
               
    f_motion = cat(3, filter2(h_motion, R_channel, 'same'), ...
                      filter2(h_motion, G_channel, 'same'), ...
                      filter2(h_motion, B_channel, 'same'));
                  
    f_prewitt = cat(3, filter2(h_prewitt, R_channel, 'same'), ...
                       filter2(h_prewitt, G_channel, 'same'), ...
                       filter2(h_prewitt, B_channel, 'same'));
                   
    f_sobel = cat(3, filter2(h_sobel, R_channel, 'same'), ...
                     filter2(h_sobel, G_channel, 'same'), ...
                     filter2(h_sobel, B_channel, 'same'));


    figure;
    subplot(3,3,1); imshow(noisy_img);   title(['Noisy Image ', num2str(noise_density(n) * 100) , '%']);
    subplot(3,3,2); imshow(f_average);   title('Average Filter');
    subplot(3,3,3); imshow(f_disk);      title('Disk Filter');
    subplot(3,3,4); imshow(f_gaussian);  title('Gaussian Filter');
    subplot(3,3,5); imshow(f_laplacian); title('Laplacian Filter');
    subplot(3,3,6); imshow(f_log);       title('LoG Filter');
    subplot(3,3,7); imshow(f_motion);    title('Motion Blur');
    subplot(3,3,8); imshow(f_prewitt);   title('Prewitt Filter');
    subplot(3,3,9); imshow(f_sobel);     title('Sobel Filter');

end
%% A10
clear; close all; clc;

image_url = "files/image7.png";

[img7,map] = imread('files/image7.png');
img7 = ind2rgb(img7,map);
img7 = im2double(img7);
img_gray = rgb2gray(img7);

% Convert to double for accurate gradient calculations
img_double = double(img_gray);

% Prewitt masks
Prewitt_vert = [-1 0 1; -1 0 1; -1 0 1];
Prewitt_horiz = [-1 -1 -1; 0 0 0; 1 1 1];

% Sobel masks
Sobel_vert = [-1 0 1; -2 0 2; -1 0 1];
Sobel_horiz = [-1 -2 -1; 0 0 0; 1 2 1];

Gx_prew = conv2(img_double, Prewitt_vert, 'same');
Gy_prew = conv2(img_double, Prewitt_horiz, 'same');
G_prew = sqrt(Gx_prew.^2 + Gy_prew.^2);

Gx_sob = conv2(img_double, Sobel_vert, 'same');
Gy_sob = conv2(img_double, Sobel_horiz, 'same');
G_sob = sqrt(Gx_sob.^2 + Gy_sob.^2);

% Display Prewitt Results
figure('Name', 'Prewitt Edge Detection');
subplot(2,2,1); imshow(img7); title('Original');
subplot(2,2,2); imshow(mat2gray(Gx_prew)); title('Vertical Edges (Gx)');
subplot(2,2,3); imshow(mat2gray(Gy_prew)); title('Horizontal Edges (Gy)');
subplot(2,2,4); imshow(mat2gray(G_prew)); title('Total Gradient (G)');

% Display Sobel Results
figure('Name', 'Sobel Edge Detection');
subplot(2,2,1); imshow(img7); title('Original');
subplot(2,2,2); imshow(mat2gray(Gx_sob)); title('Vertical Edges (Gx)');
subplot(2,2,3); imshow(mat2gray(Gy_sob)); title('Horizontal Edges (Gy)');
subplot(2,2,4); imshow(mat2gray(G_sob)); title('Total Gradient (G)');
