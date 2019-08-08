%% moveOrientMagnet
%------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190605
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      addMagnet.m
% Description:  Change position and orientation of Magnet
%------------------------------------------------------------------------
function b_list=moveOrientMagnet(Binfo,B,CV,EA)

% test
% [B,Binfo]=smalltest();



%% Prepare for displacement and orientation
% Calculate Sines and Cosines
c1 = cos(EA(1));
s1 = sin(EA(1));
c2 = cos(EA(2));
s2 = sin(EA(2));
c3 = cos(EA(3));
s3 = sin(EA(3));

% Calculate Rotation Matrix
R = [c1*c2           -c2*s1          s2
     c3*s1+c1*s2*s3  c1*c3-s1*s2*s3  -c2*s3
     s1*s3-c1*c3*s2  c3*s1*s2+c1*s3  c2*c3]';

 % test for magnetic moment rotation
 save('rotationmatrix','R')
 
%% Proceed with Shifting and Rotation for each cell
i_all=1;
for i_z=1:length(Binfo.Interval_z)
    for i_y=1:length(Binfo.Interval_y)
        for i_x=1:length(Binfo.Interval_x)
            % Form column B vector at this spatial point
            Bvec=[B.x(i_x,i_y,i_z);B.y(i_x,i_y,i_z);B.z(i_x,i_y,i_z)];

            % Transform Intervalls to double
            [Binfo]=transfInterval(Binfo,'int2double');
            
            % Form vector for spatial point in normal workspace
            xyzvec=[Binfo.Interval_x(i_x);...
                Binfo.Interval_y(i_y);...
                Binfo.Interval_z(i_z)];
            
            % Rotate B-vector
            BvecRot=R*Bvec;
            
            % Rotate and translate spatial vector
            xyzvecRot=R*xyzvec+CV;
            
            % Save resulting vector data in list        
            b_list(i_all,:)=[xyzvecRot',BvecRot'];
            i_all=i_all+1;
        end
    end
end