close all;clear;
n = 5;
step = 5;
max_deviation = 40;
Deviations = 0:step:max_deviation-step;

Adversary_gain      = zeros(size(Deviations,2),1);
Adversary_gain_FICC = zeros(size(Deviations,2),1);
Adversary_gain_Feng = zeros(size(Deviations,2),1);
MaxUtility          = zeros(size(Deviations,2),1);
MaxUtility_FICC     = zeros(size(Deviations,2),1);
MaxUtility_Feng     = zeros(size(Deviations,2),1);
Moves               = zeros(size(Deviations,2),1);
Moves_FICC          = zeros(size(Deviations,2),1);
Moves_Feng          = zeros(size(Deviations,2),1);
Adversary_gain_new  = zeros(size(Deviations,2),1);
MaxUtility_new      = zeros(size(Deviations,2),1);
Moves_new           = zeros(size(Deviations,2),1);
stand_deviation     = zeros(size(Deviations,2),1);

Total_R             = zeros(size(Deviations,2),1);
Rs                  = zeros(size(Deviations,2),20);

Tr = max_deviation * 20;

Number_of_samples = 100;
for z = 1:Number_of_samples

    k = 1;
    Set = 0.1 + rand(1,10);
    Temp = mean(Set);
    while Temp < 1 / 4 || Temp > 3 / 4
        Set(1:10) = rand(1,10);
        Temp = mean(Set);
    end
    
    for j = Deviations
        stand_deviation(k) = -100;
    
        R(1:10) = (max_deviation + j) / 2 + (max_deviation - j) / 2 * Set;
        R(11:20) = (max_deviation - j) / 2 * Set;
    
        R = round(R * Tr / sum(R));
        R = sort(R,'descend');
        Rs(k,:) = R;
        stand_deviation(k) = std(R);
        Total_R(k) = sum(R);
    
        alpha               = multiple_target(R,n);
        Adversary_gain(k)   = Adversary_gain(k) + max(sum(alpha)) * sum(R)/size(R,2);
        Moves(k)            = Moves(k) + sum(sum(alpha~=0,2) .* (sum(alpha~=0,2)~=1));
        MaxUtility(k)       = MaxUtility(k) + max(sum(alpha .* R'));
    
        alpha                   = multiple_target_new(R,n);
        Adversary_gain_new(k)   = Adversary_gain_new(k) + max(sum(alpha)) * sum(R)/size(R,2);
        Moves_new(k)            = Moves_new(k) + sum(sum(alpha~=0,2) .* (sum(alpha~=0,2)~=1));
        MaxUtility_new(k)       = MaxUtility_new(k) + max(sum(alpha .* R'));
    
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
Adversary_gain          = Adversary_gain / Number_of_samples;
Moves                   = Moves / Number_of_samples;
MaxUtility              = MaxUtility / Number_of_samples;
Adversary_gain_FICC     = Adversary_gain_FICC / Number_of_samples;
Moves_FICC              = Moves_FICC / Number_of_samples;
MaxUtility_FICC         = MaxUtility_FICC / Number_of_samples;
Adversary_gain_Feng     = Adversary_gain_Feng / Number_of_samples;
Moves_Feng              = Moves_Feng / Number_of_samples;
MaxUtility_Feng         = MaxUtility_Feng / Number_of_samples;
Adversary_gain_new      = Adversary_gain_new / Number_of_samples;
Moves_new               = Moves_new / Number_of_samples;
MaxUtility_new          = MaxUtility_new / Number_of_samples;

Px=5;Py=4;mx=0;my=0;
h=figure;
plot(stand_deviation,MaxUtility,'r-*');
hold on;
plot(stand_deviation,MaxUtility_FICC,'b-+');
plot(stand_deviation,MaxUtility_Feng,'g-o');
hold off;
lgd = legend('Proposed','Previous','Baseline');
lgd.Location = "southeast";
xlabel('Standard Deviation');
ylabel('Maximum Attack Impact');
ylim([0 inf])
set(h,'papersize',[Px Py]);
set(h, 'PaperPosition', [mx my Px Py]);
print(h,'impact_varying_deviations','-dpdf');

h=figure;
plot(stand_deviation,Adversary_gain,'r-*');
hold on;
plot(stand_deviation,Adversary_gain_FICC,'b-+');
plot(stand_deviation,Adversary_gain_Feng,'g-o');
hold off;
lgd = legend('Proposed','Previous','Baseline');
lgd.Location = "southeast";
xlabel('Standard Deviation');
ylabel('Maximum Attack Impact');
ylim([0 inf])
set(h,'papersize',[Px Py]);
set(h, 'PaperPosition', [mx my Px Py]);
print(h,'hit_rate_varying_deviations','-dpdf');

h=figure;
plot(stand_deviation,Moves,'r-*');
hold on;
plot(stand_deviation,Moves_FICC,'b-+');
plot(stand_deviation,Moves_Feng,'g-o');
hold off;
lgd = legend('Proposed','Previous','Baseline');
set(lgd,'position',[0.75,0.6,0.1,0.1])
xlabel('Standard Deviation');
ylabel('Number of Moves');
ylim([0 inf])
set(h,'papersize',[Px Py]);
set(h, 'PaperPosition', [mx my Px Py]);
print(h,'moves_varying_deviations','-dpdf');