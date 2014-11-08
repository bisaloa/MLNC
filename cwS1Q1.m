clear

[S, A, T, R, StateNames, ActionNames, Initial, Absorbing] = StairClimbingMDP();

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);
gamma = 1;

S = length(StateNames); % number of states
A = length(ActionNames); % number of actions
estimation_n = zeros(20,1);

for i= 1: 20
    [Q, estimation_n(i)] = MonteCarloEstimationTestn(T,R,Initial,Absorbing,...
                    UnbiasedPolicy,gamma);
end

estimation_n

final_n = max(estimation_n)

epsilon = 0.5;

estimation_N = zeros(10,1);

for i= 1:10
    [ OptimalPolicy,estimation_N(i) ] = MonteCarloBatchOptimisationTestN( T,R,Initial,...
                        Absorbing,gamma,epsilon,final_n );
end

estimation_N
final_N = max(estimation_N)
[ OptimalPolicy ] = MonteCarloBatchOptimisation( T,R,Initial,Absorbing,...
                   gamma,epsilon,final_n,final_N);

OptimalPolicy