clear; clc;
input_im = imread('data/input_7.JPG');
input_im_red = input_im(:,:,2);
red_hist = imhist(input_im_red);


red_hist_slice = red_hist(155:191);
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



% count = 0;
% 
% a = zeros(255,1);
% b = zeros(255,1);
% c = zeros(255,1);
% for bin = 240:-1:120
%     binVal = red_hist(bin);
%     nextBinVal = red_hist(bin+1);
%     prevBinVal = red_hist(bin-1);
%     
%     if(binVal - nextBinVal > 0 || binVal - prevBinVal < 0)
%        continue 
%     end
% 
%     a(bin) = binVal - nextBinVal;
%     b(bin) = binVal - prevBinVal;
%     c(bin) = -1*a(bin) + b(bin);
% end
