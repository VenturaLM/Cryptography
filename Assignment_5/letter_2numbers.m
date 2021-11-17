function double = letter_2numbers(text)
    %LETTER_2NUMBERS converts the letters of a string to a number asociated
    %to the spanish alphabet.
    %   DOUBLE = LETTER_2NUMBERS(TEXT) converts TEXT to string of numbers.
    
    text = lower(text);
    text_length = length(text);
    double = '';

    % Create a map with the alphabet.
    %   Reference: https://es.mathworks.com/help/matlab/ref/containers.map.html
    keySet = ...
        {'a', 'b', 'c', 'd', ...
         'e', 'f', 'g', 'h', ...
         'i', 'j', 'k', 'l', ...
         'm', 'n', char(241), 'o', ...
         'p', 'q', 'r', 's', ...
         't', 'u', 'v', 'w', ...
         'x', 'y', 'z'};
    valueSet = cellstr(num2str((0:26).', '%02d'));
    alphabet = containers.Map(keySet, valueSet);

    % Concatenate the numbers asociated to the text if, and only if, the element is a key of the map (alphabet).
    for i = 1:text_length
        letter = text(i);
        switch letter
            case char(225) % á
                letter = 'a';
            case char(233) % é
                letter = 'e';
            case char(237) % í
                letter = 'i';
            case char(243) % ó
                letter = 'o';
            case char(250) % ú
                letter = 'u';
        end
        
        if isKey(alphabet, letter)
            double = strcat(double, alphabet(letter));
        end
    end

end

