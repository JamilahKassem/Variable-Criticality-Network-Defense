function [matrix] = Matrix_Diagonal_ones(m,n)
    if m==0 || n==0
        matrix=ones(m,n);
    else
        matrix=zeros(m,n);
        if m==1 || n ==1
            matrix=ones(m,n);
        else
            min = m;
            if m>n
                min = n;
                matrix(n+1:m,1:n) = Matrix_Diagonal_ones(m-n,n);
            else
                matrix(1:m,m+1:n) = Matrix_Diagonal_ones(m,n-m);
            end
            for i=1:min
               matrix(i,i)=min;
            end
        end
    end
end

