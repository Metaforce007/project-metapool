% identify_ball(img, point) returns the starting and ending points of the
% ball on point $point
% $img is an image that contains that ball
% $point is a certain point on the ball

function [identity] = identify_ball(img, point)

    % starting and ending points represented as
    % [start x, start y; end x, end y]
    identity = [0, 0; 0, 0];
    
    % re-assign $point to the center point of the ball
    point = ball_center(img, point);
    
    mod_point = point;  % $mod_point stands for 'modification point'
    
    % a counter to count wether we are assigning the starting points or the
    % ending to $identity
    n_identity = 1;
    
    % iterate -1 : 2 : 1 -> each for travelling 1 step forward (+x \ +y) or
    % 1 step backward (-x \ -y)
    for i=-1 : 2 : 1
        
        % while the color of $mod_point is not 8 (not the table color)
        while interpret_rgb(extract_rgb(img, mod_point)) ~= 8
            
            % x going 1 step forward \ backward -> based on j
            mod_point(1) = mod_point(1) + i;
        end
        
        % while the color of [$point(1), $mod_point(2)] is not 8 (not the
        % table color)
        while interpret_rgb(extract_rgb(img, [point(1), mod_point(2)])) ~= 8
            
            % y going 1 step forward \ backward, based on j
            mod_point(2) = mod_point(2) + i;
        end
        
        % assign starting \ ending points to $identity, based on
        % $n_identity
        identity(n_identity, :)	= mod_point;
        
        n_identity = n_identity + 1; % incrementing by 1
        
        % reseting $mod_point; setting it to $point so we could continue
        % modifying and working with it
        mod_point  = point;
    end
end
