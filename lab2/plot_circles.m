function plot_circles(a, circles)
    axis equal
    axis([0 a 0 a])
    hold on
    
    for i = 1:size(circles, 1)
        plot_circle(circles(i, 1), circles(i, 2), circles(i, 3));
        pause(0.01)
    end
    hold off
end
