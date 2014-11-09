results = load('table_var');
table = results.table;

nGammas =  size(table,2);
gammas = zeros(1,nGammas);
variances = zeros(1,nGammas);
nTraces = zeros(1,nGammas);

for i = 1:nGammas
    gammas(i) = table(1,i).gamma;
    variances(i) = table(1,i).Qvar;
    nTraces(i) = table(1,i).nMean;
end

figure(1)
[ax,hBar,hStem] = plotyy(1:length(gammas),variances,1:length(gammas),nTraces,'bar','stem');
set(hBar,'FaceColor', [0 0 1]);
set(hStem,'LineWidth', 2);
set(hStem,'MarkerSize', 5);
set(hStem,'Color', [0,0.7,0]);
set(ax(1),'XTick',1:length(gammas));
set(ax(2),'XTick',1:length(gammas));
set(ax(1),'XTickLabel',gammas);
set(ax(2),'XTickLabel',gammas);
xlabel('\gamma', 'FontSize', 14, 'FontWeight','bold')
ylabel(ax(1),'Variance','FontSize', 14, 'Color',[0,0,1], 'FontWeight','bold')
ylabel(ax(2),'Number of traces', 'FontSize', 14, 'Color',[0,0.7,0],'FontWeight','bold')

results = load('tableEpsilon2');
tableEpsilon = results.tableEpsilon;
nEpsilons =  size(tableEpsilon,2);
epsilons = zeros(1,nEpsilons);
optimalActionPerc = zeros(1,nEpsilons);
nBatches = zeros(1,nEpsilons);

A = 4; % number of actions
S = 9; % number of non-absorbing states
OptimalPolicy = [0 1 0 0; % s1  E
                 0 1 0 0; % s2  E
                 0 1 0 0; % s3  E
                 0 0 0 0; % s4
                 1 0 0 0; % s5  N
                 1 0 0 0; % s6  N
                 0 0 0 0; % s7
                 1 0 0 0; % s8  N
                 0 1 0 0; % s9  E
                 1 0 0 0; % s10 N
                 0 0 0 1;]% s11 W
for i = 1:nEpsilons
    epsilons(i) = tableEpsilon(1,i).epsilon;
    difPolicies = (1/4)*(OptimalPolicy - tableEpsilon(1,i).OptimalPolicy);
    optimalActionPerc(i) = 100 *( 1 - (1/S)*(sum(sum(abs(difPolicies)))));
    nBatches(i) = tableEpsilon(1,i).NMax;
end

figure(2)
[ax,hBar,hStem] = plotyy(1:length(epsilons),optimalActionPerc,1:length(epsilons),nBatches,'bar','stem');
%text((1:length(epsilons))', optimalActionPerc',num2str(optimalActionPerc'), 'HorizontalAlignment','center', 'Color',[0,1,1]);
text((1:length(epsilons))', nBatches',num2str(nBatches'), 'HorizontalAlignment','center', 'VerticalAlignment','baseline','Color',[0,0,0],'FontSize', 12);
set(hBar,'FaceColor', [0 0.5 1]);
set(hStem,'LineWidth', 2);
set(hStem,'MarkerSize', 5);
set(hStem,'Color', [0,0.7,0]);
set(ax(1),'XTick',1:length(epsilons));
set(ax(2),'XTick',1:length(epsilons));
set(ax(1),'XTickLabel',epsilons);
set(ax(2),'XTickLabel',epsilons);
xlabel('\epsilon', 'FontSize', 14, 'FontWeight','bold')
ylabel(ax(1),'Percentage of Optimal Action','FontSize', 14, 'Color',[0,0.5,1], 'FontWeight','bold')
ylabel(ax(2),'Number of batches', 'FontSize', 14, 'Color',[0,0.7,0],'FontWeight','bold')