% find_cue_fy(img, center_point, radius) returns the pixels where there is
% a cue; it does it by increasing the radius and try each y with its two x
% on the circle
% $img is an image with the cue
% $center_point is the center point of the circle (white ball) for which
% we will increase the radius
% $radius is the circle radius

function [cue] = find_cue_fy(img, center_point, radius)
    
    % will hold the pixels that the cue is in
    cue = [0,0;0,0]; cue_index = 1;
    
    % boolean; whether we should brake after we have found a cue pixel
    break_ = 0;
    
    % iterate 2*radius : 10 : 4*radius; from 2r to 4r with jumps of 10 to
    % find cue in the new circle whose radius is $i
    for i=2*radius : 10 : 4*radius
        
        % iterate center_point(2) - i : center_point(2) + i; check every y
        % and its two x in the circle
        for j=center_point(2) - i : center_point(2) + i
            
            % get the x value by the y value (two x)
            x = circle_fy(j, center_point, i);
            
            % iterate 1:2; each for each x
            for k=1 : 2
                
                % if cue exist on $(x(k), j)
                if cue_exist(img, [x(k), j])
                    
                    % add it to the pixel matrix
                    cue(cue_index, :) = [x(k), j];
                    
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
