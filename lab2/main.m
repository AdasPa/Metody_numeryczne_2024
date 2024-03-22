clear all
close all
format compact

n_max = 300;
a = 10
r_max = a/2

[circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max);
%verified_circles = verify_circles(a, circles);
plot_circles(a, circles); 
plot_circle_areas(circle_areas);
plot_counts_mean(counts_mean);
%print -dpng zadanie1.png;