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
    g = input( sprintf('Introduce a generator g of the multiplicative group determine by %d:\n> ', p), 's');
    
    gen = generate(g, p);
    %TODO: MATLAB imprime un error en la función power_mod().
    
    return;
    toc
end

