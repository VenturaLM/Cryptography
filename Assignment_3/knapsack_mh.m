function [publ_k, priv_k] = knapsack_mh(s)
    %KNAPSACK_MH
    %   [PUBL_K, PRIV_K] = KNAPSACK_MH(S)
    
    tic
    
    valide = knapsack(s);
    s_length = length(s);
    
    % Checks if s is a valid knapsack.
    if valide == -1
        error('The input is not a knapsack.');
        return;
    end
    
    toc
end