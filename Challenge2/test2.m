input2_im = imread('data/input_25.JPG');
input2_im = rgb2gray(input2_im);
input2_im = input2_im(1:3:end, 1:3:end);
window = 11; 
window_half = floor(window/2);
[R,C] = size(input2_im);

meanIm = zeros(R,C, 'uint8');
for r = window_half + 1 : (R-window_half-1)
    for c = window_half + 1 : (C - window_half -1) 
        meanIm(r,c) = mean (mean(input2_im(r-window_half:r+window_half, c-window_half:c+window_half)));
    end
end

input2_im_local_tresh_K1 = input2_im >= 1*meanIm;
input2_im_local_tresh_Kdot6 = input2_im >= .6*meanIm;
input2_im_local_tresh_K1dot2 = input2_im >= 1.2*meanIm;