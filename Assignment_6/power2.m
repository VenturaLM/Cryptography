function n = power2(A, m)
    %POWER(A, m) Computes the minimum value of the exponent of the power of
    %A, that module m is equal to the identity matrix.
    %   N = POWER(A, M) returns the value of the exponent that makes A the
    %   identity matrix.
    %   - A: 2x2 integers matrix with inverse module m.
    %   - m: work module. Natural number.
    %   Note:
    %   - At most, the number of iterations required will be m^(rows *
    %   cols).
    
    [rows, cols] = size(A);
    assert(rows == cols, 'Matrix A is not squared.');
    assert(rows == 2, 'Matrix A is not 2x2.');
    
    % It is required for A to has inverse; else, an error will be printed.
    A_inverse = inv_module(A, m);
    
    A_power_n = A;
    iterations = m^(rows * cols);
    
    for i = 1:iterations
        A_power_n = mod(A * A_power_n, m);

        if A_power_n == eye(2, 2)
            n = i;
            break
        end
    end

end

