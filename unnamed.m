exm2 = imread('exm1.jpg');
center_point = ball_center(exm2, [238, 223]);
radius = ball_radius(exm2, center_point);


cue_detect = zeros(8*radius, 2);
cue_detects = 1;

for i=2*radius : 8*radius
    for j=center_point(1) - i : center_point(1) + i
        y = circle_fx(j, center_point, i);
        if cue_exist(exm2, [j, y(1)])
            exm2(y(1), j, :) = [255, 0, 0];
            cue_detect(cue_detects, :) = [j, y(1)];
            cue_detects = cue_detects + 1;
        end
        if cue_exist(exm2, [j, y(2)])
            exm2(y(2), j, :) = [255, 0, 0];
            cue_detect(cue_detects, :) = [j, y(2)];
            cue_detects = cue_detects + 1;
        end
    end
end



for i=2*radius : 8*radius
    for j=center_point(2) - i : center_point(2) + i
        x = circle_fy(j, center_point, i);
        if cue_exist(exm2, [x(1), j])
            exm2(j, x(1), :) = [255, 0, 0];
            cue_detect(cue_detects, :) = [x(1), j];
            cue_detects = cue_detects + 1;
        end
        if cue_exist(exm2, [x(2), j])
            exm2(j, x(2), :) = [255, 0, 0];
            cue_detect(cue_detects, :) = [x(2), j];
            cue_detects = cue_detects + 1;
        end
    end
end

cue_detect = sortrows(cue_detect);
gardient = cue_gardient(cue_detect);

%imshow(exm2);

