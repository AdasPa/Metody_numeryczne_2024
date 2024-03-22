function plot_counts_mean(counts_mean)
    n = numel(counts_mean);
    x = 1:n;
    plot(x, counts_mean, '-o');
    title('Wykres średniej liczby losowań potrzebnych do znalezienia okręgów');
    xlabel('Numer okręgu');
    ylabel('Średnia liczba losowań');
    print -dpng zadanie5.png 
end