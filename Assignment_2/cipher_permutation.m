function code = cipher_permutation(p, text)
%CIPHER_PERMUTATION Ciphers M text with Permutation Hill Cipher.
    %   CODE = CIPHER_PERMUTATION(P, TEXT)  returns the encrypted text if
    %   the cipher ends successfully; an error message if it is not carried
    %   out.
    tic
    if permutation(p) == 0
        code = 'Error';
        return;
    end
    
    text = letter_number(text);
    M = matrix_per(p);
    d = max(p);
    len = length(text);
    remainder = mod(len, d);
    
    code = [];

    if remainder ~= 0
        index = d - remainder;
        
        for i = 1:index
            text = [text, 23]
        end
    end

    matrix_d = [];
    len = length(text);
    counter_flag = d;

    for i = 1:len
        matrix_d = [matrix_d, text(i)];
        counter_flag = counter_flag - 1;

        if counter_flag == 0
            matrix_d = transpose(matrix_d);
            result = M * matrix_d;
            result = transpose(result);

            for j = 1:d
                code = [code, result(j)];
            end

            counter_flag = d;
            matrix_d = [];
        end
    end

    for i = 1:len
        code(i) = mod(code(i), 27);
    end

    alphabet = 'abcdefghijklmnñopqrstuvwxyz';
    code = alphabet(code + 1);
    toc
end
