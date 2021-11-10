function [factor_c, fact] = common_factors(w, s)
    %COMMON_FACTORS checks if a number w has common factors with each
    %element of an array.
    %   [FACTOR_C, FACT] = COMMON_FACTORS(W, S) returns:
    %       factor_c: boolean.
    %           - 0: no common factors.
    %           - 1: common factors.
    %       fact: array with the numbers that has common factors with w.
    
    tic
    
    s_length = length(s);
    fact = [];
    factor_c = 0;
    
    for i = 1:s_length
        f = gcd(w, s(i));
        
        if f ~= 1
            fact(end + 1) = s(i);
            
            if factor_c ~= 1
                factor_c = 1;
            end
        end
    end
    
    toc
end