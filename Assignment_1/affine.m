function code = affine(k,d,text)
    %AFFINE Encrypts a message with Afine Cypher.
    %   CODE = AFFINE(K, D, TEXT) converts TEXT to an encrypted message
    %   with keys k and d.
    tic
    
    if (k<0 || k>26)
        error("The multiplicative key should satisfy gcd(k, 27) = 1.");
    end

    if gcd(k,27) ~= 1
        error("gcd(k, 27) ~= 1");
    end

    if (d<0 || d>26)
        error("The multiplicative key should satisfy gcd(d, 27) = 1.");
    end

    code = [];
    code = letter_number(text);

    for i = 1:length(code)
        code(i) = mod((code(i) * k + d), 27);
    end
    
    toc
end
