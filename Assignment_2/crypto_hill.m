function matrix = crypto_hill(text, code, d)
%CRYPTO_HILL Computes the key matrix used in an Hill Cipher.
    %   PERMUTE = PERMUTATION(TEXT, CODE, D) returns, if possible, the key
    %   matrix used in Hill Cipher.
    tic
    text = letter_number(text);
    code = letter_number(code);
    text_length = length(text);
    code_length = length(code);
    
    threshold = d * d;

    if text_length < threshold || code_length < threshold
        error('Proper length of the text: %d', threshold);
    end

    remainder = mod(text_length, d);

    if remainder ~= 0
        for right_side_matrix = length(text):-1:(length(text) - remainder + 1)
            text(right_side_matrix) = [];
        end

        text_length = length(text);
    end

    if text_length ~= code_length
        for right_side_matrix = length(code):-1:(length(code) - (code_length - text_length) + 1)
            code(right_side_matrix) = [];
        end
    end

    rows = text_length / d;
    left_side_matrix = reshape(text, d, rows)';
    right_side_matrix = reshape(code, d, rows)';
    system_matrix = [left_side_matrix right_side_matrix];
    matrix = system_matrix;

    for j = 1:d
        is_one_flag = 0;
        has_inverse_flag = 0;

        for right_side_matrix = j:rows
            if matrix(right_side_matrix, j) == 1
                is_one_flag = 1;
                this_row_has_one = right_side_matrix;
                
            else
                if has_inverse_flag == 0
                    [mcd, inv, ~] = gcd(matrix(right_side_matrix, j), 27);

                    if mcd == 1
                        has_inverse_flag = 1;
                        this_row_has_inverse = right_side_matrix;
                    end
                end
            end
        end

        if is_one_flag
            if matrix(j, j) ~= 1
                aux = matrix(j, :);
                matrix(j, :) = matrix(this_row_has_one, :);
                matrix(this_row_has_one, :) = aux;
            end

        else
            aux = matrix(j, :);
            matrix(j, :) = matrix(this_row_has_inverse, :);
            matrix(this_row_has_inverse, :) = aux;
            matrix(j, :) = mod(matrix(j, :) * inv, 27);
        end

        for k = 1:rows
            if k ~= j
                matrix(k, :) = mod(matrix(k, :) - mod((matrix(k, j) * matrix(j, :)), 27), 27);
            end
        end
    end

    I = eye(d);

    if ~isequal(I, matrix((1:d), (1:d)))
        error('Key not obtained: Need more text to obtain the key.');
    end

    matrix = matrix((1:d), (d + 1:d * 2)).';
    toc
end