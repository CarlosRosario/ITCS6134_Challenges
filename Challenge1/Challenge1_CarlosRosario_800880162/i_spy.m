function [r,c] = i_spy ( object_im, big_im, x )

small_image = object_im(:,:,1); % Grey-scale version of the big image, we don't need color for this challenge
Ro = size(small_image, 1); 
Co = size(small_image, 2); 

Rb = x.row;
Cb = x.col;

topLeftCornerOfSmallImage = small_image(1,1);
starting_indices = find(x.grey_im == topLeftCornerOfSmallImage); % Get a list of indices that have the top left corner of the small image. Dramatically reduce our search space

for index = 1:size(starting_indices,1)
    [r,c] = ind2sub(size(x.grey_im), starting_indices(index));
    % Make sure we don't go out of bounds with large indices.
    if(r+(Ro-1) > Rb || c+(Co-1) > Cb)
        continue;
    end
    diff_val = x.grey_im(r:r+(Ro-1), c:c+(Co-1), : ) - small_image;
    if ( sum ( abs ( diff_val(:)) ) == 0 )
        return;
    end
end