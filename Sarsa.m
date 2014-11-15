function [ OptimalPolicy ] = Sarsa( T, R, Initial, Absorbing, gamma, epsilon, alpha, maxsteps, episodes )
%Sarsa returns the greedy policy computed by On-Policy Temporal Diference
%Control
%%      maximum number of steps per epsiode, maxsteps;
%%      number of episodes, episodes;

S = length(T(:,1,1));
A = length(T(1,1,:)); 
Q = zeros(S, A);

for i=1:episodes
  priorState = DrawFromDist(Initial);
  % pick one action using the e-greedy policy from the current Q
  priorAction = pickAction(priorState, Q, Absorbing,epsilon);
  for j=1:maxsteps
    postState = DrawFromDist(T(:,priorState,priorAction));
    reward = R(postState,priorState,priorAction);
    if Absorbing(postState) ~= 1
        % pick one action using the e-greedy policy from the current Q
        postAction = pickAction(postState, Q,Absorbing, epsilon);
    else
      Q(priorState,priorAction) = (1-alpha)*Q(priorState,priorAction) + alpha*(reward);
      break;
    end
    Q(priorState,priorAction) = (1-alpha)*Q(priorState,priorAction) + alpha*(reward + gamma*Q(postState,postAction));
    priorState = postState;
    priorAction = postAction;
  end
end
OptimalPolicy = GreedyPolicyFromQ(Q, Absorbing);
end

function [action] = pickAction(state, Q, Absorbing,epsilon)
    Policy = eGreedyPolicyFromQ(Q,Absorbing,epsilon);
    action = DrawFromDist(Policy(state,:));
end

