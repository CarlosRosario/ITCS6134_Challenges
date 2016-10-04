clear; clc;
input_im = imread('data/input_25.JPG');
input_im_red = input_im(:,:,1);
input_im_green = input_im(:,:,2);
input_im_blue = input_im(:,:,3);

numRows = size(input_im_blue,1);
numCols = size(input_im_blue,2);

red_hist = imhist(input_im_red);
green_hist = imhist(input_im_green);
blue_hist = imhist(input_im_blue);

% find red thresh

red_hist_slice = red_hist(100:160);
red_hist_slice_sorted = sort(red_hist_slice);

count = 1;
while 1
    
    minVal = red_hist_slice_sorted(count);
    r_thresh = find(red_hist == minVal);
    r_thresh = r_thresh(1);
    
    if(red_hist(r_thresh) - red_hist(r_thresh+1) < 0 && red_hist(r_thresh) - red_hist(r_thresh -1) < 0)
        break; 
    end
    
    count = count +1;
    
end

% find green thresh
green_hist_slice = green_hist(100:160);
green_hist_slice_sorted = sort(green_hist_slice);

count = 1;
while 1
    
    minVal = green_hist_slice_sorted(count);
    g_thresh = find(green_hist == minVal);
    g_thresh = g_thresh(1);
    
    if(green_hist(g_thresh) - green_hist(g_thresh+1) < 0 && green_hist(g_thresh) - green_hist(g_thresh -1) < 0)
        break; 
    end
    
    count = count +1;
    
end


% find blue thresh
%blue_hist_slice = blue_hist(150:200);
blue_hist_slice = blue_hist(100:160);
blue_hist_slice_sorted = sort(blue_hist_slice);

count = 1;
while 1
    
    minVal = blue_hist_slice_sorted(count);
    b_thresh = find(blue_hist == minVal);
    b_thresh = b_thresh(1);
    
    if(blue_hist(b_thresh) - blue_hist(b_thresh+1) < 0 && blue_hist(b_thresh) - blue_hist(b_thresh -1) < 0)
        break; 
    end
    
    count = count +1;
    
end


%do blue first
idx = find(input_im_blue < b_thresh);
[rows, cols] = ind2sub([numRows, numCols], idx);

for i = 1 : size(rows,1)
    input_im_blue(rows(i), cols(i)) = 0;
end

% do red
idx = find(input_im_red < 165);
[rows, cols] = ind2sub([numRows, numCols], idx);

for i = 1 : size(rows,1)
    input_im_red(rows(i), cols(i)) = 0;
end

% do green
idx = find(input_im_green < g_thresh);
[rows, cols] = ind2sub([numRows, numCols], idx);

for i = 1 : size(rows,1)
    input_im_green(rows(i), cols(i)) = 0;
end

input_im_new = input_im_red .* input_im_blue .* input_im_green;

imshow(input_im_blue);
title('blue');
hold on;

figure;
imshow(input_im_red);
title('red');
hold on;

figure;
imshow(input_im_green);
title('green');
hold on;

figure;
imshow(input_im_new);
title('all');

% Need to find out what the best window size is
g = medfilt2(input_im_new, [31 31]);
figure;
imshow(g);
title('med filt');