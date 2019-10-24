fh = fopen('./data/alphatable.csv', 'w');
fprintf(fh,"SubjectID,true_alpha,psignifit_alpha,UML_alpha\n");

% TODO: save the UML final alpha estimates to csv too

all_files = dir('./data/*.mat');


for findx = 1:length(all_files)
    fname = all_files(findx).name;

    % --- psignifit specific stuff from here
    fdata = load(string('./data/') + fname);
    userid = fdata.savedata.userid;
    sz = size(fdata.savedata.stimLevels,1);    
    ntrialsrep = repmat(1, sz, 1);
    psidata = [fdata.savedata.stimLevels, fdata.savedata.accuracy, ntrialsrep];
    psiopt = struct;
    psiopt.sigmoidName = 'logistic';
    psiopt.expType = '3AFC';
    psiopt.nblocks = 100; % ? does not seem to have an effect

    fit_data = psignifit(psidata, psiopt);

    
    c1 = char(userid);
    c2 = fdata.savedata.actual_params(1);
    % getThreshold is from psignifit toolbox. the 0.667 is for 3I3AFC task..
    c3 = getThreshold(fit_data, 0.666667);
    c4 = fdata.savedata.uml.phi(end,1);
    

    fprintf(fh, "%s,%f,%f,%f\n", c1,c2,c3,c4);
end

fclose(fh);