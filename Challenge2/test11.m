clear; clc;
input_im = imread('data/input_25.JPG');
input_im_red = input_im(:,:,1);
red_hist = imhist(input_im_red);


red_hist_slice = red_hist(150:200);
red_hist_slice_sorted = sort(red_hist_slice);

count = 1;
while 1
    
    minVal = red_hist_slice_sorted(count);
    idx = find(red_hist == minVal);
    idx = idx(1);
    
    if(red_hist(idx) - red_hist(idx+1) < 0 && red_hist(idx) - red_hist(idx -1) < 0)
        break; 
    end
    
    count = count + 1;
    
end

imshow(input_im_red);
figure;
norm = red_hist / numel(input_im_red);
plot(norm);