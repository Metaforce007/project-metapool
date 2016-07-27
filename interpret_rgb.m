% interpret_rgb(rgb) returns the color code of $rgb; if it could not find a
% similar rgb to match $rgb, than the color code will be -1
% $rgb is an r\g\b representation

function [code] = interpret_rgb(rgb)

    load('codeX.mat');
    
    % initializing return value to -1 if it could not interpret the rgb
    % value $rgb
    code = -1;

    % iterate 1:9 for each color code in $codeX 
    for i=1 : 9
        
        % if it is confirmed that $rgb is similar to $codeX(i, :), which is
        % an rgb representation of color code $i, than return this color
        % code
        if confirm_rgb(rgb, codeX(i, :))
            code = i-1; break;
        end
    end
end
