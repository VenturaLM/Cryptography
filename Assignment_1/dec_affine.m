function text = dec_affine(k,d,code)
    %DEC_AFFINE Decrypts a message previousle encrypted via Affine Cypher
    %(knowing the keys).
    %   TEXT = DEC_AFFINE(K, D, CODE) converts CDE to clean text in TEXT.
    tic
    
    if (d<0 || d>26)
        error("d should be a number between 0 and 26");
    end

    if (k<0 || k>26)
        error("K should be a number between 0 and 26");
    end

    if gcd(k,27) ~= 1
        error("The multiplicative key should satisfy gcd(d, 27) = 1.");
    end

    code = letter_number(code);

    for i = 1:length(code)
        [~,u,~] = gcd(k,27);
        u = mod(u,27);
        numbers(i) = mod(((code(i) - d) .* u), 27);
    end

    alphabet = 'abcdefghijklmnñopqrstuvwxyz';
    text = alphabet(numbers + 1);
    
    toc
end