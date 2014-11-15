function [ Q,n,maxVarQ ] = MonteCarloEstimationTestn( T,R,Initial,Absorbing,Policy,gamma)
%MonteCarloEstimationTestn performs First-Visit Monte-Carlo estimation with
% on-line averaging. It outputs the number of sample traces needed to
% converge with an accuracy level of 0.001, the maximum variance of the 
% consecutive estimations of Q, and the final estimation of Q.

S = length(Policy); % number of states
A = length(Policy(1,:)); % number of actions
Q = zeros(S, A); % i.e. optimal state-action value function vector 
                 % (optimal value function for each state) 11x1
accuracyLevel = 0.001;
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
    QperTrace(nTotal,:,:) = newQ;
    countMeasurementsQ = countMeasurementsQ + EpisodeStates;
    
    Q = Q + (1./max(countMeasurementsQ,1)).*(newQ - Q).*EpisodeStates;
    
    Qdif = abs(oldQ - Q);
    vectorQdif = Qdif(:);
    if max(vectorQdif) < accuracyLevel
        break;
    end
    
    oldQ = Q;
end
% Compute the variance among the different estimations of the 
% state-action values.
varQTrace = var(QperTrace,0,1);
maxVarQ = max(varQTrace(:));

n = nTotal;
end

