clear; clc;
input_im = imread('data/input_5.JPG');
input_im_red = input_im(:,:,1);
input_im_green = input_im(:,:,2);
input_im_blue = input_im(:,:,3);

imshow(input_im_blue);
title('blue');
figure;
imhist(input_im_blue);
title('blue');
hold on;

figure;
imshow(input_im_green);
title('green');
figure;
imhist(input_im_green);
title('green');
hold on;

figure;
imshow(input_im_red);
title('red');
figure;
imhist(input_im_red);
title('red');

 return;