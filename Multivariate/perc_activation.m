%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine the percentage of voxels activated in a file,  %
% either without a threshold or with a threshold of 0.05.  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Count the number of voxels in the mask, as a reference 

mask = spm_select(1,'image');
Vm = spm_vol(mask);
Ym = spm_read_vols(Vm);

vox_tot = size(Ym,1) * size(Ym,2) * size(Ym,3);
nb_one = sum(Ym(:)==1);
perc_one = 100 * nb_one/vox_tot;

%% Count the number of voxels activated in the output (without threshold)

output = spm_select(1,'image');
Vout = spm_vol(output);
Yout = spm_read_vols(Vout);

vox_act = sum(Yout(:)<1)-sum(Yout(:)==0);
perc_act = 100 * vox_act/nb_one;

%% Count the number of voxels activated in the output (with a 0.05 threshold)

vox_act_th = sum(Yout(:)<0.05)-sum(Yout(:)==0);
perc_act_th = 100 * vox_act_th/nb_one;

