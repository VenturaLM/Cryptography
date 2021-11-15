function pow = power_mod(b, e, m)
    %POWER_MOD Exponentiation by squaring.
    %   POW = POWER_MOD(B, E, M) returns:
    %       b: base. Natural number.
    %       e: exponent. Natural number.
    %       m: module. Natural number.
    
    %tic
    
    % Converts numbers to uint64 type.
    b = uint64(b);
    e = uint64(e);
    m = uint64(m);
    
    % Converts unicode to binary code.
    binary_e = dec2bin(e);
    binary_e = reshape(binary_e.',1,[])-'0';
    binary_e_size = length(binary_e);
    
    % Express the exponent in a base 2 summation.
    powers = [];
    for i = binary_e_size:-1:1
        if binary_e(i) == 1
            powers(end + 1) = binary_e_size - i;
        end
    end

    % Computer the powers from [ b^e^powers_0 , b^e^powers_n ].
    result = [];
    last_power = powers(end);
    % Line 32: Actually mod(b^(2^(0)), m), what is equal to mod(b, m).
    result(end + 1) = mod(b, m);

    for i = 1:last_power
        new_power = result(end) * result(end);
        result(end + 1) = mod(new_power, m);
    end

    powers_length = length(powers);
    % Since MATLAB's first element is 1, add to the first element + 1, so that 0 --> 1.
    powers = powers + 1;
    pow = 1;
    for i = 1:powers_length
        pow = mod( uint64(result(powers(i))) * uint64(pow), m );
    end

    %toc
end

