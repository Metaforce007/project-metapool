% quadratic formula
% $a, $b, $c -> ax^2 + bx + c

function [x] = quad_formula(a, b, c)
    fst = sqrt(b*b - 4*a*c) / (2*a);
    scd = -b / (2*a);
    x = [scd + fst, scd - fst];
end
