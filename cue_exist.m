function [exist] = cue_exist(img, point)

    exist = confirm_code(extract_rgb(img, point), 9);
end
