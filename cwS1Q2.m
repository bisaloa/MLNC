[S, A, T, R, StateNames, ActionNames, Absorbing] = GridWorld1();
% Do we need to change "Initial" in here or in GridWorl1()
Initial = [0; 0; 0; 0; 0; 0; 0; 1; 0; 0; 0];

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

gamma = 0.5:0.1:1;
epsilon = 0.5;

for iGamma = 1: length(gamma)

    for i = 1:5
    
        [Q, n] = MonteCarloEstimationTestn(T,R,Initial,Absorbing,UnbiasedPolicy,gamma(iGamma));
        [ OptimalPolicy,N ] = MonteCarloBatchOptimisationTestN( T,R,Initial,Absorbing,gamma(iGamma),epsilon,n);
        
        table(iGamma, i).gamma = gamma(iGamma);
        table(iGamma, i).n = n;
        table(iGamma, i).N = N;
        table(iGamma, i).OptimalPolicy = OptimalPolicy;
    end

end

%DisplayFunctionalPolicy(OptimalPolicy, StateNames, ActionNames);