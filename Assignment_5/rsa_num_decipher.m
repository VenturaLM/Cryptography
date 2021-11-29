function v = rsa_num_decipher(n, d, code)
    %RSA_NUM_DECIPHER Deciphers a numerical array following the RSA system,
    %given a private key.
    %   V = RSA_NUM_DECIPHER(N, D, CODE) returns a numerical array.
    %   - n and d: private key values.
    %   - code: ciphered numerical array.
    
    % Decipher function: code(i)^(d) = x mod(n).
    code_length = length(code);
    assert(code_length > 0, 'The cryptogram is empty.');
    v = zeros(1, code_length);
    
    for i = 1:code_length
        v(i) = power_mod(code(i), d, n);
    end
    
end

