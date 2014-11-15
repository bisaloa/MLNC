%% This script displays GridWorld2, the states corresponding to each of the
%% cells, the rewards, and the absorbing states.

[S, A, T, R, StateNames, ActionNames, Initial, Absorbing, Locs, Shape] = GridWorld2();

DisplayGrid([1:S],Locs,Shape)
DisplayGrid(R(:,1,1),Locs,Shape)
DisplayGrid(Absorbing,Locs,Shape)