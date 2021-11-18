function v = rsa_cipher(n, e, text)
    %RSA_CIPHER cipher a text string following the RSA cipher using the
    %public key (n, e)
    %   V = RSA_CIPHER(N, E, TEXT) returns the cryptogram.
    %   - n: parameter n of RSA cipher.
    %   - e: parameter e of RSA cipher.
    %   - text: text to cipher.
    
    % Convert text to numbers.
    numbered_text = letter_2numbers(text);
    
    % Rearrange the number string into blocks of size digits(n) - 1.
    blocks_size = length(num2str(n)) - 1;
    blocks = prepare_num_cipher(blocks_size, numbered_text);
    
    v = [];
    % Cipher each block.
    % FIXME: Al ejecutar el ejemplo dado, el último elemento del
    % criptograma da un número incorrecto.
    for i = 1:length(blocks)
        v(end + 1) = power_mod(blocks(i), e, n);
    end
end

