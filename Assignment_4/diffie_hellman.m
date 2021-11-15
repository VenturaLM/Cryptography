function diffie_hellman
    %DIFFIE_HELLMAN Computes Diffie-Hellman key exchange.
    %   - g and p required by user.
    %   - Agent A has to choose a number between [2, p - 2] and has to send
    %   its proper power.
    %   - Agent B analogously.
    %   - Both, A and B get the shared key.
    
    tic
    
    disp('COMMON ELEMENTS');
    p = input('Introduce a prime number p:\n> ');
    
    if isprime(p) == 0
        error('%d is not a primer number.\n', p);
    end
    
    g = input( sprintf('Introduce a generator g of the multiplicative group determine by %d:\n> ', p));
    
    gen = generate(g, p);
    if gen == 0
        error('%d is not a generator of F%d*', g, p);
        return;
    end
    
    % Agent A:
    %   2 <= a <= (p - 2)
    %   g^a mod p
    disp('AGENT A');
    a = input( sprintf('A should introduce its private number between 2 and %d:\n> ', p - 2));
    a_key = power_mod(g, a, p);
    fprintf('A sends to B power_mod(%d, %d, %d) = %d\n\n', g, a, p, a_key);
    
    % Agent B:
    %   2 <= b <= (p - 2)
    %   g^b mod p
    disp('AGENT B');
    b = input( sprintf('B should introduce its private number between 2 and %d:\n> ', p - 2));
    b_key = power_mod(g, b, p);
    fprintf('B sends to A power_mod(%d, %d, %d) = %d\n\n', g, b, p, b_key);
    
    % Both agents:
    disp('BOTH AGENTS');
    %   A:
    pow = power_mod(b_key, a, p);
    fprintf('A obtains power_mod(%d, %d, %d) = %d\n', b_key, a, p, pow);
    %   B:
    pow = power_mod(a_key, b, p);
    fprintf('B obtains power_mod(%d, %d, %d) = %d\n', a_key, b, p, pow);
    
    toc
    return;
end

