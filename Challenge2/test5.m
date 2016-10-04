input_im = imread('data/input_7.JPG');
input_im = rgb2gray(input_im);
% input_im_red = input_im(:,:,1);
% input_im_green = input_im(:,:,2);
% input_im_blue = input_im(:,:,3);
% input_im = histeq(input_im);
% imshow(input_im,[]);


% imshow(input_im_red);
% title('red');
% hold on;
% figure;
% imshow(input_im_green);
% title('green');
% hold on;
% figure;
% imshow(input_im_blue);
% title('blue');

%imshow(input_im);
%figure;
%imhist(input_im);
% 
smoothed_im = medfilt2(input_im, [50 50]);
figure;
imshow(smoothed_im);


% test edge detection
[~, t] = edge(smoothed_im, 'Sobel','both');
bw = edge(smoothed_im, 'Sobel', t*2, 'both');
figure;
imshow(bw);

% test thresholding
% level = graythresh(input_im);
% bw = imbinarize(input_im,level);
% figure;
% imshow(bw);