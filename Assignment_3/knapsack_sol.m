function [v, valide] = knapsack_sol(s, obj)
    %KNAPSACK_SOL checks if a knapsack has unique solution.
    %   [V, VALIDE] = KNAPSACK_SOL(S, OBJ) returns:
    %   v: array with the values that fits the unique solution.
    %   valide:
    %       -1: if input is not a knapsack.
    %       0: if input is a knapsack, but not a simple one.
    %       1: if input is a simple knapsack.
    tic
    valide = knapsack(s);
    s_length = length(s);
    v = 0;
    
    if valide == 0 || valide == -1
        error('The input is not a knapsack.');
        return;
    end

    for i = s_length:-1:1
        if obj >= s(i)
            v(i) = 1;
        else
            v(i) = 0;
        end
        
        obj = obj - v(i) * s(i);
    end
    
    if obj ~= 0
        error('No solution found');
    end
    toc
end

