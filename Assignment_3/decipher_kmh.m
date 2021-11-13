function text = decipher_kmh(s, code, mu, invw)
    %DECIPHER_KMH decipher a code encrypted with a knapsack using a public
    %key.
    %   TEXT = DECIPHER_KMH(S, CODE, MU, INVW) returns the clean text of a encrypted text.
    
    tic
    
    valide = knapsack(s);
    code_length = length(code);
    
    % Checks if s is a valid knapsack.
    if valide == -1 || valide == 0
        error('The input is not a knapsack or a simple knapsack.');
        return;
    end
    
    cryptogram = [];
    % Get the cryptogram.
    for i = 1:code_length
       cryptogram(i) = mod(invw * code(i), mu);
    end
    
    text = decipher_knapsack_s(s, cryptogram);
    
    toc
end