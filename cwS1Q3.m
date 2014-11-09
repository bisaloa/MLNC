[S, A, T, R, StateNames, ActionNames, Absorbing] = GridWorld1();
% Do we need to change "Initial" in here or in GridWorl1()
Initial = [0;0;1;0;0;0;0;0;0;0;0];

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

gamma = 0.9;
epsilon = 0.1:0.1:0.8;
n = 2042;

for iEpsilon = 1: length(epsilon)
    epsilon(iEpsilon)
    %for i = 1:5
        for eN= 1:20
            [ OptimalPolicy,estimation_N(eN) ] = MonteCarloBatchOptimisationTestN( T,R,Initial,...
                Absorbing,gamma,epsilon(iEpsilon),n );
        end
        
        %estimation_N
        NMax = max(estimation_N)
        NMean = mean(estimation_N);
        [ OptimalPolicy] = MonteCarloBatchOptimisation( T,R,Initial,...
            Absorbing,gamma,epsilon(iEpsilon),n,NMax);
        
        tableEpsilon(iEpsilon).epsilon = epsilon(iEpsilon);
        tableEpsilon(iEpsilon).gamma = gamma;
        tableEpsilon(iEpsilon).n = n;
        tableEpsilon(iEpsilon).NMax = NMax;
        tableEpsilon(iEpsilon).NMean = NMean;
        tableEpsilon(iEpsilon).OptimalPolicy = OptimalPolicy;
end