input1_im = imread('data/input_25.JPG');
%input1_im_red = input1_im(:,:,1);
%input1_im_green = input1_im(:,:,2);
%input1_im_blue = input1_im(:,:,3);
input1_im_grey = rgb2gray(input1_im);
%T = a(input1_im_grey);
%imshow(input1_im_grey);

%bw = im2bw(input1_im_grey,T);
bw = imbinarize(input1_im_grey, 'adaptive', 'Sensitivity', 0.65);
imshow(bw);

% variance = zeros(256,1);
% for T = 0:255
%    input1_im_treshold = input1_im_grey>= T; %applies treshold and creates binary image
%    
%    w2 = sum(input1_im_treshold(:)); % # of pixels in > T
%    w1 = numel(input1_im_grey) - w2; % # of pixels in < T
%    
%    mu2 = mean(input1_im_grey(input1_im_treshold));
%    mu1 = mean(input1_im_grey(~input1_im_treshold));
%    
%    %mu1 = sum( w2(:) ) / numel(w2);
%    %mu2 = sum( w1(:) ) / numel(w1);
%    
%    difference_averages = (mu1 - mu2)^2;
%    variance(T+1) = w1*w2*difference_averages;
% end
% 
% % Get treshold value and create treshold image
% [~, treshold] = max(variance);
% input1_im_treshold = input1_im_grey >= treshold;
% imshow(input1_im_treshold);



% % load
% img = im2double(imread('data/input_9.JPG'));
% % black-white image by threshold on check how far each pixel from "white"
% bw = sum((1-img).^2, 3) > .5; 
% % show bw image
% figure; imshow(bw); title('bw image');
% 
% % get bounding box (first row, first column, number rows, number columns)
% [row, col] = find(bw);
% bounding_box = [min(row), min(col), max(row) - min(row) + 1, max(col) - min(col) + 1];
% 
% % display with rectangle
% rect = bounding_box([2,1,4,3]); % rectangle wants x,y,w,h we have rows, columns, ... need to convert
% figure; imshow(img); hold on; rectangle('Position', rect);

