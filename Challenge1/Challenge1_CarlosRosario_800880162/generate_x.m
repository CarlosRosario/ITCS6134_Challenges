function [x] = generate_x ( b_im )

x.row = size(b_im,1); % Total rows in the big image
x.col = size(b_im,2); % Total columns in the big image
x.grey_im = b_im(:,:,1); % Grey-scale version of the big image, we don't need color for this challenge