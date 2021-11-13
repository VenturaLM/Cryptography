function s = crypt_shamir_zippel(publ_k, mu)
    %KNAPSACK_MH
    %   [PUBL_K, PRIV_K] = KNAPSACK_MH(S)
    
    tic
    
    publ_k_size = length(publ_k);
    [~, U, ~] = gcd(publ_k(2), mu);
    b2_inv = mod(U, mu);
    q = mod(publ_k(1)*b2_inv, mu);
    
    counter = 0;
    lower = 1;
    
    while 1
        
        % Find { q, 2q, ..., 2^(n+1) } mod (mu).
        range = 2^(publ_k_size + 1) * 2^counter;
        q_array = [range];

        for i = lower:range
            q_array(end + 1) = mod(i * q, mu);
        end
        
        % Sort { q, 2q, ..., 2^(n+1) } mod (mu).
        q_array = sort(q_array);

        % Take the first candidate a_{1} from q_array.
        q_array_size = length(q_array);

        for i = 1:q_array_size
            [~, U, ~] = gcd(q_array(i), mu);
            w = mod(publ_k(1) * mod(U, mu), mu);
            
            if w ~= 0
                break;
            end
        end

        % Find multiplicative factor w.
        [~, U, ~] = gcd(w, mu);
        w_inv = mod(U, mu);
    
        % Potential simple knapsack.
        priv_k = [];
        priv_k(end + 1) = q_array(1);
        for i = 2:publ_k_size
            priv_k(end + 1) = mod(w_inv * publ_k(i), mu);
        end

        s = priv_k;
        valide = knapsack(s);

        % Checks if s is a valid knapsack.
        fprintf('Searched multiples in the rank [%d, %d].\n\n', lower, range);
        disp('-----------------------------------------------------');
        if valide == -1 || valide == 0
            warning('The input is not a simple knapsack.\n');
            selection = input('Do you want to continue with a bigger interval? (Y/N): ', 's');
            selection = upper(selection);
            
            if selection == 'N'
                s = -1;
                return
            end
        else
            return
        end
        
        counter = counter + 1;
        lower = range;
    end
    
    toc
end