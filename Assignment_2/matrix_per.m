function matrix = matrix_per(p)
%MATRIX_PER Builds a matrix asociated to an input permutation array.
    %   MATRIX = MATRIX_PER(P) returns an indexed matrix with the input permutation.
    tic
    if permutation(p) == 0
        error('The input is not a permutation.');
    end

    matrix_size = max(p);
    matrix = zeros(matrix_size, matrix_size);

    for i = 1:matrix_size
        for j = 1:matrix_size
            if j == p(i) && i < matrix_size
                matrix(i, j) = 1;
                i = i + 1;
            end
            
            if i == matrix_size
                matrix(i, p(i)) = 1;
            end
        end
    end
    toc
end