close all;clear;
n = 5;
Tr = 50;
Ms = 10:20;

Adversary_gain      = zeros(size(Ms,2),1);
Adversary_gain_FICC = zeros(size(Ms,2),1);
Adversary_gain_Feng = zeros(size(Ms,2),1);
MaxUtility          = zeros(size(Ms,2),1);
MaxUtility_FICC     = zeros(size(Ms,2),1);
MaxUtility_Feng     = zeros(size(Ms,2),1);
Moves               = zeros(size(Ms,2),1);
Moves_FICC          = zeros(size(Ms,2),1);
Moves_Feng          = zeros(size(Ms,2),1);

Total_R             = zeros(size(Ms,2),1);

Number_of_samples = 100;
for z = 1:Number_of_samples
    k = 1;
    for m = Ms
        R = rand(1,m);
        R = round(R * Tr / sum(R));
        Total_R(k) = sum(R);
        while Total_R(k) < Tr 
            randomIndex = randi([1 size(R,2)],1,1);
            R(randomIndex) = R(randomIndex) + 1;
            Total_R(k) = sum(R);
        end
        while Total_R(k) > Tr
            randomIndex = randi([1 size(R,2)],1,1);
            R(randomIndex) = R(randomIndex) - 1;
            Total_R(k) = sum(R);
        end
        R = sort(R,'descend');
    
        alpha               = multiple_target(R,n);
        Adversary_gain(k)   = Adversary_gain(k) + max(sum(alpha)) * sum(R)/size(R,2);
        Moves(k)            = Moves(k) + sum(sum(alpha~=0,2) .* (sum(alpha~=0,2)~=1));
        MaxUtility(k)       = MaxUtility(k) + max(sum(alpha .* R'));
    
        alpha                   = Create_A_No_Criticality(size(R,2),n);
        Adversary_gain_FICC(k)  = Adversary_gain_FICC(k) + max(sum(alpha)) * sum(R)/size(R,2);
        Moves_FICC(k)           = Moves_FICC(k) + Moves_no_criticality(size(R,2),n);
        MaxUtility_FICC(k)      = MaxUtility_FICC(k) + max(sum(alpha .* R'));
    
        alpha                   = feng(size(R,2),n);
        Adversary_gain_Feng(k)  = Adversary_gain_Feng(k) + max(sum(alpha)) * sum(R)/size(R,2);
        Moves_Feng(k)           = Moves_Feng(k) + size(R,2)*n;
        MaxUtility_Feng(k)      = MaxUtility_Feng(k) + max(sum(alpha .* R'));
        
        k = k + 1;
    end
end
Adversary_gain      = Adversary_gain / Number_of_samples;
Moves               = Moves / Number_of_samples;
MaxUtility          = MaxUtility / Number_of_samples;
Adversary_gain_FICC = Adversary_gain_FICC / Number_of_samples;
Moves_FICC          = Moves_FICC / Number_of_samples;
MaxUtility_FICC     = MaxUtility_FICC / Number_of_samples;
Adversary_gain_Feng = Adversary_gain_Feng / Number_of_samples;
Moves_Feng          = Moves_Feng / Number_of_samples;
MaxUtility_Feng     = MaxUtility_Feng / Number_of_samples;


Px=5;Py=4;mx=0;my=0;
h=figure;
plot(Ms,MaxUtility,'r-*');
hold on;
plot(Ms,MaxUtility_FICC,'b-+');
plot(Ms,MaxUtility_Feng,'g-o');
hold off;
lgd = legend('Proposed','Previous','Baseline');
set(lgd,'position',[0.75,0.7,0.1,0.1])
xlabel('Number of Resources');
ylabel('Maximum Attack Impact');
ylim([0 inf])
set(h,'papersize',[Px Py]);
set(h, 'PaperPosition', [mx my Px Py]);
print(h,'impact_varying_m','-dpdf');

h=figure;
plot(Ms,Adversary_gain,'r-*');
hold on;
plot(Ms,Adversary_gain_FICC,'b-+');
plot(Ms,Adversary_gain_Feng,'g-o');
hold off;
lgd = legend('Proposed','Previous','Baseline');
set(lgd,'position',[0.75,0.7,0.1,0.1])
xlabel('Number of Resources');
ylabel('Maximum Attack Impact');
ylim([0 inf])
set(h,'papersize',[Px Py]);
set(h, 'PaperPosition', [mx my Px Py]);
print(h,'hit_rate_varying_m','-dpdf');

h=figure;
plot(Ms,Moves,'r-*');
hold on;
plot(Ms,Moves_FICC,'b-+');
plot(Ms,Moves_Feng,'g-o');
hold off;
lgd = legend('Proposed','Previous','Baseline');
set(lgd,'position',[0.75,0.7,0.1,0.1])
xlabel('Number of Resources');
ylabel('Number of Moves');
ylim([0 inf])
set(h,'papersize',[Px Py]);
set(h, 'PaperPosition', [mx my Px Py]);
print(h,'moves_varying_m','-dpdf');