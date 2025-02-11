function [alpha] = single_target(R,n)
m = size(R,2);
alpha = zeros(m,n);

TR = 0;
for r=R
    TR = TR + r;
end

LimitR = TR / n;
for i=1:m
    if R(i) < LimitR
        break;
    end
end

i = i - 1;
RH = zeros(1,i);
Rl = zeros(1,size(R,2)-i);
AverageH = 0;
Averagel = 0;

h = 1;
l = 1;
for i=1:m
    if R(i) < LimitR
        Rl(l) = R(i);
        Averagel = Averagel + R(i);
        l = l + 1;
    else
        RH(h) = R(i);
        AverageH = AverageH + R(i);
        h = h + 1;
    end
end
AverageH = AverageH / size(RH,2);
Averagel = Averagel / size(Rl,2);

aH = (TR - n * Averagel) / (n * (AverageH - Averagel));

k = 1;
while k < (size(Rl,2) / (1 - aH))
    for i = 1:size(RH,2)
        alpha(i,k) = aH/(size(RH,2));
    end
    for i = size(RH,2)+1:m
        alpha(i,k) = (1-aH)/(size(Rl,2));
    end
    k = k + 1;
end
temp = mod(1,(1-aH)/(size(Rl,2)));
for i = size(RH,2)+1:m
    alpha(i,k) = temp;
end
temp2 = ((TR/n) - Averagel * size(Rl,2) * temp) / (size(RH,2) * AverageH);
for i = 1:size(RH,2)
    alpha(i,k) = temp2;
end

k = k + 1;
i = 1;
RemainingAlpha = 1 - sum(alpha(i,:));
Ck = TR / n;
while k <= n && i < size(RH,2)
    while RemainingAlpha <= 0 && i < size(RH,2)
        i = i + 1;
        RemainingAlpha = 1 - sum(alpha(i,:));
    end
    if RemainingAlpha >= Ck/R(i)
        alpha(i,k) = Ck/R(i);
        RemainingAlpha = RemainingAlpha - alpha(i,k);
        k = k + 1;
        Ck = TR / n;
    else
        alpha(i,k) = RemainingAlpha;
        Ck = Ck - RemainingAlpha * R(i);
        RemainingAlpha = 0;
    end
end
end

