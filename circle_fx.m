% r^2 = a^2 - 2ax + x^2 + b^2 -2by + y^2
% circle formula
% returns the value of b
% $y_pt -> a
% $center_point -> circle center x and y
% $rad -> radius

function [x_pt] = circle_fx(y_pt, center_point, rad)
    c = rad*rad - y_pt*(y_pt - 2*center_point(1)) - center_point(1)*center_point(1) - center_point(2)*center_point(2);
    x_pt = round(quad_formula(1, -2*center_point(2), -c));
end
