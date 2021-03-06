clear all;
close all;

% user inputs
animate = 0; % logical, 1 or 0
tActual = -12.3;
tGuess = -10;
tGuessSd = 30;

% predefined params and vars
pThreshold=0.99;
pbeta=5.5;
pdelta=0.005;
pgamma=0.8;
q.normalizePdf=1; % This adds a few ms per call to QuestUpdate, but otherwise the pdf will underflow after about 1000 trials.
trialsDesired=200;
wrongRight={'wrong','right'};

% init
qObject=QuestCreate(tGuess,tGuessSd,pThreshold,pbeta,pdelta,pgamma);

% simulate trials
for k=1:trialsDesired
	% Get recommended level.  Choose your favorite algorithm.
	tTest=QuestQuantile(qObject);	% Recommended by Pelli (1987), and still our favorite.
   %tTest=QuestMean(q);		% Recommended by King-Smith et al. (1994)
	% 	tTest=QuestMode(q);		% Recommended by Watson & Pelli (1983)
	
	% We are free to test any intensity we like, not necessarily what Quest suggested.
	% 	tTest=min(-0.05,max(-3,tTest)); % Restrict to range of log contrasts that our equipment can produce.
	
	% Simulate a trial
	if animate
      figure(1);
      response=QuestSimulate(qObject,tTest,tActual,2);
      title('Actual psychometric function, and the points tested.')
      xl=xlim;
   else
      response=QuestSimulate(qObject,tTest,tActual);
   end

 	%fprintf('Trial %3d at %5.2f is %s\n',k,tTest,char(wrongRight(response+1)));
		
	% Update the pdf
	q=QuestUpdate(qObject,tTest,response); % Add the new datum (actual test intensity and observer response) to the database.
   if animate
      figure(2)
      plot(q.x+q.tGuess,q.pdf)
      xlim(xl);
      title('Posterior PDF');
      hold on
   end
end


% Ask Quest for the final estimate of threshold.
t=QuestMean(q);		% Recommended by Pelli (1989) and King-Smith et al. (1994). Still our favorite.
sd=QuestSd(q);

fprintf('\nThreshold estimate : %.4f +- %.4f\n',t,sd);
t=QuestMode(q);	% Similar and preferable to the maximum likelihood recommended by Watson & Pelli (1983).
fprintf('Mode threshold estimate is %.4f\n',t);
fprintf('\nTrue threshold : %.4f.\n',tActual);
fprintf('Guess threshold init: %.4f +- %.4f \n\n',tGuess,tGuessSd);

if animate
   figure(1)
   hold off
   figure(2)
   hold off
end
