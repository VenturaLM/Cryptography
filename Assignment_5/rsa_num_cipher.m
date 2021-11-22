function v = rsa_num_cipher(n, e, blocks)
    %RSA__NUM_CIPHER cipher the blocks of numbers following the RSA cipher
    %using the public key (n, e)
    %   V = RSA_NUM_CIPHER(N, E, BLOCKS) returns the cryptogram.
    %   - n: parameter n of RSA cipher.
    %   - e: parameter e of RSA cipher.
    %   - blocks: array of numbers (blocks).
    
    % Cipher each block.
    blocks_length = length(blocks);
    v = zeros(1, blocks_length);
    
    for i = 1:blocks_length
        v(i) = power_mod(blocks(i), e, n);
    end
end
