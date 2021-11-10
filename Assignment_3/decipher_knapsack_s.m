function text = decipher_knapsack_s(s, code)
    %DECIPHER_KNAPSACK_S decode a cryptogram.
    %   TEXT = DECIPHER_KNAPSACK_S(S, CODE) returns the clear text.
    
    tic
    valide = knapsack(s);
    s_length = length(s);
    code_length = length(code);
    
    % Checks if s is a valid knapsack.
    if valide == 0 || valide == -1
        error('The input is not a knapsack.');
        return;
    end
    
    v = zeros(code_length, s_length);

    for i = 1:code_length
        for j = s_length:-1:1
            tmp = code(i) - s(j);

            if tmp <= s(j) && tmp > -1
                v(i,j) = 1;
            end
            
            if tmp >= 0
                code(i) = tmp;
            else
        end
    end
    
    result = [];
    text = [];
    
    for i = 1:code_length
        for j = 1:s_length
            result(end + 1) = v(i, j);

            if length(result) == 8
                text(end + 1) = bin2dec(char(result + '0'));
                result = [];
            end
        end
    end

    text = char(text);
    toc
end

