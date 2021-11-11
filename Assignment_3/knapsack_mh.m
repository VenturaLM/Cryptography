function [publ_k, priv_k] = knapsack_mh(s)
    %KNAPSACK_MH
    %   [PUBL_K, PRIV_K] = KNAPSACK_MH(S)
    
    tic
    
    valide = knapsack(s);
    s_length = length(s);
    sum_of_s = sum(s);
    
    % Checks if s is a valid knapsack.
    if valide == -1
        error('The input is not a knapsack.');
        return;
    end
    
    prompt = sprintf('Introduce the value mu, a natural number greater than %s:\n> ', string(sum_of_s));
    mu = input(prompt);
    
    % Random value generator.
    rng(0, 'twister');
    
    % Check mu constraint.
    if mu <= sum_of_s
        mu = randi([sum_of_s, sum_of_s * 256], 1, 1);
        warning('The value of mu was not valid. It was stablished to %d.', mu);
    end
    
    priv_k = [];
    priv_k(end + 1) = mu;
    
    flag = 1;
    while flag == 1
        % Existing x in range [2, mu - 2].
        x = randi([2, mu - 2], 1, 1);
        w = x / gcd(mu, x);
        
        [G, U, V] = gcd (w, mu);
        if G == 1
            [flag, factor] = common_factors(w, s);
            priv_k(end + 1) = U;
            break;
        end
    end
    
    publ_k = [];
    for i = 1:s_length
        publ_k(end + 1) = mod( (w * s(i) ), mu);
    end
    
    toc
end