%% trimArrayEdges
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190604
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER  
% Used by:      addMagnet.m
% Description:  Trim edges to have identical max and min intervalls
%-------------------------------------------------------------------------
function [bArray_trimmed,set_trimmed]=...
    trimArrayEdges(set2trim,setWanted,bArray2trim)
%% Check if Intervalls are the same in x
if set2trim.Intmin_x == setWanted.Intmin_x && ...
   set2trim.Intmax_x == setWanted.Intmax_x

    toDelete_x=false(set2trim.nbpoints_x,1); % Nothing to delete
else
    % Find values to delete on negative end
    toDelete_x_neg =set2trim.Intervall_x < int16(setWanted.Intmin_x);     
    % Find values to delete on pos end
    toDelete_x_pos =set2trim.Intervall_x > int16(setWanted.Intmax_x); 
    
    % Combine both
    toDelete_x=toDelete_x_neg|toDelete_x_pos;
    
    % Proceed with deleting
    set2trim.Intervall_x(toDelete_x)=[]; % Update Intervall
end

%% Check if Intervalls are the same in y
if set2trim.Intmin_y == setWanted.Intmin_y && ...
   set2trim.Intmax_y == setWanted.Intmax_y

    toDelete_y=false(set2trim.nbpoints_y,1); % Nothing to delete
else
    % Find values to delete on negative end
    toDelete_y_neg =set2trim.Intervall_y < int16(setWanted.Intmin_y);     
    % Find values to delete on pos end
    toDelete_y_pos =set2trim.Intervall_y > int16(setWanted.Intmax_y); 
    
    % Combine both
    toDelete_y=toDelete_y_neg|toDelete_y_pos;
    
    % Proceed with deleting
    set2trim.Intervall_y(toDelete_y)=[]; % Update Intervall
end

%% Check if Intervalls are the same in z
if set2trim.Intmin_z == setWanted.Intmin_z && ...
   set2trim.Intmax_z == setWanted.Intmax_z

    toDelete_z=false(set2trim.nbpoints_z,1); % Nothing to delete
else
    % Find values to delete on negative end
    toDelete_z_neg =set2trim.Interval_z < int16(setWanted.Intmin_z);     
    % Find values to delete on pos end
    toDelete_z_pos =set2trim.Interval_z > int16(setWanted.Intmax_z);
    
    % Combine both
    toDelete_z=toDelete_z_neg|toDelete_z_pos;
    
    % Proceed with deleting
    set2trim.Interval_z(toDelete_z)=[]; % Update Intervall
end
    bArray2trim.x(toDelete_x,:,:) = []; 
    bArray2trim.y(toDelete_x,:,:) = [];
    bArray2trim.z(toDelete_x,:,:) = [];  

    bArray2trim.x(:,toDelete_y,:) = []; 
    bArray2trim.y(:,toDelete_y,:) = [];
    bArray2trim.z(:,toDelete_y,:) = [];
    
    bArray2trim.x(:,:,toDelete_z) = []; 
    bArray2trim.y(:,:,toDelete_z) = [];
    bArray2trim.z(:,:,toDelete_z) = []; 

%% Update chosen settings based on set.intervall x,y,z
[set_trimmed]=updateBFileProperties(set2trim);
bArray_trimmed=bArray2trim;
