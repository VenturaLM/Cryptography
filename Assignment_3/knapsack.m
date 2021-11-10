function valide = knapsack(s)
    %KNAPSACK analyzes if a row vector is a simple knapsack.
    %   VALIDE = KNAPSACK(S) returns:
    %       -1: if input is not a knapsack.
    %       0: if input is a knapsack, but not a simple one.
    %       1: if input is a simple knapsack.
    
    tic
    if size(s) ~= 1
        valide = -1;
        return;
    end
    
    s_length = length(s);
    
    if sum(s > 0) ~= s_length || sum(mod(s, 1) ~= 0)
        valide = -1;
        return;
    end
    
    valide = 1;
    counter = 0;
    
    for i = 1:s_length
        if counter >= s(i)
            valide = 0;
        end
        
        counter = counter + s(i);
    end
    
    toc
end

