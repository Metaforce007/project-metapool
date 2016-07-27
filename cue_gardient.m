function [gardient] = cue_gardient(cue)
    x_diff_big = cue(end,1) - cue(1,1) > cue(end,2) - cue(1,2);
    if x_diff_big
        
        col = zeros(1, cue(end,1) - cue(1,1));
        rwc = 2; rw = cue(1,1); col(1, 1) = cue(1, 2);
        while cue(rwc,1) == rw
            col(1, rwc) = cue(rwc, 2);
            rwc = rwc + 1;
        end
        start_pt = [rw, col(1, ceil((rwc-1)/2))];
        
        end_pt = [max(cue(:, 1)), max(cue(:, 2))];
        
    end
    
    gardient = (end_pt(2)-start_pt(2))/(end_pt(1)-start_pt(1));
    
end
