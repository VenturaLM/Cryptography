function inver = inv_module(A, m)
    %INV_MODULE compute the modular inverse of a given matrix.
    %   INVER = INV_MODULE(A, M) returns the modular inverse of the given
    %   matrix.
    %   - A: required matrix to compute the inverse.
    %   - m: work module.
    %   Note: MATLAB: Symbolic Math Toolbox Add-on required to compute the 
    %   adjugate matrix.
    
    % Check if 'm' is a valid module.
    assert(isreal(m), 'm must be an integer.');
    assert(isequal(round(m),m), 'm must be an integer.');
    
    % Check if 'A' is a valid matrix.
    [rows, cols] = size(A);
    assert(rows == cols, 'The matrix is not inversible because is not squared.');
    
    for i = 1:rows
        for j = 1:cols
            aux = A(i, j);
            if  ~isreal(aux) || ~isequal(round(aux),aux) || any(isinf(aux(:)))
                error('The element (%d, %d) is not an integer number.', i, j);
            end
        end
    end
    
    % Compute the modular determinant of A.
    A_determinant = int32(det(A));
    assert(A_determinant ~= 0, 'A determinant is 0.');
    assert(gcd(A_determinant, m) == 1, 'GCD(A_determinant, m) is not equal to 1.');
    
    modular_det= mod(A_determinant, m);
    
    % Get the inverse-modular determinant of A.
    [~, U, ~] = gcd(modular_det, m);
    
    % Compute the adjugate matrix of A.
    adjugate_matrix = adjoint(A);
    
    % Modular inverse of A.
    inver = adjugate_matrix * double(U);
    
    for i = 1:rows
        for j = 1:cols
            inver(i, j) = int32(mod(inver(i, j), m));
        end
    end

end