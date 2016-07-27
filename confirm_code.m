function [status] = confirm_code(rgb, code)
    
    load('codeX.mat');
    
    status = confirm_rgb(rgb, codeX(code+1, :));
end
