clear; clc;
input_im = imread('data/input_17.JPG');
input_im_red = input_im(:,:,1);
input_im_green = input_im(:,:,2);
input_im_blue = input_im(:,:,3);

% otsu method
r_thresh = graythresh(input_im_red);
g_thresh = graythresh(input_im_green);
b_thresh = graythresh(input_im_blue);

r_bw = imbinarize(input_im_red, r_thresh);
g_bw = imbinarize(input_im_green, g_thresh);
b_bw = imbinarize(input_im_blue, b_thresh);


bw = r_bw .* g_bw .* b_bw;
imshow(bw);

% Need to find out what the best window size is..medfilt2 is taking too
% long i can't have it run for every image.. especially when only a couple
% of images really need it.
%g = medfilt2(bw, [27 27]);
g = imgaussfilt(bw, 40);
figure;
imshow(g);
g_thresh = graythresh(g);
g_bw = imbinarize(g, g_thresh);
figure;
imshow(g_bw);