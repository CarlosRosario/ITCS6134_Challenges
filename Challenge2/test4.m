input_im = imread('data/input_25.JPG');
input_im = rgb2gray(input_im);
input_im = input_im - 100;
imshow(input_im);

% windowSize = 31; % set window size
% halfWidth = floor(windowSize/2);
% [R,C] = size(input_im);
% padded_input_im = padarray(input_im, [windowSize, windowSize]);
% g = zeros(R,C, 'uint8');
% 
% for x = 1:R
%     for y = 1:C
%         window = padded_input_im(x+windowSize-halfWidth:x+windowSize+halfWidth, y+windowSize-halfWidth:y+windowSize+halfWidth);
%         window = window(:);
%         window = sort(window);
%         median_val = window(ceil(end/2));
%         g(x,y) = median_val;
%     end
% end
% 
% imshow(g);

% g = medfilt2(input_im, [1000 1000]);
% imshow(g);