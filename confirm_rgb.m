% confirm_rgb(rgb, base_rgb) returns whether $rgb is similar to $base_rgb
% $rgb is an rgb value
% $base_rgb is also an rgb value, but it should represent an average of a
% much greater set of values, that are close to $rgb itself

function [result] = confirm_rgb(rgb, base_rgb)

    % how much does the rgb representation can deviate from its source
    % both + and -
    deviation_rate = base_rgb .* 2;
    
    %[max_rgb, col] = max(base_rgb) might have to use the max value for
    % high deviation rate
    
    % holds whether r\g\b from $rgb are similar to r\g\b from $base_rgb
    correct = [0, 0, 0];
    
    % iterate 1:3 for three rgb representations, r\g\b
    for i=1 : 3
        
        % iterate -deviation_rate : deviation_rate to check if r\g\b
        % (based on i) from $rgb is similar to r\g\b from $base_rgb
        for j=-deviation_rate(i) : deviation_rate(i)
            
            % if r\g\b from $rgb + $j equal to r\g\b from $base_rgb
            % than it is considered a 'similar' color
            if rgb(i)+j == base_rgb(i)
                
                % set r\g\b based on $i to 1 ('true') and break the loop
                % because we have found that r\g\b from $rgb is similar to
                % r\g\b from $base_rgb
                correct(i) = 1; break;
            end
        end
    end
    
    % return whether all of the colors are similar
    result = sum(correct == 1) == 3;
end
