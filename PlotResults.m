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

% figure(1)
% bar(floor(variances));
% set(gca,'XTick',1:length(floor(variances)))
% set(gca,'XTickLabel',gammas)
% ylabel('Variance')
% xlabel('\gamma')
% title('Maximum variance in the estimation of Q(s,a)')
% axis tight

figure(2)
[ax,hBar,hStem] = plotyy(1:length(gammas),variances,1:length(gammas),nTraces,'bar','stem');
%[ax,hBar,hStem] = plotyy(gammas,variances,gammas,nTraces,'bar','stem');
set(hBar,'FaceColor', [0 0 1]);
set(hStem,'LineWidth', 2);
set(hStem,'MarkerSize', 5);
set(hStem,'Color', [0,0.7,0]);
%set(hBar, 'XTick', 1:length(gammas))
%set(hBar,'XTickLabel',gammas)
set(ax(1),'XTick',1:length(gammas));
set(ax(2),'XTick',1:length(gammas));
set(ax(1),'XTickLabel',gammas);
set(ax(2),'XTickLabel',gammas);
xlabel('\gamma', 'FontSize', 12)
ylabel(ax(1),'Variance','FontSize', 12, 'Color',[0,0,1])
ylabel(ax(2),'Number of traces', 'FontSize', 12, 'Color',[0,0.7,0])

%hStem.Color = [0,0.7,0.7];
