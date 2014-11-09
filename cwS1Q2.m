[S, A, T, R, StateNames, ActionNames, Absorbing] = GridWorld1();
% Do we need to change "Initial" in here or in GridWorl1()
Initial = [0; 0; 0; 0; 0; 0; 0; 1; 0; 0; 0];

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

gamma = 0.5:0.1:1;
epsilon = 0.5;

for iGamma = 1: length(gamma)
    
    %for i = 1:5
        
        estimation_n = zeros(20,1);
        varQTrace = zeros(20,1);
        for en= 1: 20
            [Q, estimation_n(en),varQTrace(en)] = MonteCarloEstimationTestn(T,R,Initial,Absorbing,...
                UnbiasedPolicy,gamma(iGamma));
        end
        
        %estimation_n
        nMax = max(estimation_n);
        nMean = mean(estimation_n);
        QVar = mean(varQTrace);% mean variance of the maximum variance in the state-action value function
        
        epsilon = 0.5;
        
        estimation_N = zeros(10,1);
        
        for eN= 1:10
            [ OptimalPolicy,estimation_N(eN) ] = MonteCarloBatchOptimisationTestN( T,R,Initial,...
                Absorbing,gamma(iGamma),epsilon,nMax );
        end
        
        %estimation_N
        NMax = max(estimation_N)
        NMean = mean(estimation_N);
        [ OptimalPolicy] = MonteCarloBatchOptimisation( T,R,Initial,...
            Absorbing,gamma(iGamma),epsilon,nMax,NMax);
        
        gamma(iGamma)
       
        tableGamma(iGamma).gamma = gamma(iGamma);
        tableGamma(iGamma).nMax = nMax;
        tableGamma(iGamma).NMax = NMax;
        tableGamma(iGamma).nMean = nMean;
        tableGamma(iGamma).NMean = NMean;
        tableGamma(iGamma).Qvar = QVar;
        tableGamma(iGamma).OptimalPolicy = OptimalPolicy;
end

%DisplayFunctionalPolicy(OptimalPolicy, StateNames, ActionNames);