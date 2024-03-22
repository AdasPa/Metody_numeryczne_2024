function verified_circles = verify_circles(a, circles)
    
    verified_circles = [];
    for i = 1:size(circles, 1)
        x_i = circles(i, 1);
        y_i = circles(i, 2);
        r_i = circles(i, 3);
        is_verified = false
        if x_i > r_i && a - x_i > r_i && y_i > r_i && a - y_i > r_i
            is_verified = true;
            for j = 1:size(verified_circles, 1)
                x_j = verified_circles(j, 1);
                y_j = verified_circles(j, 2);
                r_j = verified_circles(j, 3);
                distance = sqrt((x_i - x_j)^2 + (y_i - y_j)^2);
                if distance < r_i + r_j
                    is_verified = false;
                    break;
                end
            end
            if is_verified
                verified_circles = [verified_circles; circles(i, :)];
            end
        end
    end
end
