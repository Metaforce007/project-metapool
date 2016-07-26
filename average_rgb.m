% average_rgb(img, points) returns the average rgb value of all rgb values
% from the starting point to the ending point
% $img is an image
% $points represents the starting and ending points as
% $points(1:2) -> starting point
% $points(3:4) -> width and height; ->
% $points(1:2) + $points(3:4) == ending points

function [avg_rgb] = average_rgb(img, points)

    % hold rgb values for calculating the average rgb
    rgb_vals = [0,0,0];

    % counter that counts how many rgb values we added to $rgb_vals
    rgb_added = 0;
    
    % iterating start x : end x
    for i=points(1) : points(1)+points(3)
        
        % iterating start y : end y
        for j=points(2) : points(2)+points(4)
            
            % iterating 1:3 for 3 dimensions of the image
            for k=1 : 3
                
                % summing the r\g\b value from $img, based on $k
                rgb_vals(k) = rgb_vals(k) + double(img(j, i, k));
            end
            
            % incrementing rgb adding counter by 1
            rgb_added = rgb_added + 1;
        end
    end
    
    % calculating the average rgb value
    avg_rgb = ceil(rgb_vals ./ rgb_added);
end
