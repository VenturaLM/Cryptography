function inver = inv_module(A, m)
    %INV_MODULE 

    if  ~isreal(m) || ~isequal(round(m),m) || any(isinf(m(:)))
        error('All the elements should be integer numbers.')
    end

    [rows, columns] = size(A);

    for i = 1:rows
        for j = 1:columns
            aux = A(i,j);
            if  ~isreal(aux) || ~isequal(round(aux),aux) || any(isinf(aux(:)))
                error('All the elements should be integer numbers.')
            end
        end
    end

    %Calculate Matrix determinant of a square matrix A of size m × m 
    md = moddet(A, m);

    %Greatest common divisor in module
    if m==0
        r = md;
    else
        r = gcd(m,mod(md,m));
    end

    if(r == 1)
        %Multiplicative Inverse of a in Zn
        r1=m;
        r2=md;
        t1=0;
        t2=1;
        while(r2>0)
            q=fix(r1/r2);
            r=mod(r1,r2);
            t=t1-q*t2;
            r1=r2;
            r2=r;
            t1=t2;
            t2=t;
        end    

        %Inverse of A
        matrix=size(A,1);
        for i=1:matrix
            for j=1:matrix
                Aij=A;
                Aij((i),:)=[];
                Aij(:,(j))=[];         
                C(i,j)=(-1)^(i+j)*moddet(Aij,m);
            end
        end
        inver=mod(t1*C',m);
    else
        error('The matrix is not inversible with the given module.')
    end
end