function [ct] = how_many ( prefix, ct_f, num_f )

dil = ones(6,6);
ero = ones(6,6);

%Some random numbers get returned
for x=1:numel(ct_f)
    %load an image
    fn1 = sprintf ( '%sFRM_%05d.png%', prefix, ct_f(x));
    
    if(x == num_f) 
        y = x - 1;
    else
        y = x + 1;
    end
    
    fn2 = sprintf ( '%sFRM_%05d.png%', prefix, y);
    img = imread ( fn1 );
    img = rgb2gray(img);
    img2 = imread(fn2);
    img2 = rgb2gray(img2);
    
    subimg = img2 - img;
    
    thresh = graythresh(subimg);
    imbw = imbinarize(subimg, thresh);
    
    imbw_dilated = imdilate(imbw, dil);
    imbw_eroded = imerode(imbw_dilated, ero);
    
    L = bwlabel(imbw_eroded,8);
    stats = regionprops(L, 'Area', 'PixelIdxList');
    cleaned = imbw_eroded;
    for region = 1: length(stats);
       if stats(region).Area < 100
           cleaned(stats(region).PixelIdxList) = 0;
       end
    end
    
    L = bwlabel(cleaned,8);
    
    % need to not count any potential labeled objects that are touching
    % image borders
    
    %figure; imshow(cleaned);
    borderImages = 0;
    for i = 1:max(L(:))
       [r,c] = find(L == i);
       if(any(r == 1) == 1 || any(c == 1) == 1)
           borderImages = borderImages + 1;
       end
    end
    ct(x) = size(unique(L(:)),1) - borderImages;
end
