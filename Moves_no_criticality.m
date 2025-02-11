function [Nm] = Moves_no_criticality(m,n)
    if m<2 || n < 2
        Nm = m * n;
    else
        if m>n
            Nm = n;
            Nm = Nm + Moves_no_criticality(m-n,n);
        else
            Nm = m;
            Nm = Nm + Moves_no_criticality(m,n-m);
        end
    end
end

