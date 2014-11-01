function [trace] = GetTrace(T,R,Initial,Absorbing,Policy)

priorState = DrawFromDist(Initial);
priorAction = DrawFromDist(Policy(priorState,:)); % get action
reward = 0;
step = [ reward, priorState, priorAction ]; % first reward is a dummy reward
trace = [ step; ];
while( true )    %find locates the index of agent

    postState = DrawFromDist(T(:,priorState,priorAction));
    reward = R(postState,priorState,priorAction);
    if Absorbing(postState) ~= 1
        postAction = DrawFromDist(Policy(postState,:));
    else
        step = [reward, postState, 0]; % last action is a dummy action
        trace = [ trace; step ];
        break;
    end
    step = [ reward, postState, postAction ];
    trace = [ trace; step ];

    priorState = postState;
    priorAction = postAction;
end


end

