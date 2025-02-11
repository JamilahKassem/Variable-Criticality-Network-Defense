function [A] = Create_A_No_Criticality(m,n)
A=zeros(m,n);
alpha=1/(n*(ceil(m/n)));
m_mod_n=mod(m,n);
left_size=ceil(m/n)*m_mod_n;
repeat=(m-left_size)/(n-m_mod_n);
for k=1:m_mod_n
    for i=1:left_size
        if(i>(k-1)*ceil(m/n)&&i<=k*ceil(m/n))
            A(i,k)=m*alpha;
        end
    end
end
for k=1:n-m_mod_n
    for i=1:m-left_size
        if(i>(k-1)*repeat&&i<=k*repeat)
            A(i+left_size,k+m_mod_n)=1;
        end
    end
end
A=A';
A(m_mod_n+1:n,1:left_size)=alpha*Matrix_Diagonal_ones(n-m_mod_n,left_size);
A=A';
end

