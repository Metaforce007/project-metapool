% configured(color_code) returns whether the user have configured the color
% code -> whether there is an rgb value for $color_code
% $color_code is a color code (0-8)

function [status] = configured(color_code)
    
    load('codeX.mat');
    
    % return 1 (true) if the sum of $codeX(color_code+1, :), which is the
    % rgb value for $color_code, equals 0
    status = ~(sum(codeX(color_code+1, :)) == 0);
    
end
