function permute = permutation (p)
%PERMUTATION Checks if an input array is a permutation of {1, 2, ..., n}.
    %   PERMUTE = PERMUTATION(P) returns a boolean value: 1 if is a
    %   permutation; 0 if not.
    tic
    permute = 0;
    n = max(p); % Take the maximum element.
    sorted_input = sort(p); % Sort the input vector.
    comparison = linspace(1, n, n); 

    if isequal(sorted_input, comparison)
        permute = 1;
    end
    toc
end
