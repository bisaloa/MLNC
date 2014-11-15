function [Q] = MonteCarloEstimation( T,R,Initial,Absorbing,Policy,gamma,n )
%MonteCarloEstimation performs First-Visit Monte-Carlo estimation
%  number of sample traces,n

S = length(Policy(:,1)); % number of states
A = length(Policy(1,:)); % number of actions
Q = zeros(S, A); % initialization of state-action value function
countMeasurementsQ = zeros(S, A); % counter of the total number of first visits

for noEpisode = 1 : n
    EpisodeStates = zeros(S,A); % keeps track of the state-action tuples visited in the trace
    Trace = GetTrace(T,R,Initial,Absorbing,Policy);
    newQ = zeros(S, A);
    
    for nRow = 1 : (size(Trace, 1)-1) % do not compute Q for absorbing states
        step = Trace(nRow,:);
        state = step(2);
        action = step(3);
        if EpisodeStates(state,action) == 1 % if the state-action was already visited
            continue;                       % evaluate the next step
        else
            EpisodeStates(state,action) = 1;
        end 
        actualReturn = 0;
        i = 0;
        % discounted reward for a given state-action tuple
        for nReturn = (nRow+1) : size(Trace, 1)
            stepR = Trace(nReturn,:);
            actualReturn = actualReturn + gamma^i * stepR(1);
            i = i + 1;
        end
        newQ(state, action) = actualReturn;
    end
    countMeasurementsQ = countMeasurementsQ + EpisodeStates;
    Q = Q + newQ; % add all the computed rewards
end
% state-action value function is the average of the total rewards
Q = Q ./ max(countMeasurementsQ,1);
end

