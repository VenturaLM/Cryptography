function code = hill_cipher(A, m, text)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    
    %Check if A has inverse mod(m).
    [u v] = size(A);
    if u ~= v
        disp('The matrix has to be square.');
        return
    end
    
    if gcd(det(A), m) ~= 1
        disp('The matrix is not valid.');
        return
    end
    
    A_inverse = inv_module(A, m);
    
    %TODO: divide the text in size(A) blocks.
    numbered_text = letter_number(text);
    disp(numbered_text)
    
    %Erase the last element if m is odd.
    l = length(numbered_text);
    while rem(l, u) ~= 0
        numbered_text(end) = [];
        l = l - 1;
    end
    
    %Reshape text into matrix:
    numbered_text = reshape(numbered_text, u, []);
    
    code = mod(A_inverse * numbered_text, m);
    code = reshape(code, 1, []);
    
    alphabet = 'abcdefghijklmnñopqrstuvwxyz';
    code = alphabet(code + 1);
end