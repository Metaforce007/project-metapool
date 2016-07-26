% identify_ball(img, point) returns the starting and ending points of the
% ball on point $point and its average rgb representation
% $img is an image that contains that ball
% $point is a certain point on the ball


function [identity] = identify_ball(img, point)

    code8 = [16, 70, 19]; % !!! retrieve from interface

    % starting and ending points and color represented as
    % [start x, start y, end x, end y, r, g, b]
    identity = [0, 0, 0, 0, 0, 0, 0];
    
    % re-assign $point to the center point of the ball
    point = ball_center(img, point);
    
    % $mod_point stands for 'modification point'
    mod_point = point;
    
    % hold rgb values for calculating the average rgb
    rgb_vals = [0, 0, 0];
    
    % counter that counts how many rgb values we added to $rgb_vals
    rgb_added = 0;
    
    % a counter to count wether we are assigning the starting points or the
    % ending to $identity
    n_identity = 1;
    
    % iterate -1 : 2 : 1 -> each for travelling 1 step forward (+x \ +y) or
    % 1 step backward (-x \ -y)
    for i=-1 : 2 : 1
        
        % holds the current rgb value
        current_rgb = extract_rgb(img, mod_point);
        
        % while the color of $mod_point is not 8 (not the table color)
        while confirm_rgb(current_rgb, code8) ~= 8
            
            % adding the current rgb value to the total rgb values
            rgb_vals = rgb_vals + current_rgb;
            
            % incrementing rgb adding counter by 1
            rgb_added = rgb_added + 1;
            
            % getting a new current rgb value
            current_rgb = extract_rgb(img, mod_point);
            
            % x going 1 step forward \ backward, based on $j
            mod_point(1) = mod_point(1) + i;
        end
        
        % holds the current rgb value
        current_rgb = extract_rgb(img, [point(1), mod_point(2)]);
        
        % while the color of [$point(1), $mod_point(2)] is not 8 (not the
        % table color)
        while confirm_rgb(current_rgb, code8) ~= 8
            
            % adding the current rgb value to the total rgb values
            rgb_vals = rgb_vals + current_rgb;
            
            % incrementing rgb adding counter by 1
            rgb_added = rgb_added + 1;
            
            % getting a new current rgb value
            current_rgb = extract_rgb(img, [point(1), mod_point(2)]);
            
            % y going 1 step forward \ backward, based on $j
            mod_point(2) = mod_point(2) + i;
        end
        
        % assign starting \ ending points to $identity, based on
        % $n_identity
        identity(n_identity)    = mod_point(1);
        identity(n_identity+1)  = mod_point(2);
        
        % incrementing by 2 so we could add the ending points to $identity
        n_identity = n_identity + 2;
        
        % reseting $mod_point; setting it to $point so we could continue
        % modifying and working with it
        mod_point  = point;
    end
    
    % calculating the average rgb values
    rgb_vals = rgb_vals ./ rgb_added;
    
    % assigning average rgb value to the ball identity
    identity(5:7) = ceil(rgb_vals);
end
