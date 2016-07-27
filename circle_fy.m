% r^2 = a^2 - 2ax + x^2 + b^2 -2by + y^2
% circle formula
% returns the value of a
% $x_pt -> b
% $center_point -> circle center x and y
% $rad -> radius

function [y_pt] = circle_fy(x_pt, center_point, rad)
    c = rad*rad - x_pt*(x_pt - 2*center_point(2)) - center_point(1)*center_point(1) - center_point(2)*center_point(2);
    y_pt = round(quad_formula(1, -2*center_point(1), -c));
end
