function [freq, freq_order] = cript_ana_order(v)
    %CRIPT_ANA_ORDER Gets the frequencies of the letters in a message.
    %   [FREQ, FREQ_ORDER] = CRIPT_ANA_ORDER(V) shows the statistics of the frequencies sorted as "descend".
    tic
    
    v = letter_number(v);
    freq = zeros(27, 2);
    len = length(v);

    for i = 1 : 27
        freq(i, 2) = i - 1;
    end
    
    for i = 1 : len
        freq(v(i) + 1, 1) = freq(v(i) + 1, 1) + 1/len;
    end

    freq_order = sortrows(freq, 1, "descend");
    
    toc
end

