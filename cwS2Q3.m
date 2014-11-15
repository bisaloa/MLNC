%% Test of the performance of Sarsa on Grid World 2 and Grid World 2.

clc
clear

%% Grid World 2
[S, A, T, R, StateNames, ActionNames, Initial, Absorbing, Locs, Shape] = GridWorld2();

theta = 0.001; % confidende level
gamma = 0.9;
epsilon = 0.01;
alpha = 0.1; % learning rate
maxsteps = 20; % maximum number of steps considered per trace
episodes = 1:600;

% Optimal policy from value iteration
OptimalPolicy = ValueIteration(T, R, Absorbing, gamma, theta);

% Sarsa
tableSarsaGrid2.gamma = gamma;
tableSarsaGrid2.alpha = alpha;
tableSarsaGrid2.maxsteps = maxsteps;
tableSarsaGrid2.OptimalPolicy = OptimalPolicy;
nRow = 1;

for j = 1: length(epsilon)
    for i = 1:length(episodes)
        OptimalPolicy = Sarsa( T, R, Initial, Absorbing, gamma, epsilon(j), alpha, maxsteps, episodes(i) );
        tableSarsaGrid2.performance(nRow).epsilon = epsilon(j);
        tableSarsaGrid2.performance(nRow).episodes = episodes(i);
        tableSarsaGrid2.performance(nRow).OptimalPolicy = OptimalPolicy;
        nRow = nRow + 1;
    end
end

%% Grid World 3
[S, A, T, R, StateNames, ActionNames, Initial, Absorbing, Locs, Shape] = GridWorld3();

theta = 0.00001; % confidende level
gamma = 0.9;
epsilon = 0.1;
alpha = 0.1; % learning rate
maxsteps = 100; % maximum number of steps considered per trace
episodes = 5000:100:20500;

% Optimal policy from value iteration
% It is important to take into account the value of Q
% since multiple actions in the same state may have the same value.
OptimalPolicy = ValueIteration(T, R, Absorbing, gamma, theta);

tableSarsaGrid3.gamma = gamma;
tableSarsaGrid3.alpha = alpha;
tableSarsaGrid3.maxsteps = maxsteps;
tableSarsaGrid3.OptimalPolicy = OptimalPolicy;
nRow = 1;

for j = 1: length(epsilon)
    for i = 1:length(episodes)
        OptimalPolicy = Sarsa( T, R, Initial, Absorbing, gamma, epsilon(j), alpha, maxsteps, episodes );
        tableSarsaGrid3.performance(nRow).epsilon = epsilon(j);
        tableSarsaGrid3.performance(nRow).episodes = episodes(i);
        tableSarsaGrid3.performance(nRow).OptimalPolicy = OptimalPolicy;
        nRow = nRow + 1;
    end
end