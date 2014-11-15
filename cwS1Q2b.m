%% Test of different values for the exploration-exploitation factor and 
%% analysis of the performance of MonteCarloBatchOptimasation 
%% in terms of number of batches until convergence.

[S, A, T, R, StateNames, ActionNames, Absorbing] = GridWorld1();

% Set initial to choose S8 deterministically
Initial = [0; 0; 0; 0; 0; 0; 0; 1; 0; 0; 0];

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

gamma = 0.9;
epsilon = 0.1:0.1:0.8;
n = 2042; % estimation of the maximum number of sample traces
% to obtain an estimation of Q with an accuracy level of
% 0.001 and gamma=0.9

for iEpsilon = 1: length(epsilon)
    
    for eN= 1:20 % 20 trials for each value of the exploration-exploitation factor
        [ OptimalPolicy,estimation_N(eN) ] = MonteCarloBatchOptimisationTestN( T,R,Initial,...
            Absorbing,gamma,epsilon(iEpsilon),n );
    end
    
    %estimation_N
    NMax = max(estimation_N); % maximum number of N among all the trials
    NMean = mean(estimation_N); % estimation of the mean of N
    [ OptimalPolicy] = MonteCarloBatchOptimisation( T,R,Initial,...
        Absorbing,gamma,epsilon(iEpsilon),n,NMax);
    
    tableEpsilon(iEpsilon).epsilon = epsilon(iEpsilon);
    tableEpsilon(iEpsilon).gamma = gamma;
    tableEpsilon(iEpsilon).n = n;
    tableEpsilon(iEpsilon).NMax = NMax;
    tableEpsilon(iEpsilon).NMean = NMean;
    tableEpsilon(iEpsilon).OptimalPolicy = OptimalPolicy;
end