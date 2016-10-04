
% blur image
input_im = imread('data/input_16.JPG');
input_im = rgb2gray(input_im);
%input_im = input_im(:,:,2) + input_im(:,:,1);
%imshow(input_im);
Iblur = imgaussfilt(input_im, 10);
%imshow(Iblur);


% edge detection


% or


% thresholding
bw = imbinarize(Iblur, 'adaptive', 'Sensitivity', 0.7);
imshow(bw);


% median filtering
% g = medfilt2(bw, [31 31]);
% imshow(g);