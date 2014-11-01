function [GreedyPolicy] =  GreedyPolicyFromQ(Q, Absorbing)

S = length(Q(:,1));
A = length(Q(1,:));
GreedyPolicy = zeros(S, A); % each row has A possible actions each has an assigned probability

for priorState = 1:S
    if Absorbing(priorState)
        continue
    end
    [value, index] = max(Q(priorState,:));
    GreedyPolicy(priorState, index) = 1;
end







