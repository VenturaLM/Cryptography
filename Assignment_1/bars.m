function compare = bars(v)
    %BARS Gets the frequencies of the letters in a message.
    %   COMPARE = BARS(V) shows the statistics of the frequencies in bars plot.
    tic
        A = importdata('spanish_frequence.txt'); %Needs "spanish_frequence.txt"
        subplot(2,1,1)
        bar(A(1:end, 2), A(1:end, 1), 'r');
        title('Spanish frequecies');

        [freq, freq_order] = cript_ana_order(v);
        compare = [sortrows(A, 1, "descend"), freq_order];
        subplot(2,1,2)
        bar(freq_order(1:end, 2), freq_order(1:end, 1));
        title('Code frequencies');

        disp(compare);
        
    toc
end

