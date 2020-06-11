%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script allows to concatenate the 3D volumes of all participants   %
% into a 4D image. The use of a 4D volume is a requirement for PALM.    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Chose the files to concatenate
load('C:\Users\gsalvoni\Documents\Dataset\Analysis 20121221T171249_Subjects_modified');
V = Subjects.GMR2s;

% Use the related spm function
spm_file_merge(V,'GMR2s4D.nii',0);
