[S, A, T, R, StateNames, ActionNames, Absorbing] = GridWorld1();
% Do we need to change "Initial" in here or in GridWorl1()
Initial = [0; 0; 0; 0; 0; 0; 0; 1; 0; 0; 0];

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

gamma = 0.5;

[Q, n] = MonteCarloEstimationTestn(T,R,Initial,Absorbing,UnbiasedPolicy,gamma);

%epsilon = 0.5;

%[ OptimalPolicy,N ] = MonteCarloBatchOptimisationTestN( T,R,Initial,Absorbing,gamma,epsilon,n);

%DisplayFunctionalPolicy(OptimalPolicy, StateNames, ActionNames);