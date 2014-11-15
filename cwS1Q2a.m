%% Test of different values for the discount factor and analysis of
%% the performance of MonteCarloEstimation in terms of number of samples
%% traces until convergence.

[S, A, T, R, StateNames, ActionNames, Absorbing] = GridWorld1();

% Set initial to choose S8 deterministically
Initial = [0; 0; 0; 0; 0; 0; 0; 1; 0; 0; 0];

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

gamma = 0.5:0.1:1; % discount factor
epsilon = 0.5; % exploration-exploitation factor

for iGamma = 1:length(gamma)
        estimation_n = zeros(20,1);
        varQTrace = zeros(20,1);
        
        for en= 1:20 % 20 trials for each value of gamma
            [Q, estimation_n(en),varQTrace(en)] = MonteCarloEstimationTestn(T,...
                R,Initial,Absorbing,UnbiasedPolicy,gamma(iGamma));
        end
        
        nMax = max(estimation_n); % maximum number of n among all the trials
        nMean = mean(estimation_n); % estimation of the mean of n
        QVar = mean(varQTrace);% mean variance of the maximum variance for 
                               % each trial in  the state-action value function
        
        estimation_N = zeros(10,1);
        
        % Estimate the number of batches if the number of sample traces is
        % nMax
        for eN = 1:10 % 10 trials
            [ OptimalPolicy,estimation_N(eN) ] = MonteCarloBatchOptimisationTestN(...
                T,R,Initial,Absorbing,gamma(iGamma),epsilon,nMax );
        end
        
        NMax = max(estimation_N)
        NMean = mean(estimation_N);
        
        % Taken into account the maximum values for N and n
        % compute the optimal policy
        [ OptimalPolicy] = MonteCarloBatchOptimisation( T,R,Initial,...
            Absorbing,gamma(iGamma),epsilon,nMax,NMax);
        
        tableGamma(iGamma).gamma = gamma(iGamma);
        tableGamma(iGamma).nMax = nMax;
        tableGamma(iGamma).NMax = NMax;
        tableGamma(iGamma).nMean = nMean;
        tableGamma(iGamma).NMean = NMean;
        tableGamma(iGamma).Qvar = QVar;
        tableGamma(iGamma).OptimalPolicy = OptimalPolicy;
end