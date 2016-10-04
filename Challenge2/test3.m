%author: Carlos Rosario
clear; clc;

input_im = imread('data/input_16.JPG');
%input_im = rgb2gray(input_im);
input_im = input_im(:,:,3);
%input_im = sum((1-input_im).^2, 3) > .5; 

sobel_kernel_x = [1 0 -1; 2 0 -2; 1 0 -1] * (1/8);
sobel_kernel_y = [1 2 1; 0 0 0; -1 -2 -1] * (1/8);

% check kernel, x direction
sum_x = sum(sobel_kernel_x(:));

gx = imfilter(double(input_im), double(sobel_kernel_x)); % vertical edges
%imshow(gx, []); % smallest value to be black, and largest value to white
%colormap jet;

% check kernel, y direction
sum_y = sum(sobel_kernel_y(:));
gy = imfilter(double(input_im), double(sobel_kernel_y)); % horizontal edges
%imshow(gy, []);
%colormap jet;

% compute gradient magnitude
gm = sqrt((gx .^2) + (gy .^2));
%imshow(gm,[]);
%colormap jet;

gradient_angle = atan2(gy,gx); %angles in radian of each gx,gy.
%imshow(angle,[]);
%colormap jet;

tresh = 10;
binaryImage = zeros(size(input_im,1), size(input_im,2));
binaryImage = gm >= tresh;

% binary_im = ~binary_im;X
imshow(binaryImage, []);
%colormap jet;





