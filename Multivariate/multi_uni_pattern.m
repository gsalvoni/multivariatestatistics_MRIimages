%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some comparisons between the patterns in the multivariate and in the %
% univariate cases                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load the files of interest

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

%% Mask

vox_tot = size(Ym,1) * size(Ym,2) * size(Ym,3);
% Get the number of 1 in the mask
nb_one = sum(Ym(:)==1);

%% Multivariate activation (FWE<0.05)

% Percentage of voxels activated in PALM with p<0.05
palm_act = sum(Yp(:)<0.05)-sum(Yp(:)==0);
perc_palm = 100 * palm_act/nb_one;

%% Is multivariate the union of the univariate ? 

% Percentage of activation in each univariate 
act_uni = [sum(isnan(YR2(:))==0), sum(isnan(YR1(:))==0), sum(isnan(YMT(:))==0), sum(isnan(YA(:))==0)];
act_uni = 100 * act_uni/nb_one;

% Put all NaN = 0
YR2(isnan(YR2(:))==1) = 0;
YR1(isnan(YR1(:))==1) = 0;
YMT(isnan(YMT(:))==1) = 0;
YA(isnan(YA(:))==1) = 0;

% val = the union of them
val = YR1 + YR2 + YMT + YA;
% Percentage of activation of the union
union = 100 * sum(val(:)~=0)/nb_one;

%% Percentage of voxels activated in the multivariate case but in any of the univariate ?

cmp = 0;
for i=1:181
    for j=1:217
        for k=1:181
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)==0 && YMT(i,j,k)==0 && YA(i,j,k)==0 
                cmp = cmp+1;
            end
        end
    end
end
multi_notuni = 100*cmp/palm_act;

%% Dice coefficient between PALM and each univariate

coord_palm = zeros(palm_act,3);
coord_R2 = zeros(sum(YR2(:)~=0),3);
coord_R1 = zeros(sum(YR1(:)~=0),3);
coord_MT = zeros(sum(YMT(:)~=0),3);
coord_A = zeros(sum(YA(:)~=0),3);

cmp = zeros(5,1);
for i = 1:181
    for j = 1:217
        for k = 1:181
            if Yp(i,j,k) > 0 && Yp(i,j,k) < 0.05 
                cmp(1) = cmp(1)+1;
                coord_palm(cmp(1),1) = i;
                coord_palm(cmp(1),2) = j;
                coord_palm(cmp(1),3) = k;
            end
            if YR2(i,j,k)~=0
                cmp(2) = cmp(2)+1;
                coord_R2(cmp(2),1) = i;
                coord_R2(cmp(2),2) = j;
                coord_R2(cmp(2),3) = k;
            end
            if YR1(i,j,k)~=0     
                cmp(3) = cmp(3)+1;
                coord_R1(cmp(3),1) = i;
                coord_R1(cmp(3),2) = j;
                coord_R1(cmp(3),3) = k;
            end
            if YMT(i,j,k)~=0 
                cmp(4) = cmp(4)+1;
                coord_MT(cmp(4),1) = i;
                coord_MT(cmp(4),2) = j;
                coord_MT(cmp(4),3) = k;
            end
            if YA(i,j,k)~=0 
                cmp(5) = cmp(5)+1;
                coord_A(cmp(5),1) = i;
                coord_A(cmp(5),2) = j;
                coord_A(cmp(5),3) = k;
            end
        end
    end
end

nb_overlapR2 = size(intersect(coord_palm,coord_R2,'rows'), 1);
diceR2 = 2*nb_overlapR2/(cmp(1)+cmp(2));

nb_overlapR1 = size(intersect(coord_palm,coord_R1,'rows'), 1);
diceR1 = 2*nb_overlapR1/(cmp(1)+cmp(3));

nb_overlapMT = size(intersect(coord_palm,coord_MT,'rows'), 1);
diceMT = 2*nb_overlapMT/(cmp(1)+cmp(4));

nb_overlapA = size(intersect(coord_palm,coord_A,'rows'), 1);
diceA = 2*nb_overlapA/(cmp(1)+cmp(5));

%% Values of voxels activated in one of the univariate but not in multivariate

R2_vox = zeros(sum(YR2(:)~=0 & (Yp(:)>0.05 | Yp(:) == 0)),2);
R1_vox = zeros(sum(YR1(:)~=0 & (Yp(:)>0.05 | Yp(:) == 0)),2);
MT_vox = zeros(sum(YMT(:)~=0 & (Yp(:)>0.05 | Yp(:) == 0)),2);
A_vox = zeros(sum(YA(:)~=0 & (Yp(:)>0.05 | Yp(:) == 0)),2);
Nb_one = zeros(sum(Yp(:)==1 & (YR2(:)~=0 | YR1(:)~=0 | YMT(:)~=0 | YA(:)~=0)),5);
idx = zeros(5,1);
for i = 1:181
    for j = 1:217
        for k = 1:181
            % Activated in R2s but not in PALM(<0.05)
            if YR2(i,j,k) ~= 0 && (Yp(i,j,k) > 0.05 || Yp(i,j,k) == 0)
                idx(1) = idx(1)+1;
                R2_vox(idx(1),1) = Yp(i,j,k);
                R2_vox(idx(1),2) = YR2(i,j,k);
            end
            % Activated in R1 but not in PALM(<0.05)
            if YR1(i,j,k) ~= 0 && (Yp(i,j,k) > 0.05 || Yp(i,j,k) == 0)
                idx(2) = idx(2)+1;
                R1_vox(idx(2),1) = Yp(i,j,k);
                R1_vox(idx(2),2) = YR1(i,j,k);
            end
            % Activated in MT but not in PALM(<0.05)
            if YMT(i,j,k) ~= 0 && (Yp(i,j,k) > 0.05 || Yp(i,j,k) == 0)
                idx(3) = idx(3)+1;
                MT_vox(idx(3),1) = Yp(i,j,k);
                MT_vox(idx(3),2) = YMT(i,j,k);
            end
            % Activated in A but not in PALM(<0.05)
            if YA(i,j,k) ~= 0 && (Yp(i,j,k) > 0.05 || Yp(i,j,k) == 0)
                idx(4) = idx(4)+1;
                A_vox(idx(4),1) = Yp(i,j,k);
                A_vox(idx(4),2) = YA(i,j,k);
            end  
            % Activated in at least 1 uni but not in PALM
            if Yp(i,j,k)==1 && (YR2(i,j,k)~=0 || YR1(i,j,k)~=0 || YMT(i,j,k)~=0 || YA(i,j,k)~=0) 
                idx(5) = idx(5)+1;
                Nb_one(idx(5),1) = YR2(i,j,k);
                Nb_one(idx(5),2) = YR1(i,j,k);
                Nb_one(idx(5),3) = YMT(i,j,k);
                Nb_one(idx(5),4) = YA(i,j,k);
                Nb_one(idx(5),5) = sum(Nb_one(idx(5),:)~=0);
                % shows that when PALM does not detect a voxel at all, but at
                % least one univariate detected it, only one modality
                % detected it
            end    
        end
    end
end
