function man_in_the_middle
    %MAN_IN_THE_MIDDLE Function that shows the man in the middle attack to
    %Diffie-Hellman keys exchange.
    %   - g and p required by user.
    %   - Agent A and B have to choose a number between [2, p - 2] and has to send
    %   its proper power to each other. Meanwhile, an agent C is
    %   intercepting them.
    %   - C chooses a number between [2, p - 2] and interacts with A and B,
    %   pretending their identities.
    %   - A and C should obtain a similar key.
    %   - B and C should obtain another similar key.
    
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
    
    % Agent C:
    fprintf('C intercepts %d from A and %d from B and saves these numbers.', a_key, b_key);
    c = input( sprintf('C should introduce its private number between 2 and %d:\n> ', p - 2));
    c_key = power_mod(g, c, p);
    fprintf('C sends to A and B power_mod(%d, %d, %d) = %d\n\n', g, b, p, c_key);
    
    fprintf('B thinks he has received such number from A and A from b.\n\n');
    
    % Both, A and B agents:
    disp('AGENTS A AND B');
    %   A:
    pow = power_mod(c_key, a, p);
    fprintf('A obtains power_mod(%d, %d, %d) = %d\n', c_key, a, p, pow);
    %   B:
    pow = power_mod(c_key, b, p);
    fprintf('B obtains power_mod(%d, %d, %d) = %d\n\n', c_key, b, p, pow);
    
    % Agent C:
    disp('AGENT C');
    pow = power_mod(a_key, c, p);
    fprintf('For A computes power_mod(%d, %d, %d) = %d\n', a_key, c, p, pow);
    pow = power_mod(b_key, c, p);
    fprintf('For B computes power_mod(%d, %d, %d) = %d\n', b_key, c, p, pow);
    
    toc
    return;
end

