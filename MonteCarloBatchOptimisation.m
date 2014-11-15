function [ OptimalPolicy ] = MonteCarloBatchOptimisation( T,R,Initial,Absorbing,gamma,epsilon,n,N)
%MonteCarloBatchOptimisation performs on-policy Monte-Carlo batch
%optimisation
%   N is the number of batches. 
%   n is the number of traces per batch.

A = length(R(1,1,:));
eGreedyPolicy = GetUnbiasedPolicy(Absorbing, A);

for nBatch = 1:N
   Q = MonteCarloEstimation(T,R,Initial,Absorbing,eGreedyPolicy,gamma,n);  
   eGreedyPolicy = eGreedyPolicyFromQ(Q, Absorbing, epsilon);
end
OptimalPolicy = eGreedyPolicy;
end

