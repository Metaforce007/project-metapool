exm2 = imread('exm5.jpg');
center_point = ball_center(exm2, [202, 196]);
radius = ball_radius(exm2, center_point);


cue_detect_x = zeros(2*radius, 2);
cue_detects_x = 1;

cue_detect_y = zeros(2*radius, 2);
cue_detects_y = 1;

% remember jump by!!


for i=2*radius : 10 : 4*radius
    for j=center_point(1) - i : center_point(1) + i
        y = circle_fx(j, center_point, i);
        if cue_exist(exm2, [j, y(1)])
            exm2(y(1), j, :) = [255, 0, 0];
            cue_detect_x(cue_detects_x, :) = [j, y(1)];
            cue_detects_x = cue_detects_x + 1;
            break;
        end
        if cue_exist(exm2, [j, y(2)])
            exm2(y(2), j, :) = [255, 0, 0];
            cue_detect_x(cue_detects_x, :) = [j, y(2)];
            cue_detects_x = cue_detects_x + 1;
            break;
        end
    end
end



for i=2*radius : 10 : 4*radius
    for j=center_point(2) - i : center_point(2) + i
        x = circle_fy(j, center_point, i);
        if cue_exist(exm2, [x(1), j])
            exm2(j, x(1), :) = [255, 0, 0];
            cue_detect_y(cue_detects_y, :) = [x(1), j];
            cue_detects_y = cue_detects_y + 1;
            break;
        end
        if cue_exist(exm2, [x(2), j])
            exm2(j, x(2), :) = [255, 0, 0];
            cue_detect_y(cue_detects_y, :) = [x(2), j];
            cue_detects_y = cue_detects_y + 1;
            break;
        end
    end
end
exm2 = imread('exm5.jpg');

% make sure pass gradient with the end index of cue_detect

cue_fx = find_cue_fx(exm2, center_point, radius);
cue_fy = find_cue_fy(exm2, center_point, radius);

%{
gradient_x = cue_gradient(cue_detect_x);
gradient_y = cue_gradient(cue_detect_y);


curx = cue_detect_x(1,1);
b = line_equation(curx, cue_detect_x(1,2), gradient_x);
%while ?
for i = 1 : 100
    curx = curx + 1;
    cury = line_fx(curx, gradient_x, b);
    exm2(cury, curx, :) = [255, 0, 0];
end

curx = cue_detect_y(1,1);
b = line_equation(curx, cue_detect_x(1,2), gradient_y);
%while ?
for i = 1 : 100
    curx = curx + 1;
    cury = line_fx(curx, gradient_y, b);
    exm2(cury, curx, :) = [255, 0, 0];
end


%}
imshow(exm2);
