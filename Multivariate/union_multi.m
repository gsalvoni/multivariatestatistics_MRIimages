%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script compares the union of the univariate analyses in SPM     %
% with the multivariate in PALM. The voxels present in PALM but not   %
% in the union as well as those present in the union but not in PALM  %
% are highlighted on a NIFTI image.                                   % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the files of interest
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

% Put NaN values to 0
YR2(isnan(YR2(:))==1) = 0;
YR1(isnan(YR1(:))==1) = 0;
YMT(isnan(YMT(:))==1) = 0;
YA(isnan(YA(:))==1) = 0;

union = YR2+YR1+YMT+YA;

%%
cmp = 0;
for i=1:181
    for j=1:217
        for k=1:181
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0
               Yp(i,j,k) = 10;
            end
            if Yp(i,j,k) == 10 && union(i,j,k)==0 
                cmp = cmp+1;
                Yp(i,j,k) = 100;
            end  
        end
    end
end
    
Vnew = Vp(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'ThoseNotInUNION_');
Vnew.dt(1) = 2;
Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,Yp);

%%
cmp2 = 0;
for i=1:181
    for j=1:217
        for k=1:181
            if union(i,j,k)~=0
               union(i,j,k) = 10;
            end
            if union(i,j,k)==10 && Yp(i,j,k)>0.05 
                cmp2 = cmp2+1;
                union(i,j,k) = 100;
            end  
        end
    end
end
    
Vnew2 = Vp(1);
Vnew2.fname = spm_file(Vnew2.fname, 'prefix', 'Union_of_uni_');
Vnew2.dt(1) = 2;
Vnew2 = spm_create_vol(Vnew2);
Vnew2 = spm_write_vol(Vnew2,union);
    