function [Q] = MonteCarloEstimation( T,R,Initial,Absorbing,Policy,gamma,n )
%MONTECARLOESTIMATION Performs Monte-Carlo estimation
%   n is the number of traces to sample

S = length(Policy); % number of states - introspecting transition matrix
A = length(Policy(1,:)); % number of actions - introspecting policy matrix
Q = zeros(S, A); % i.e. optimal state-action value function vector (optimal value function for each state) 11x1
newQ = Q;

for noEpisode = 1 : n
    EpisodeStates = zeros(S,A);
    Trace = GetTrace(T,R,Initial,Absorbing,Policy);
    
    for nRow = 1 : (size(Trace, 1)-1) % do not compute Q for the absorbing states
        step = Trace(nRow,:);
        state = step(2);
        action = step(3);
        if EpisodeStates(state,action) == 1
            continue;
        else
            EpisodeStates(state,action) = 1;
        end 
        actualReturn = 0;
        for nReturn = (nRow+1) : size(Trace, 1)
            stepR = Trace(nReturn,:);
            actualReturn = actualReturn + stepR(1);
        end
        newQ(state,action) = averageReturns(Q(state,action), actualReturn, gamma);
    end
    Q(EpisodeStates==1) = newQ(EpisodeStates==1);
end


end

function [newQ] = averageReturns(Q, actualReturn, gamma)
 newQ = (1 - gamma) * Q + gamma*actualReturn;
end

