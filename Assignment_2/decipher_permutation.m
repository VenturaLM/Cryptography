function text = decipher_permutation(p, code)
%DECIPHER_PERMUTATION deciphers a cryptogram with a known permutation.
    %   TEXT = DECIPHER_PERMUTATION(P, CODE) returns the clear text. 
    tic
    code = letter_number(code);
    M = matrix_per(p);
    len = length(code);
    d = max(p);
    
    text = [];
    matrix_d = [];
    counter_flag = d;

    for i = 1:len
        matrix_d = [matrix_d, code(i)];
        counter_flag = counter_flag - 1;

        if counter_flag == 0
            matrix_d = transpose(matrix_d);
            result = inv_module(M, 27) * matrix_d;
            result = transpose(result);

            for j = 1:d
                text = [text, result(j)];
            end

            counter_flag = d;
            matrix_d = [];
        end
    end

    for i = 1:len
        text(i) = mod(text(i), 27);
    end

    alphabet = 'abcdefghijklmnñopqrstuvwxyz';
    text = alphabet(text + 1);
    toc
end

