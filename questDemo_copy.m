clear all;
close all;

%animate=input('Do you want so see a live animated plot of the shrinking pdf? (y/n) [y]:','s');
%animate=~streq(lower(animate),'n');

% user inputs
animate = 'y';
tActual=-10;
tGuess=-8;
tGuessSd=8;

% predefined params
pThreshold=0.82;
beta=3.5;delta=0.01;gamma=0.5;


q=QuestCreate(tGuess,tGuessSd,pThreshold,beta,delta,gamma);
q.normalizePdf=1; % This adds a few ms per call to QuestUpdate, but otherwise the pdf will underflow after about 1000 trials.

trialsDesired=200;
wrongRight={'wrong','right'};


for k=1:trialsDesired
	% Get recommended level.  Choose your favorite algorithm.
	%tTest=QuestQuantile(q);	% Recommended by Pelli (1987), and still our favorite.
	 	tTest=QuestMean(q);		% Recommended by King-Smith et al. (1994)
	% 	tTest=QuestMode(q);		% Recommended by Watson & Pelli (1983)
	
	% We are free to test any intensity we like, not necessarily what Quest suggested.
	% 	tTest=min(-0.05,max(-3,tTest)); % Restrict to range of log contrasts that our equipment can produce.
	
	% Simulate a trial
	if animate
      figure(1);
      response=QuestSimulate(q,tTest,tActual,2);
      title('Actual psychometric function, and the points tested.')
      xl=xlim;
   else
      response=QuestSimulate(q,tTest,tActual);
   end

 	fprintf('Trial %3d at %5.2f is %s\n',k,tTest,char(wrongRight(response+1)));
		
	% Update the pdf
	q=QuestUpdate(q,tTest,response); % Add the new datum (actual test intensity and observer response) to the database.
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

fprintf('Final threshold estimate (mean+-sd) is %.2f +- %.2f\n',t,sd);
% t=QuestMode(q);	% Similar and preferable to the maximum likelihood recommended by Watson & Pelli (1983).
% fprintf('Mode threshold estimate is %4.2f\n',t);
fprintf('\nYou set the true threshold to %.2f.\n',tActual);
fprintf('Quest knew only your guess: %.2f +- %.2f.\n',tGuess,tGuessSd);

if animate
   figure(1)
   hold off
   figure(2)
   hold off
end
