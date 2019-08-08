%% modifyWorkspace
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190716
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      processSimuProperties
% Description:  Modify workspace, if magnets limit it (in translation)
%-------------------------------------------------------------------------
function [set]=modifyWorkspace(set,dimension)

switch dimension
    case 'x'
        dimension=1;
    case 'y'
        dimension=2;
    case 'z'
        dimension=3;
end

maxDimen=set.magnets(1,(6+dimension));

workspaceColumnStart=dimension*2-1;
workspaceColumnEnd=dimension*2;

% 1 Magnet scneario simplification (define one boarder as 0)
if set.amountMagnets==1 && set.magnets(1,dimension)>=0
    magmin=0;
    magmax=set.magnets(1,dimension);
elseif set.amountMagnets==1 && set.magnets(1,dimension)<0
    magmin=set.magnets(:,dimension);
    magmax=0;
else
    magmin=min(set.magnets(:,dimension));
    magmax=max(set.magnets(:,dimension));
end

% Magnets' min position dominant
if set.workspace(workspaceColumnStart)<magmin 
  set.workspaceScenarioLayout(workspaceColumnStart)=magmin+maxDimen/2;
elseif set.workspace(workspaceColumnStart)==magmin 
  set.workspaceScenarioLayout(workspaceColumnStart)=magmin;
elseif set.workspace(workspaceColumnStart)>magmin  
  set.workspaceScenarioLayout(workspaceColumnStart)=...
      set.workspace(workspaceColumnStart);  
end

% Magnets' max position dominant
if set.workspace(workspaceColumnEnd)>magmax 
  set.workspaceScenarioLayout(workspaceColumnEnd)=magmax-maxDimen/2;
elseif set.workspace(workspaceColumnEnd)==magmax 
  set.workspaceScenarioLayout(workspaceColumnEnd)=magmax;
elseif set.workspace(workspaceColumnEnd)<magmax 
  set.workspaceScenarioLayout(workspaceColumnEnd)=...
      set.workspace(workspaceColumnEnd);
end

% Order workspace from left to right - min to max
if set.workspaceScenarioLayout(workspaceColumnStart)>...
        set.workspaceScenarioLayout(workspaceColumnEnd) 
    temp=set.workspaceScenarioLayout(workspaceColumnStart);
    set.workspaceScenarioLayout(workspaceColumnStart)=...
        set.workspaceScenarioLayout(workspaceColumnEnd);
    set.workspaceScenarioLayout(workspaceColumnEnd)=temp;
end