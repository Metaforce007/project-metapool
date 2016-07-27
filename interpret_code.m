% interpret_code(color_code) returns the representation of $color_code in
% words
% $color_code is a color code (0-8)

function [color] = interpret_code(color_code)
    switch color_code
        case 0; color = 'white';
        case 1; color = 'red';
        case 2; color = 'yellow';
        case 3; color = 'green';
        case 4; color = 'brown';
        case 5; color = 'blue';
        case 6; color = 'pink';
        case 7; color = 'black';
        case 8; color = 'surface';
        otherwise color = 'unknown';
    end
end
