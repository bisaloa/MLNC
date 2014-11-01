[S, A, T, R, StateNames, ActionNames, Initial, Absorbing] = StairClimbingMDP();

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

[trace] = GetTrace(T,R,Initial,Absorbing,UnbiasedPolicy);

gamma = 0.5;
n=100;

[Q] = MonteCarloEstimation(T,R,Initial,Absorbing,UnbiasedPolicy,gamma,n);

epsilon = 0.5;
[eGreedyPolicy] = eGreedyPolicyFromQ( Q, Absorbing, epsilon );

N = 5;
[ OptimalPolicy ] = MonteCarloBatchOptimisation( T,R,Initial,Absorbing,gamma,epsilon,n,N);