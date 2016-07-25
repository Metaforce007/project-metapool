% ball_center(img, point) returns the center point of a ball
% $img is an image that contains that ball
% $point is a certain point on the ball

function [center] = ball_center(img, point)

    % how many pixels we have travelled from the starting points
    % [+x, -x, +y, -y] OR [+row, -row, +column, -column]
    travel      = [0, 0, 0, 0];
    
    n_travel    = 0;        % counter that count the current travel
    center      = [0, 0];   % initializing center points
    
    for i=1 : 2             % iterate 1:2       -> each for $point(1) and $point(2)
        for j=-1 : 2 : 1    % iterate -1:2:1    -> each for travelling 1 step forward (+x \ +y) or 1 step backwards (-x \ -y)
            
            n_travel = n_travel + 1;    % incrementing the current travel by 1
            
            % interpret_rgb(rgb) returns the color of which $rgb represents
            % extract_rgb(img, point) returns the rgb of $point in $img
            % while the color of $point is not 8 (not the table color)
            while interpret_rgb(extract_rgb(img, point)) ~= 8
                
                point(3-i) = point(3-i) - j;                % going 1 step forward \ backwards -> based on j
                travel(n_travel) = travel(n_travel) + 1;    % incrementing the steps for the current travel by 1
            end
            
            point(3-i) = point(3-i) + j*travel(n_travel);   % reseting the current point to its starting value
        end
        
        % calculating the center point(x or y) by adding the subtraction of
        % the backward steps from the forward steps, to the starting point
        % (x or y)
        center(i) = point(3-i) + (travel(n_travel-1) - travel(n_travel))/2;
    end
end