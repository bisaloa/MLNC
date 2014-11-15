function [ OptimalPolicy,N ] = MonteCarloBatchOptimisationTestN( T,R,Initial,Absorbing,gamma,epsilon,n )
%MonteCarloBatchOptimisationTestN outputs the e-greedy policy and the
%  number of batches needed to converge to this policy.

A = length(R(1,1,:)); % number of actions

eGreedyPolicy = GetUnbiasedPolicy(Absorbing, A);

nBatch = 0;

% iterates until two consecutive iterations output the same policy
while true
    
    nBatch = nBatch + 1;
    newQ = MonteCarloEstimation(T,R,Initial,Absorbing,eGreedyPolicy,gamma,n);
    neweGreedyPolicy = eGreedyPolicyFromQ(newQ, Absorbing, epsilon);
    
    difPolicy = abs(eGreedyPolicy - neweGreedyPolicy);
    
    if max(difPolicy(:)) == 0
        break;
    end
    
    eGreedyPolicy= neweGreedyPolicy;
end

OptimalPolicy = eGreedyPolicy;
N = nBatch;

end

