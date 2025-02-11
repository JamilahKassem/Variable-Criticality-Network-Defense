close all;clear;
R = randi([1 10],1,20);
R = sort(R,'descend');
Ns = 2:10;

Adversary_gain      = zeros(size(Ns,2),size(R,2));
Adversary_gain_FICC = zeros(size(Ns,2),size(R,2));
Adversary_gain_Feng = zeros(size(Ns,2),size(R,2));
MaxHitRate          = zeros(size(Ns,2),1);
MaxHitRate_FICC     = zeros(size(Ns,2),1);
MaxHitRate_Feng     = zeros(size(Ns,2),1);
MaxUtility          = zeros(size(Ns,2),1);
MaxUtility_FICC     = zeros(size(Ns,2),1);
MaxUtility_Feng     = zeros(size(Ns,2),1);
Moves               = zeros(size(Ns,2),1);
Moves_FICC          = zeros(size(Ns,2),1);
Moves_Feng          = zeros(size(Ns,2),1);
% Adversary_gain_new  = zeros(size(Ns,2),size(R,2));
% MaxUtility_new      = zeros(size(Ns,2),1);
% MaxHitRate_new      = zeros(size(Ns,2),1);
% Moves_new           = zeros(size(Ns,2),1);

k = 1;
for n = Ns
    alpha               = multiple_target(R,n);
    Adversary_gain(k,:) = max(alpha,[],2)';
    MaxHitRate(k)       = max(sum(alpha)) * sum(R)/size(R,2);
    Moves(k)            = sum(sum(alpha~=0,2) .* (sum(alpha~=0,2)~=1));
    MaxUtility(k)       = max(sum(alpha .* R'));

    alpha                    = Create_A_No_Criticality(size(R,2),n);
    Adversary_gain_FICC(k,:) = max(alpha,[],2)';
    MaxHitRate_FICC(k)       = max(sum(alpha)) * sum(R)/size(R,2);
    Moves_FICC(k)            = Moves_no_criticality(size(R,2),n);
    MaxUtility_FICC(k)       = max(sum(alpha .* R'));

    alpha                    = feng(size(R,2),n);
    Adversary_gain_Feng(k,:) = max(alpha,[],2)';
    MaxHitRate_Feng(k)       = max(sum(alpha)) * sum(R)/size(R,2);
    Moves_Feng(k)            = size(R,2)*n;
    MaxUtility_Feng(k)       = max(sum(alpha .* R'));
    k = k + 1;
end

Px=5;Py=4;mx=0;my=0;
h=figure;
plot(Ns,MaxUtility,'r-*');
hold on;
plot(Ns,MaxUtility_FICC,'b-+');
plot(Ns,MaxUtility_Feng,'g-o');
% plot(Ns,MaxUtility_new);
hold off;
lgd = legend('Proposed','Previous','Baseline');
% set(lgd,'position',[0.75,0.7,0.1,0.1])
xlabel('Number of Nodes');
ylabel('Maximum Attack Impact');
% title('Maximum Attack Impact From Defender Side','When Number of Nodes is Varied.');
ylim([0 inf])
set(h,'papersize',[Px Py]);
set(h, 'PaperPosition', [mx my Px Py]);
print(h,'impact_varying_n','-dpdf');

h=figure;
plot(Ns,MaxHitRate,'r-*');
hold on;
plot(Ns,MaxHitRate_FICC,'b-+');
plot(Ns,MaxHitRate_Feng,'g-o');
hold off;
lgd = legend('Proposed','Previous','Baseline');
xlabel('Number of Nodes');
ylabel('Maximum Attack Impact');
ylim([0 inf])
set(h,'papersize',[Px Py]);
set(h, 'PaperPosition', [mx my Px Py]);
print(h,'hit_rate_varying_n','-dpdf');

h=figure;
plot(Ns,Moves,'r-*');
hold on;
plot(Ns,Moves_FICC,'b-+');
plot(Ns,Moves_Feng,'g-o');
hold off;
lgd = legend('Proposed','Previous','Baseline');
set(lgd,'position',[0.75,0.6,0.1,0.1])
xlabel('Number of Nodes');
ylabel('Number of Moves');
ylim([0 inf])
set(h,'papersize',[Px Py]);
set(h, 'PaperPosition', [mx my Px Py]);
print(h,'moves_varying_n','-dpdf');