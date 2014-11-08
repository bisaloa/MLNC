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
bar(floor(variances));
set(gca,'XTick',1:length(floor(variances)))
set(gca,'XTickLabel',gammas)
ylabel('Variance')
xlabel('\gamma')
title('Maximum variance in the estimation of Q(s,a)')
axis tight
