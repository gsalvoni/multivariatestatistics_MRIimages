%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use the image_overlap function to determine the overlap between  %
% 2 images in terms of both clusters and voxels.                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load the images of interest: non-param results

palm = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\4_mod\Binary_GM_vox_npc_fisher_fwep.nii';
uno = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\1_mod\R2s\Binary_R2s_vox_tstat_cfwep_c1.nii';
uno_MT = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\1_mod\MT\Binary_GM_MT_vox_tstat_cfwep_c2.nii';
duo = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\2_mod\Binary_GM_AR2s_vox_npc_fisher_fwep.nii';
trio = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\3_mod\R2s_R1_A\Binary_GM_R1AR2s_vox_npc_fisher_fwep.nii';
mask = 'C:\Users\gsalvoni\Documents\Dataset\WinnerTakesAllMask_GM.nii';

%Find the overlap
[mJ,mHd,overlap] = image_overlap(palm,uno_MT,mask);

%% Multivariate vs univariate results

palm = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\4_mod\Binary_GM_vox_npc_fisher_fwep.nii';
R2s = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMR2stest\Binary_Fage_FWE0125.nii';
R1 = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMR1test\Binary_Fage_FWE0125.nii';
MT = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMMTtest\Binary_Fage_FWE0125.nii';
A = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMAtest\Binary_Fage_FWE0125.nii';
union = 'C:\Users\gsalvoni\Documents\Dataset\Mask\Binary_unionFage_FWE0125.nii';
mask = 'C:\Users\gsalvoni\Documents\Dataset\WinnerTakesAllMask_GM.nii';

% Find the overlap
[mJ2,mHd2,overlap2] = image_overlap(palm,R2s,mask);


