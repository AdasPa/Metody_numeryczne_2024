function plot_circle_areas(circle_areas)
    n = numel(circle_areas);
    x = 1:n;
    plot(x, circle_areas, '-o');
    
    title('Wykres sumy pól kół');
    xlabel('Indeks');
    ylabel('Suma pól kół');
    %print -dpng zadanie3.png 
end