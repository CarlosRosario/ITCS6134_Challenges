function [sx, sy, sWidth, sHeight] = auto_crop ( f )

% tuning options
crop_percentage = .1;           % how much of the image to crop on all 4 sides
black_pix_percent_allowed = .8; % percentage of image that is allowed to be black
pixels_to_skip = 3;             % number of pixels to skip - helps run time tremendously


% width and height for image we will be actually processing (after skipping
% pixels).
tempImageWidth = size(f,1) / pixels_to_skip;
tempImageHeight = size(f,2) / pixels_to_skip;

% set up color channel options
r = [1 0 1 1 0 0 1];
g = [1 1 0 1 0 1 0];
b = [1 1 1 0 1 0 0];

% get every 3 pixels for each color channel
input_im_red = f(:,:,1); input_im_red = input_im_red(1:pixels_to_skip:end, 1:pixels_to_skip:end);
input_im_green = f(:,:,2); input_im_green = input_im_green(1:pixels_to_skip:end, 1:pixels_to_skip:end);
input_im_blue = f(:,:,3); input_im_blue = input_im_blue(1:pixels_to_skip:end, 1:pixels_to_skip:end);

% otsu method to get individual thresholds for each color channel
r_thresh = graythresh(input_im_red);
g_thresh = graythresh(input_im_green);
b_thresh = graythresh(input_im_blue);

% threshold each color channel using otsu treshold value
r_bw = imbinarize(input_im_red, r_thresh);
g_bw = imbinarize(input_im_green, g_thresh);
b_bw = imbinarize(input_im_blue, b_thresh);

% Pick the image that best segments the background from the foreground by
% trying different combinations of the red, green, blue color channels
% until a combination is found with less than n% black pixels
bw = ones(tempImageWidth, tempImageHeight);
for i = 1:7
    bw(bw < 2) = 1; % reset bw to all ones without using the ones() method
    if ( r(i) == 1 ); bw = bw .* r_bw; end;
    if ( g(i) == 1 ); bw = bw .* g_bw; end;
    if ( b(i) == 1 ); bw = bw .* b_bw; end;
    
    black_pix = find(bw == 0);
    percentage_of_black_pix = size(black_pix,1) / (tempImageWidth * tempImageHeight);

    if percentage_of_black_pix > black_pix_percent_allowed
        continue;
    else
        break;
    end
end

% gaussian blur & threshold the blurred image
blur_im = imgaussfilt(bw, 40);
g_thresh = graythresh(blur_im);
g_bw = imbinarize(blur_im, g_thresh);

% crop x% on all sides
% x + cropTop and y + cropLeft to get back to the original pixel in the
% original image. 
cropTop = floor(tempImageHeight * crop_percentage);
cropBottom = tempImageHeight - cropTop;
cropLeft = floor(tempImageWidth * crop_percentage);
cropRight = tempImageWidth - cropLeft;
g_bw_cropped = g_bw(cropLeft:cropRight, cropTop:cropBottom);

% Now find the top-left and bottom-right corner white pixels
[row,col] = find(g_bw_cropped);

sy = (min(row)*pixels_to_skip) + (cropLeft*pixels_to_skip);           % y for top-left corner
sx = (min(col)*pixels_to_skip) + (cropTop*pixels_to_skip);            % x for top-left corner
bottomRightY = (max(row)*pixels_to_skip) + (cropLeft*pixels_to_skip); % y for bottom-right corner
bottomRightX = (max(col)*pixels_to_skip) + (cropTop*pixels_to_skip);  % x for bottom-right corner
sWidth = bottomRightX - sx + 1;             % final width
sHeight = bottomRightY - sy + 1;            % final height