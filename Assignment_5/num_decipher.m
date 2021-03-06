function text = num_decipher(n, blocks)
    %NUM_DECIPHER Converts a numerical array into a char array (using 2
    %digits per character). To do this, complete the blocks with 0's to 
    %the left so that they all have length = [digits(n) − 1], concatenate them,
    %group them two by two, eliminate the possible 30's and / or 0's that 
    %may be at the end and go to letters.
    %   TEXT = NUM_DECIPHER(N, BLOCKS) returns a text string.
    %   - n: natural number needed to determine the length of the blocks.
    %   - blocks: numerical array.
    
    text = '-';
    blocks_length = length(blocks);
    assert(blocks_length > 0, 'Input blocks parameter is empty.');
    blocks_size = length(num2str(n)) - 1;
    
    % Auxiliar blocks in char type.
    char_blocks = [];
    
    % Specific format for [digits(n) - 1] char arrays.
    format = strcat( strcat('%0', num2str(blocks_size)), '.f');

    % Add 0's for each block in blocks array.
    for i = 1:blocks_length
        if length(blocks(i)) < blocks_size
            tmp = num2str(blocks(i), format);
            char_blocks = strcat(char_blocks, tmp);
        end
    end
    
    % Group them two by two.
    char_blocks = reshape(char_blocks, 2, [])';
    
    % Eliminate the possible 30's and / or 0's that may be at the end.
    char_blocks_length = length(char_blocks);
    
    if rem(char_blocks_length, 2) ~=0
        char_blocks(end) = [];
    end
    
    while char_blocks(end, :) == '30'
        char_blocks(end, :) = [];
    end

    % Convert numbers to letters.
    alphabet = 'abcdefghijklmnnopqrstuvwxyz';
    alphabet(15) = char(241);
    text = alphabet(str2num(char_blocks) + 1);
    
end

