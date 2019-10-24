% save UML virtual observer data, compare with psignifit

theta = [-16, 0.7, 0.33, 0];
% all users have same psychometric function??

ntrials = 120;

for uindx = 1:30

    userid = "s"+string(num2str(uindx, '%03.f'));
    uml_params = uml_config_virtobs();
    uml = UML(uml_params);

    for i = 1:ntrials
        
        x_next = uml.xnext;
        response_accuracy = binornd(1,myPF(x_next,theta),1);
        uml.update(response_accuracy);
        
    end

    savedata = struct;
    savedata.stimLevels = uml.x;
    savedata.accuracy = uml.r;
    savedata.actual_params = theta;
    savedata.uml = uml;
    savedata.uml_params = uml_params;
    savedata.userid = userid;

    fname = "./data/simulated_subject_" + userid + ".mat";
    save(fname, 'savedata')

end