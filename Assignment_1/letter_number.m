function num = letter_number(text)
    %LETTER_NUMBER converts the letters of a string to a number asociated
    %to an alphabet.
    %   NUM = LETTER_NUMBER(TEXT) converts TEXT to an array of integers stored in NUM.
    tic
    
    n = length(text);
    num = []

    alphabet = 'abcdefghijklmnnopqrstuvwxyz';
    
    text = lower(text);
    alphabet(15) = char(241); %Change the element 15 of the alphabet (n) to (ñ).
    
    m = length(alphabet);
    
    for i = 1:n
        for j = 1:m
            if text(i) == alphabet(j)
                num = [num,j - 1];
                break
            end
        end
    end
    
    toc
end