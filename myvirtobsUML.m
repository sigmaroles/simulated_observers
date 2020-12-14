theta = [-16, 0.7, 0.33, 0];

ntrials = 400;
n_rep = 60;

err_120 = [];

for i = 1:n_rep
    uml_params = uml_config_virtobs();
    uml = UML(uml_params);
    

    for i = 1:ntrials
        x_next = uml.xnext;
        response_accuracy = binornd(1,myPF(x_next,theta),1);
        uml.update(response_accuracy);
        %uml.plotP();
    end
    yvals = repmat(theta(1),1,ntrials);

    %{
    prt1 = plot(uml.phi(:,1));
    hold on
    prt2 = plot(yvals,'linewidth',4);

    xlabel('no. of trials')
    ylabel('estimated parameter (alpha)')
    title("convergence of UML")
    lgg = legend([prt1, prt2], ["estimate", "true"]);%, "Location", "SouthEast");
    lgg.FontSize = 14; 
    %}
    
    err = abs(uml.phi(:,1) - yvals);
    plot(err)
    title("Absolute error (estimate alpha - true alpha)");
    xlabel("iteration");
    ylabel("error magnitude")
    hold on
    err_120 = [err_120; err(120)];
end

figure

plot(err_120, 'ro', 'linewidth', 10)
title("UML - absolute error at 120th trial")
