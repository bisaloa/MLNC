function [ eGreedyPolicy ] = eGreedyPolicyFromQ( Q, Absorbing, epsilon )
%eGreedyPolicyFromQ returns an e-greedy policy from a matrix of
%Q-values

S = length(Q(:,1));
A = length(Q(1,:));

UnbiasedPolicy = GetUnbiasedPolicy(Absorbing, A);
GreedyPolicy = GreedyPolicyFromQ(Q, Absorbing);

eGreedyPolicy = (epsilon*ones(S,A)).*UnbiasedPolicy + (1 - epsilon).*GreedyPolicy;
end

