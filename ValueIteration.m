function [P, V] = ValueIteration(T, R, Absorbing, gamma, theta)

noStates = size(T,1);

V = zeros(noStates, 1);
Vp = ones(noStates, 1);

GreedyPolicy = zeros(noStates, size(T,3)); % each row has A possible actions each has an assigned probability
A = size(T,3);
Q = zeros(noStates,A);
while sum(abs(V - Vp)) > theta
    Vp = V;
    for s = 1:noStates
        if Absorbing(s) % do not update absorbing states
            continue;
        end
        action_outcomes = zeros(4,1);
        for a = 1:size(T,3)
            Va = 0;
            for s1 = 1:noStates
                Va= Va + (T(s1,s,a) * (R(s1,s,a) + gamma * Vp(s1)));
            end
            action_outcomes(a) = Va;
        end
        Q(s,:) = action_outcomes;
        [V(s),index] = max(action_outcomes); % Maximum value of the value function in each state
        if sum(GreedyPolicy(s, :) > 0)
            GreedyPolicy(s, :) = 0;
        end
        GreedyPolicy(s, index) = 1;
        
    end
    
end
P = GreedyPolicy;
Q
%P = GreedyPolicyFromV(V, T, R, Absorbing, gamma); % Knowing the maximum value, compute the policy
end