function [ OptimalPolicy,N ] = MonteCarloBatchOptimisationTestN( T,R,Initial,Absorbing,gamma,epsilon,n )
%MONTECARLOBATCHOPTIMISATIONTESTN Summary of this function goes here
%   Detailed explanation goes here

S = length(R(:,1,1));
A = length(R(1,1,:));

eGreedyPolicy = GetUnbiasedPolicy(Absorbing, A);
Q = zeros(S, A);

nBatch = 0;
%for nBatch = 1:N
while true
   
    nBatch = nBatch + 1;
   newQ = MonteCarloEstimation(T,R,Initial,Absorbing,eGreedyPolicy,gamma,n);
   neweGreedyPolicy = eGreedyPolicyFromQ(newQ, Absorbing, epsilon);
   
   Qdif = newQ - Q;
    vectorQdif = Qdif(:);
    difPolicy = abs(eGreedyPolicy - neweGreedyPolicy);
    if (max(vectorQdif) >= 0.5) && max(difPolicy(:))==0
        %difPolicy = eGreedyPolicy - neweGreedyPolicy;
        %if max(abs(difPolicy(:))) <= 0.5
        break;
        %end
    end
    
    Q = newQ;
    eGreedyPolicy= neweGreedyPolicy;
end

OptimalPolicy = eGreedyPolicy;
N = nBatch;

end

