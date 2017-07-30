function [inds,state] = evaluate(inds,mop,state)
    N                     = length(inds);
    state.reg_obj         = state.reg_obj+N;
    for i=1:N
        i
        [inds(i).objective] = mop.func(inds(i).parameter);
    end
end