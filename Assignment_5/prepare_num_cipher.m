function v = prepare_num_cipher(d, double)
    %PREPARE_NUM_CIPHER Converts a numerical string in blocks of a given
    %size. Then, the blocks are converted into numbers and get stored in an
    %array.
    %   V = PREPARE_NUM_CIPHER(D, DOUBLE) returns an array that contains
    %   the numbers corresponding to each of the blocks.
    %   - d: block size. Natural number.
    %   - double: numeric string.
    
    double_length = length(double);
    
    while rem(double_length, d) ~= 0
        double = strcat(double, '0');
        double_length = double_length + 1;
    end
    
    v = str2num(reshape(double, d, [])');
    v = reshape(v, 1, length(v));

end

