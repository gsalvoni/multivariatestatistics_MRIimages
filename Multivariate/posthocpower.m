%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generation of the Bland-Altman plot using the function bland_altman_plot %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load the images of interest

palm = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\4_mod\GM_vox_npc_fisher_fwep.nii';
Vp = spm_vol(palm);
[Yp, ~] = spm_read_vols(Vp);

uni = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\1_mod\R2s\R2s_vox_tstat_cfwep_c1.nii';
Vu = spm_vol(uni);
[Yu, ~] = spm_read_vols(Vu);

duo = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\2_mod\AR2s\GM_AR2s_vox_npc_fisher_fwep.nii';
Vd = spm_vol(duo);
[Yd, ~] = spm_read_vols(Vd);

trio = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\3_mod\R2s_R1_A\GM_R1AR2s_vox_npc_fisher_fwep.nii';
Vt = spm_vol(trio);
[Yt, ~] = spm_read_vols(Vt);

mask = 'C:\Users\gsalvoni\Documents\Dataset\WinnerTakesAllMask_GM.nii';
Vm = spm_vol(mask);
[Ym, ~] = spm_read_vols(Vm);

%% Bland-Altman plots

bland_altman_plot(Ym, Yu, Yd); %between 1 and 2
bland_altman_plot(Ym, Yd, Yt); %btw 2 and 3
bland_altman_plot(Ym, Yt, Yp); %btw 3 and 4

bland_altman_plot(Ym, Yu, Yp); %between 1 and 4
bland_altman_plot(Ym, Yd, Yp); %btw 2 and 4
bland_altman_plot(Ym, Yt, Yp); %btw 3 and 4
