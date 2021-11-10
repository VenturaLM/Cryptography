function code = knapsack_cipher(s, text)
    %KNAPSACK_CIPHER computes the knapsack cipher.
    %   CODE = KNAPSACK_CIPHER(S, TEXT) returns an array associated to the
    %   encoded clean text.
    
    tic
    valide = knapsack(s);
    s_length = length(s);
    code = 0;
    
    % Checks if s is a valid knapsack.
    if valide == -1
        error('The input is not a knapsack.');
        return;
    end
    
    unicode_values = double(text);
    
    % Converts unicode to binary code.
    c = dec2bin(unicode_values(:), 8);
    c = reshape(c.',1,[])-'0';
    
    % Adds 1's if necessary to fit until the size of the knapsack.
    while rem(length(c), s_length) ~= 0
        c(end + 1) = 1;
    end
    
    v = reshape(c, s_length, []);
    v_trasposed = v';
    
    % Sustitute in the knapsack.
    [rows, cols] = size(v_trasposed);
    code = [];
    for i = 1:rows
        sum = 0;
        for j = 1:cols
            if v_trasposed(i,j) == 1
                sum = sum + s(j);
            end
        end
        code(end + 1) = sum;
    end
    toc
end
