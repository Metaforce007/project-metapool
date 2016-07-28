% cue_gradient(cue) returns the gradient of $cue
% $cue is a matrix with the cue pixels

function [gradient] = cue_gradient(cue)
    
    % gradient formula
    gradient = (cue(end, 2)-cue(1, 2))/(cue(end,1)-cue(1,1));
end
