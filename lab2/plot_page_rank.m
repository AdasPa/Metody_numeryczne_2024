function plot_page_rank(r)
    bar(r);
    title('Ranking stron');
    xlabel('Indeks strony');
    ylabel('PageRank');
    print -dpng zadanie7.png 
end
