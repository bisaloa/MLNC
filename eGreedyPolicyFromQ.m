function [ eGreedyPolicy ] = eGreedyPolicyFromQ( Q, Absorbing, epsilon )
%eGreedyPolicyFromQ Returns an epsilon-Greedy Policy based on a matrix of
%Q-values
% epsilon is a probability with which the epsilon-Greedy Policy chooses an
% action at random.

S = length(Q(:,1));
A = length(Q(1,:));
eGreedyPolicy = zeros(S, A); % each row has A possible actions each has an assigned probability

for priorState = 1:S
    if Absorbing(priorState)
        continue
    end
    [value, index] = max(Q(priorState,:));
    probNonOptimal = epsilon/A; 
    probOptimal = 1 - epsilon + epsilon/A;
    eGreedyPolicy(priorState, index) = probOptimal;
    eGreedyPolicy(priorState, [1:A]~=index) = probNonOptimal;
end

end

