function s = crypt_shamir_zippel(publ_k, mu)
    %KNAPSACK_MH
    %   [PUBL_K, PRIV_K] = KNAPSACK_MH(S)
    
    tic
    
    publ_k_size = length(publ_k);
    [G, U, V] = gcd(publ_k(2), mu);
    b2_inv = mod(U, mu);
    q = mod(publ_k(1)*b2_inv, mu);
    
    q_array = [2^(publ_k_size + 1)];
    
    counter = 0;
    while 1
        
        % Find { q, 2q, ..., 2^(n+1) } mod (mu).
        range = 2^(publ_k_size + 1) * 2^counter;
        for i = 2^(publ_k_size + 1) * counter + 1:range
            q_array(end + 1) = mod((2^(publ_k_size + 1) * counter) + i * q, mu);
        end

        % Sort { q, 2q, ..., 2^(n+1) } mod (mu).
        q_array = sort(q_array);

        % Take the first candidate a_{1}.
        [G, U, V] = gcd(q_array(1), mu);
        w = mod(publ_k(1) * mod(U, mu), mu);

        % Find multiplicative factor w.
        % TODO: w no tiene inverso a partir de una iteracion.
        [G, U, V] = gcd(w, mu);
        w_inv = mod(U, mu);

        % Potential simple knapsack.
        priv_k = [];
        priv_k(end + 1) = q_array(1);
        for i = 2:publ_k_size
            priv_k(end + 1) = mod(w_inv * publ_k(i), mu);
        end

        s = priv_k;
        valide = knapsack(s);
disp(s);
        % Checks if s is a valid knapsack.
        if valide == -1 || valide == 0
            warning('The input is not a simple knapsack.\n');
            %selection = input('Do you want to continue with a bigger interval? (Y/N): ', 's');
            selection = 1;
            if selection == 'N'
                s = -1;
                return
            end
            fprintf('Searched multiples in the rank [%d, %d].\n\n', 2^(publ_k_size + 1) * counter + 1, range);
        else
            return
        end
        
        counter = counter + 1;
    end
    
    toc
end