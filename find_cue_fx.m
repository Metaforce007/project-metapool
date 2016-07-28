% find_cue_fx(img, center_point, radius) returns the pixels where there is
% a cue; it does it by increasing the radius and try each x with its two y
% on the circle
% $img is an image with the cue
% $center_point is the center point of the circle (white ball) for which
% we will increase the radius
% $radius is the circle radius


function [cue] = find_cue_fx(img, center_point, radius)

    % will hold the pixels that the cue is in
    cue = [0,0;0,0]; cue_index = 1;
    
    % boolean; whether we should brake after we have found a cue pixel
    break_ = 0;
    
    % iterate 2*radius : 10 : 4*radius; from 2r to 4r with jumps of 10 to
    % find cue in the new circle whose radius is $i
    for i=2*radius : 10 : 4*radius
        
        % iterate center_point(1) - i : center_point(1) + i; check every x
        % and its two y in the circle
        for j=center_point(1) - i : center_point(1) + i
            
            % get the y value by the x value (two y)
            y = circle_fx(j, center_point, i);
            
            % iterate 1:2; each for each y
            for k=1 : 2
                
                % if cue exist on $(j, y(k))
                if cue_exist(img, [j, y(k)])
                    
                    % add it to the pixel matrix
                    cue(cue_index, :) = [j, y(k)];
                    
                    % we can break the second loop and continue; we have
                    % found a cue pixel here
                    cue_index = cue_index + 1; break_ = 1; break;
                end
            end
            
            % breaks this loop if we have found a cue pixel
            if break_
                break_ = 0; break;
            end
        end
    end
end
