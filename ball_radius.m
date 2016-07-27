% ball_radius(img, center_point) returns the radius of a ball
% $img is an image with that ball
% $center_point is the center points of the ball

function [radius] = ball_radius(img, center_point)
    
    % initializing radius; radius must be positive and not 0
    radius = 1;
    
    % while the rgb value of ($center_point(1), $center_point(2)-radius) is
    % not the surface color
    while interpret_rgb(extract_rgb(img, [center_point(1), center_point(2)-radius])) ~= 8
        
        % increment the radius by 1
        radius = radius + 1;
    end
end
