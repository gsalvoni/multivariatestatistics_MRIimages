%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script allows to create a NIFTI image highlighting the voxels that %
% are activated in the multivariate analysis from PALM but that are not  %
% present in any of the univariate analyses from SPM.                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load the relevant files

palm = 'C:\Users\gsalvoni\Documents\MATLAB\PALM_MULTI_n=1000\GM\GM_vox_npc_fisher_fwep.nii';
Vp = spm_vol(palm);
[Yp, XYZp] = spm_read_vols(Vp);

spm_R2s = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMR2stest\Fage_FWE0125.nii';
VR2 = spm_vol(spm_R2s);
[YR2, ~] = spm_read_vols(VR2);

spm_R1 = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMR1test\Fage_FWE0125.nii';
VR1 = spm_vol(spm_R1);
[YR1, ~] = spm_read_vols(VR1);

spm_MT = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMMTtest\Fage_FWE0125.nii';
VMT = spm_vol(spm_MT);
[YMT, ~] = spm_read_vols(VMT);

spm_A = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMAtest\Fage_FWE0125.nii';
VA = spm_vol(spm_A);
[YA, ~] = spm_read_vols(VA);

mask = 'C:\Users\gsalvoni\Documents\Dataset\WinnerTakesAllMask_GM.nii';
Vm = spm_vol(mask);
[Ym, ~] = spm_read_vols(Vm);

% Put NaN values (from the F-scores saved from SPM) to 0
YR2(isnan(YR2(:))==1) = 0;
YR1(isnan(YR1(:))==1) = 0;
YMT(isnan(YMT(:))==1) = 0;
YA(isnan(YA(:))==1) = 0;

%%

val = Yp;
cmp = 0;
for i=1:181
    for j=1:217
        for k=1:181
            % Check in all voxels which one are significant in PALM but not
            % found in any of the SPM univariate
            if val(i,j,k)<0.05 && val(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)==0 && YMT(i,j,k)==0 && YA(i,j,k)==0 
                cmp = cmp+1;
                val(i,j,k) = 100;
            end
        end
    end
end

% Count the percentage of these voxels
palm_act = sum(Yp(:)<0.05)-sum(Yp(:)==0);
multi_notuni = 100*cmp/palm_act

%% Create the NIFTI image

Vnew = Vp(1);

Vnew.fname = spm_file(Vnew.fname, 'prefix', '3percent_');
Vnew.dt(1) = Vp.dt(1);

Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,val);