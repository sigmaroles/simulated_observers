function par = myUML()

par.model = 'logit';
par.ndown = 2;
par.method = 'mean';

par.x0 = 0;
par.x_lim = [-50 0];

par.alpha = struct(...
    'limits',[-50 0],...       %range of the parameter space for alpha
    'N',200,...                %number of alpha values. If this value is set to 1, then the first element of alpha.limits would be the assumed alpha and the alpha parameter is not estimated.
    'scale','lin',...         %the linear or log spacing. Choose between 'lin' and 'log'.
    'dist','flat',...         %prior distribution of the alpha parameter. Choose between 'norm' and 'flat'.
    'mu',-18,...                %mean of the prior distribution.
    'std',10 ...              %standard deviation of the prior distribution.  
    );

par.beta = struct(...
    'limits',[.1 2],...      %range of the parameter space for beta
    'N',10,...                %number of beta values. If this value is set to 1, then the first element of beta.limits would be the assumed beta and the beta parameter is not estimated.
    'scale','lin',...         %the linear or log spacing. Choose between 'lin' and 'log'.
    'dist','flat',...         %prior distribution of the beta parameter. Choose between 'norm' and 'flat'.
    'mu',0.8,...                %mean of the prior distribution.
    'std',.5 ...               %standard deviation of the prior distribution.
    );


par.gamma = 0.333;

par.lambda = struct(...
    'limits',[0 0.2],...      %range of the parameter space for lambda
    'N',1,...                 %number of lambda values. If this value is set to 1, then the first element of lambda.limits would be the assumed lambda and the lambda parameter is not estimated.
    'scale','lin',...         %the linear or log spacing. Choose between 'lin' and 'log'.
    'dist','flat',...         %prior distribution of the lambda parameter. Choose between 'norm' and 'flat'.
    'mu',0,...                %mean of the prior distribution.
    'std',0.1 ...             %standard deviation of the prior distribution.  
    );

end