[S, A, T, R, StateNames, ActionNames, Absorbing] = GridWorld1();

Initial = [1/9;1/9;1/9;0;1/9;1/9;0;1/9;1/9;1/9;1/9];

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

gamma = 1;
epsilon = 0.5;
    
[Q, n] = MonteCarloEstimationTestn(T,R,Initial,Absorbing,UnbiasedPolicy,gamma);

n = 3000;
[ OptimalPolicy,N ] = MonteCarloBatchOptimisationTestN( T,R,Initial,Absorbing,gamma,epsilon,n);