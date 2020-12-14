% aim: to implement 2up1down tracking rule

clear all;
close all;

% parameters
theta = [-3, 0.7, 0.33, 0];
ntrials = 2000;
n_up = 1;
n_down = 3;
xnext = -2;




% used to implement staircase, NOT final counts!
count_stair = 0;
count_reversals = 0;
stepsize = 1;

for i = 1:ntrials
    response_accuracy = binornd(1,myPF(xnext,theta), 1);
    if response_accuracy==1
        count_stair = count_stair + 1;
    else
        count_stair = count_stair - 1;
    end

    % if staircase reached minus 3 (n_down), reverse with stepsize of 2
    if count_stair <= -n_down
        xnext = xnext + stepsize;
        count_stair = 0;
        count_reversals = count_reversals + 1;
        %fprintf("Reversed towards UP at %f\n", xnext);
    end
    if count_stair > n_up
        xnext = xnext - stepsize;
        count_stair = 0;
        count_reversals = count_reversals + 1;
        %fprintf("Reversed towards DOWN at %f\n", xnext);
    end

end

fprintf("\n\nFinal threshold : %f \n", xnext);
fprintf("Actual threshold = %f \n", theta(1)); 
fprintf("N reversals = %f\n\n", count_reversals);