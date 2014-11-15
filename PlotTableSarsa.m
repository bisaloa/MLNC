function PlotTableSarsa( table )
%PlotTableSarsa displays the percentage of optimal actions for different
%   number of sample traces.

perfTable = table.performance;

nRows =  size(perfTable,2);
S = 9;
A = 4;

iEp = 1;
epsilon(iEp) = perfTable(1,1).epsilon;
iT = 1;
for iR = 1:nRows
    
    if (epsilon(iEp) == perfTable(1,iR).epsilon)
        traces(iT,iEp) = perfTable(1,iR).episodes;
        sarsaPolicy = perfTable(1,iR).OptimalPolicy;
        difPolicies = (1/A)*(sarsaPolicy - table.OptimalPolicy);
        optimalActionPerc(iT,iEp) = 100 *( 1 - (1/S)*(sum(sum(abs(difPolicies)))));
        iT = iT + 1;
    else
        iEp = iEp + 1;
        iT = 1;
        epsilon(iEp) = perfTable(1,iR).epsilon;
        traces(iT,iEp) = perfTable(1,iR).episodes;
        sarsaPolicy = perfTable(1,iR).OptimalPolicy;
        difPolicies = (1/A)*(sarsaPolicy - table.OptimalPolicy);
        optimalActionPerc(iT,iEp) = 100 *( 1 - (1/S)*(sum(sum(abs(difPolicies)))));
        iT = iT + 1;
    end
end

figure
hold all
for iEp = 1:length(epsilon)
    plot(traces(:,iEp), optimalActionPerc(:,iEp), 'LineWidth', 1);
end
hold off

xlabel('Number of traces','FontSize', 14);
ylabel('Percentage of Optimal Action','FontSize', 14);

end

