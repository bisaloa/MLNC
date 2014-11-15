%% Test the performance of MonteCarloBatchOptimasation
%% if the first state is near the goal for different
%% values of the exploration-exploitation factor.

[S, A, T, R, StateNames, ActionNames, Absorbing] = GridWorld1();

% Set initial to choose S3 deterministically
Initial = [0;0;1;0;0;0;0;0;0;0;0];

[UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A);

gamma = 0.9;
epsilon = 0.1:0.1:0.8;
n = 2042; % estimation of the maximum number of sample traces if gamma=0.9

for iEpsilon = 1: length(epsilon)

        for eN= 1:20 % 20 trials
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