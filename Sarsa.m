function [ OptimalPolicy ] = Sarsa( T, R, Initial, Absorbing, gamma, epsilon, alpha, maxsteps, episodes )
%SARSA Summary of this function goes here
%   Detailed explanation goes here
%% takes:
%%      transition matrix T;
%%      reward matrix, R;
%%      Initialising distribution, Initial;
%%      matrix of Absorbing states, Absorbing;
%%      geometric discount, gamma;
%%      level of e-Greedy policy randomness, epsilon;
%%      fixed learning rate, alpha;
%%      maximum number of steps per epsiode, maxsteps;
%%      number of episodes, episodes;
%%
%% returns: Optimal Policy and Q-estimate.

%
S = length(T(:,1,1)); % number of states - introspecting transition matrix
A = length(T(1,1,:)); % number of actions - introspecting transition matrix
Q = zeros(S, A); % i.e. state-action value function estimate
Policy = GetUnbiasedPolicy(Absorbing, A);

for i=1:episodes
  priorState = DrawFromDist(Initial);
  priorAction = DrawFromDist(Policy(priorState,:)); % get action
  for i=1:maxsteps
    postState = DrawFromDist(T(:,priorState,priorAction));
    reward = R(postState,priorState,priorAction);
    if Absorbing(postState) ~= 1
        postAction = DrawFromDist(Policy(postState,:));
    else
      Q(priorState,priorAction) = (1-alpha)*Q(priorState,priorAction) + alpha*(reward);
      Policy = eGreedyPolicyFromQ(Q, Absorbing, epsilon);
      break;
    end
    Q(priorState,priorAction) = (1-alpha)*Q(priorState,priorAction) + alpha*(reward + gamma*Q(postState,postAction));
    Policy = eGreedyPolicyFromQ(Q, Absorbing, epsilon);
    priorState = postState;
    priorAction = postAction;
  end
end

OptimalPolicy = Policy;

end
