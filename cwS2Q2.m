[S, A, T, R, StateNames, ActionNames, Absorbing, Locs, Shape] = GridWorld2();

gamma = 0.9;
epsilon = 0.3;
alpha = 0.1;
maxsteps = 100;
episodes = 1000;
OptimalPolicy = Sarsa( T, R, Initial, Absorbing, gamma, epsilon, alpha, maxsteps, episodes );