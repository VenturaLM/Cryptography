function  affine_cryptanalysis(v)
    %AFFINE_CRYPTOANALYSIS Cryptoanalyses an encrypted message through
    %Afine Cypher, without keys.
    tic
    
    compare = bars(v);

    for i = 1:height(compare)
        for j = 1:5
            if i ~= j
                M = [compare(i,2), 1; compare(j,2), 1];

                m = det(M);
                if  floor(m)==ceil(m)
                    if gcd(m,27) == 1
                        invM = inv_module(M, 27);
                    end
                end

                aux = [compare(1,4);compare(2,4)];

                KD = invM * aux;
                text = dec_affine(mod(KD(1),27), mod(KD(2),27), v);

                disp("k = " + KD(1));
                disp("d = " + KD(2));
                disp(text);

                x = input('If you want to prove with different keys write 1, otherwise write 0: ');
                if x == 0
                    return;
                end
            end
        end
    end
    
    toc
end