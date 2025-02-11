function [alpha] = multiple_target(R,n)
m = size(R,2);
alpha = zeros(m,n);
TR = 0;
for r=R
    TR = TR + r;
end

i = 1;
k = 1;
Ar = 1;
TRB = 0;
while i <= m && k <= n
    kl = ceil(n*(TRB + R(i))/TR);
    while k < kl
        alpha(i,k) = TR/(n*R(i));
        Ar = Ar - alpha(i,k);
        k = k + 1;
    end
    alpha(i,k) = Ar;
    TRB = TRB + R(i);
    if i < m
        i = i + 1;
        k = floor(n*TRB/TR) + 1;
        alpha(i,k) = (TR - mod(n*TRB,TR))/(n*R(i));
        while alpha(i,k) > 1
            alpha(i,k) = 1;
            TRB = TRB + R(i);
            i = i + 1;
            alpha(i,k) = (TR - mod(n*TRB,TR))/(n*R(i));
        end
        Ar = 1 - alpha(i,k);
        if Ar >= 0
            k = k + 1;
        end
    end
end
end

