% clear any variables
clear; clc;

% set up color channel options
r = [1 0 1 1 0 0 1];
g = [1 1 0 1 0 1 0];
b = [1 1 1 0 1 0 0];

% get all 3 color channels
input_im = imread('data/input_19.JPG');
input_im_red = input_im(:,:,1); input_im_red = input_im_red(1:3:end,1:3:end);
input_im_green = input_im(:,:,2); input_im_green = input_im_green(1:3:end, 1:3:end);
input_im_blue = input_im(:,:,3); input_im_blue = input_im_blue(1:3:end, 1:3:end);

% otsu method to get individual thresholds for each color channel
r_thresh = graythresh(input_im_red);
g_thresh = graythresh(input_im_green);
b_thresh = graythresh(input_im_blue);

% threshold each color channel using otsu treshold value
r_bw = imbinarize(input_im_red, r_thresh);
g_bw = imbinarize(input_im_green, g_thresh);
b_bw = imbinarize(input_im_blue, b_thresh);

% band-aid code / hack
% logical b/t all 3 channels
bw = ones(size(input_im_red,1), size(input_im_red,2));
for i = 1:7
    bw(bw < 2) = 1; % reset bw to all ones without using the ones() method
    if ( r(i) == 1 ); bw = bw .* r_bw; end;
    if ( g(i) == 1 ); bw = bw .* g_bw; end;
    if ( b(i) == 1 ); bw = bw .* b_bw; end;
    
    black_pix = find(bw == 0);
    percentage_of_black_pix = size(black_pix,1) / (size(bw,1)*size(bw,2));

    if percentage_of_black_pix > .8
        continue;
    else
        break;
    end
end

% blurring image
blur_im = imgaussfilt(bw, 20);
figure;
imshow(blur_im);

% threshold the blurred image
g_thresh = graythresh(blur_im);
g_bw = imbinarize(blur_im, g_thresh);
figure;
imshow(g_bw);

% crop 10% on all sides
imWidth = size(g_bw,1);
imHeight = size(g_bw,2);

%x + cropTop and y + cropLeft to get back to the original pixel in the
%original image. Not sure why or how yet. 
cropTop = floor(imHeight * .15);
cropBottom = imHeight - cropTop;
cropLeft = floor(imWidth * .15);
cropRight = imWidth - cropLeft;
g_bw_cropped = g_bw(cropLeft:cropRight, cropTop:cropBottom);
figure;
imshow(g_bw_cropped);

% Now find the top-left and bottom-right corner white pixels
[rows,cols] = find(g_bw_cropped); 
top_left_row = (min(rows)*3) + (cropLeft*3)  %y for top-left corner
top_left_col = (min(cols)*3) + (cropTop*3) %x for top-left corner
bottom_right_row = (max(rows)*3) + (cropLeft*3)
bottom_right_col = (max(cols)*3) + (cropTop*3)
width = bottom_right_col - top_left_col + 1 %// Step #3
height = bottom_right_row - top_left_row + 1

%draw bbox on image
bboxA = [top_left_col top_left_row width height];
final = insertShape ( input_im, 'Rectangle', bboxA,'Color','green', 'LineWidth', 5 );
figure;
imshow(final);

