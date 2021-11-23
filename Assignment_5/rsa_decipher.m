function text = rsa_decipher(n, d, code)
    %RSA_DECIPHER Deciphers a numerical array, using the RSA system, given
    %a private key.
    %   TEXT = RSA_DECIPHER(N, D, CODE) returns the clear text.
    %   - n and d: private keys.
    %   - code: ciphered numerical array.
    
    text = '-';
    v = rsa_num_decipher(n, d, code);
    
    text = num_decipher(n, v);
    
end

