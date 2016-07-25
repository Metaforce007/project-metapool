% extract_rgb(img, point) returns the rgb of $point in $img
% $img is an image
% $point is the point which we want to extract the rgb value from

function [rgb] = extract_rgb(img, point)
    rgb = [0,0,0];  % initialize rgb value
    
    % the r\g\b is at the 3rd dimension of the image $img, so we are
    % referring to the same pixel 3 times, each time for each dimension
    for i=1 : 3; rgb(i) = img(point(2), point(1), i);
    end
end
