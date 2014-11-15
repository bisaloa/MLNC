clc
clear
%% Test on StairClimbingMDP MonteCarloEstimation, eGreedyPolicyFromQ, and
%% MonteCarloBatchOptimasation

[S, A, T, R, StateNames, ActionNames, Initial, Absorbing] = StairClimbingMDP();

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

S = length(StateNames); % number of states
A = length(ActionNames); % number of actions

gamma = 1;
epsilon = 0.5;
n = 20;
N = 5;

Q = MonteCarloEstimation(T,R,Initial,Absorbing,UnbiasedPolicy,gamma,n);  

eGreedyPolicy = eGreedyPolicyFromQ(Q, Absorbing, epsilon);

[ OptimalPolicy ] = MonteCarloBatchOptimisation( T,R,Initial,Absorbing,...
                    gamma,epsilon,n,N);
 
