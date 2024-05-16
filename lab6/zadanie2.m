function [country, source, degrees, y_original, y_approximation, mse] = zadanie1(energy)
    % Głównym celem tej funkcji jest wyznaczenie aproksymacji danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
    % Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
    % Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
    % 
    % energy - struktura danych wczytana z pliku energy.mat
    % country - [String] nazwa kraju
    % source  - [String] źródło energii
    % degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
    % y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
    % y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej dane wejściowe. y_approximation stanowi aproksymację stopnia degrees(i).
    % mse - wektor o rozmiarze 4x1: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).

    country = 'Germany';
    source = 'Nuclear';

    degrees = [1, 4, 10, 20];

    y_approximation = {};
    mse = [];

    if isfield(energy, country) && isfield(energy.(country), source)

        y_original = energy.(country).(source).EnergyProduction;
        y_movmean = movmean(y_original,[11,0]);
        dates = energy.(country).(source).Dates;

        x = linspace(-1, 1, length(y_movmean))';

        for i = 1:length(degrees)

            p = polyfit(x, y_movmean, degrees(i));
            y_approximation{i} = polyval(p, x);

            mse(i) = mean((y_movmean - y_approximation{i}).^2);
        end

        figure;

        subplot(2, 1, 1);
        plot(x, y_movmean, 'o', 'DisplayName', 'Średnia krocząca');
        
        hold on;
        plot(x, y_original, 'x', 'DisplayName', 'Oryginalne dane');
        colors = {'r-', 'g-', 'b-', 'm-'};
        for i = 1:length(degrees)
            plot(x, y_approximation{i}, colors{i}, 'DisplayName', sprintf('Stopień %d', degrees(i)));
        end
        legend;
        title('Aproksymacja wielomianowa produkcji energii');
        xlabel('x');
        ylabel('Produkcja energii (TWh)');
        grid on;

        subplot(2, 1, 2);
        bar(mse);
        set(gca, 'XTickLabel', degrees);
        title('Błąd średniokwadratowy aproksymacji');
        xlabel('Stopień wielomianu');
        ylabel('MSE');
        grid on;

        saveas(gcf, 'zadanie2.png');
    else
        disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
    end
end
