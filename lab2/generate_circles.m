function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
index_number=193318; % numer Twojego indeksu
L1 = 8;
verified_circles = [];
rand_counts = []
counter = 0
while true
    circles = zeros(n_max, 3);
    for i = 1:n_max
        circles(i, 1) = rand() * a;
        circles(i, 2) = rand() * a;
        circles(i, 3) = rand() * r_max;
    end
    
    
    for i = 1:size(circles, 1)
        counter = counter + 1
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
                rand_counts = [rand_counts; counter];
                counter = 0;
                if size(verified_circles,1) == n_max
                    break
                end
            end
        end
    end
    if size(verified_circles,1) == n_max
       break
    end
end
circles = verified_circles
counts_mean = cumsum(rand_counts) ./ (1:n_max)';
circle_areas = cumsum(circles(:, 3).^2*pi);
end
