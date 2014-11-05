clear

[S, A, T, R, StateNames, ActionNames, Initial, Absorbing] = StairClimbingMDP();

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

%[trace] = GetTrace(T,R,Initial,Absorbing,UnbiasedPolicy);

gamma = 1;
%n=300;

%[Q] = MonteCarloEstimation(T,R,Initial,Absorbing,UnbiasedPolicy,gamma,n);

[Q, nTest] = MonteCarloEstimationTestn(T,R,Initial,Absorbing,UnbiasedPolicy,gamma);

epsilon = 0.5;
%[eGreedyPolicy] = eGreedyPolicyFromQ( Q, Absorbing, epsilon );

N = 20;

%[ OptimalPolicy,N ] = MonteCarloBatchOptimisationTestN( T,R,Initial,Absorbing,gamma,epsilon,nTest )
[ OptimalPolicy ] = MonteCarloBatchOptimisation( T,R,Initial,Absorbing,gamma,epsilon,nTest,N);