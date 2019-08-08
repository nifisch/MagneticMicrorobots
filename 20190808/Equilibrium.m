% Equilibrium: Positions of equilibrium
%------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190808
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Description:  Calculates and visualises points of equilibrium of 
%               Microrobotsexposed to a designed magnetic field.
%------------------------------------------------------------------------
%% 1. Simulation Setting (To be modified)
% if exist('setting')==0
[setting]=setSimuProperties;
% end

%% 2. B-field Import (e.g. CST Sutdio Suite 2017)
% Import b-field as a list from *.txt file
% if exist('b_field')==0
b_field=importTXT(fullfile(pwd,'B_field_data',setting.filename)); 
% end

% Creates ideal Binfo
[BinfoWOI]=createBInfoWOI(setting);

%% 3. B-Vectorfield Creation
% Get B vector field for 1 Magnet, transforms list to vectorfield array
[B_1Magnet,Binfo]=getBvectorfield(b_field);
% clear b_field 

%% 4. Magnetic Moments of MRs
% Use raw magnetic field for determination of MR's magnetisation
[M]=getMagnetMoments(setting,B_1Magnet,Binfo);

% Visualise Experimental Results
visualiseExperiments(setting);

%% 5. Scenario Creation
Bmatfile=createScenario(B_1Magnet,setting,Binfo,BinfoWOI);
clear B_1Magnet

%% 6. Microrobot Simulation
% Creates arrays for points of equilibria
% if exist('poe_1D')==0
[poe1D]=createPoe(setting,setting.MR_half,setting.MR_half,setting.zPlatform);% 1D
% end
% if exist('poe_2D')==0
[poe2D]=createPoe(setting,setting.MR_half,setting.MR_half,setting.zPlatform);% 2D
% end

% For all wanted altitudes i_zPlatform=!i_zB
for i_zPlatform=1:length(setting.zPlatform) 
    
% Find i_zB where zPlatform is found in the B vectorfield array
 i_zB=find((abs(BinfoWOI.Interval_z-setting.zPlatform(i_zPlatform))<=...
     0.5*BinfoWOI.stepsize_z));
 if isempty(i_zB)==1
     pause
 end
 i_z=[i_zPlatform,i_zB];
 
    for i_sign=1:3 % 3 loops to consider d or alpha < 0, > 0, = 0
        if i_sign==3 % Take shortcut for d or alpha=0 in the final loop3
			break;          
        else
            for i_MR=1:length(setting.MR_half)

                %  Computes magnetic moment m for specific input   
                m=getMoment_m(setting,i_sign,i_MR,M);

                % Get points of equilibria in poe using angles as input
                [poe1D]=getEqu1D...
                    (setting,poe1D,i_z,i_sign,i_MR,Bmatfile,BinfoWOI,m);
                [poe2D]=getEqu2D...
                    (setting,poe2D,i_z,i_sign,i_MR,Bmatfile,BinfoWOI,m);  
            end % i_MR 
        end % if sign == 3             
    end % i_sign    
    
% Get poe array for alpha=0 or d=0
m0=getMoment_m(setting,i_sign,i_MR,M);
   
[poe1D]=getEqu1D(setting,poe1D,i_z,i_sign,i_MR,Bmatfile,BinfoWOI,m0);
[poe2D]=getEqu2D(setting,poe2D,i_z,i_sign,i_MR,Bmatfile,BinfoWOI,m0);  
end % i_zPlatform   

delete Bsuperpos.mat

%% 7. Visualisation
visualiseSimulation(setting,poe1D,poe2D,'zPlatform');
% save('poe','poe_1D','poe_2D')