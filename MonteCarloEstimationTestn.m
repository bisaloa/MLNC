function [ Q,n ] = MonteCarloEstimationTestn( T,R,Initial,Absorbing,Policy,gamma)
%MONTECARLOESTIMATION Performs Monte-Carlo estimation
%   n is the number of traces to sample

S = length(Policy); % number of states - introspecting transition matrix
A = length(Policy(1,:)); % number of actions - introspecting policy matrix
Q = zeros(S, A); % i.e. optimal state-action value function vector (optimal value function for each state) 11x1

oldQ = Q;
countMeasurementsQ = zeros(S, A);

nTotal = 0;
while true
    EpisodeStates = zeros(S,A);
    Trace = GetTrace(T,R,Initial,Absorbing,Policy);
    nTotal = nTotal + 1;
    newQ = zeros(S, A);
    for nRow = 1 : (size(Trace, 1)-1) % do not compute Q for the absorbing states
        step = Trace(nRow,:);
        state = step(2);
        action = step(3);
        if EpisodeStates(state,action) == 1
            continue;
        else
            EpisodeStates(state,action) = 1;
        end 
       
        actualReward  = 0;
        i = 0;
        for nReturn = (nRow+1) : size(Trace, 1)
            stepR = Trace(nReturn,:);
            actualReward = actualReward + gamma^i * stepR(1);
            i = i + 1;
        end
        
        newQ(state, action) = actualReward;
    end
    countMeasurementsQ = countMeasurementsQ + EpisodeStates;
    
    Q = Q + (1./max(countMeasurementsQ,1)).*(newQ - Q).*EpisodeStates;
    
    Qdif = abs(oldQ - Q);
    vectorQdif = Qdif(:);
    if max(vectorQdif) < 0.001
        break;
    end
    
    oldQ = Q;
end

n = nTotal;
end

