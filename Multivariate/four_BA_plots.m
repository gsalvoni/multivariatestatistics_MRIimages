%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function creates Bland-Altman plot between 2 non-parametric %
% analyses carried out in PALM. 4 pairs are compared and the      %
% density of the points is represented.                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load the files of interest

uni_R2 = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\1_mod\R2s\R2s_vox_tstat_cfwep_c1.nii';
Vu = spm_vol(uni_R2);
[Yu, ~] = spm_read_vols(Vu);

uni_MT = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\1_mod\MT\GM_MT_vox_tstat_cfwep_c2.nii';
Vd = spm_vol(uni_MT);
[Yd, ~] = spm_read_vols(Vd);

duo_R2MT = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\2_mod\MTR2s\GM_MTR2s_vox_npc_fisher_fwep.nii';
Vt = spm_vol(duo_R2MT);
[Yt, ~] = spm_read_vols(Vt);

duo_R2R1 = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\2_mod\R1R2s\GM_R1R2s_vox_npc_fisher_fwep.nii';
Vm = spm_vol(duo_R2R1);
[Ym, ~] = spm_read_vols(Vm);

trio = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\3_mod\R2s_R1_MT\GM_R1MTR2s_vox_npc_fisher_fwep.nii';
Vz = spm_vol(trio);
[Yz, ~] = spm_read_vols(Vz);

maskk = 'C:\Users\gsalvoni\Documents\Dataset\WinnerTakesAllMask_GM.nii';
Vmask = spm_vol(maskk);
[Ymask, ~] = spm_read_vols(Vmask);

mask = Ymask;

figure; 

%% R2* - R2*/MT

lower_mod = Yu;
higher_mod = Yt;

size = sum(mask(:)==1 & lower_mod(:)~=1 & higher_mod(:)~=1);

voxels_l = zeros(size,1);
voxels_h = zeros(size,1);

cmp = 0;
for i=1:181
    for j=1:217
        for k=1:181
            if mask(i,j,k)~=0 && lower_mod(i,j,k)~=1 && higher_mod(i,j,k)~=1
                cmp = cmp+1;
                voxels_l(cmp) = lower_mod(i,j,k);
                voxels_h(cmp) = higher_mod(i,j,k);
            end
        end
    end
end

% Compute the difference and the average
difference = voxels_h - voxels_l;
average = (voxels_h + voxels_l)/2;

subplot(2,2,1);
X = [average, difference];
hist3(X,'Nbins', [100,100])
set(gca, 'FontSize', 12);
surfHandle = get(gca, 'child');
set(surfHandle,'FaceColor','interp', 'CdataMode', 'auto');
xlabel('Average of p-values', 'FontSize', 15);
ylabel('Difference of p-values', 'FontSize', 15);
title('Bland-Altman plot (R2s/MT - R2s)','FontSize', 15);
colormap(pink(200));
caxis([0 1.5e3])
view(2)
xlim([0 1])
ylim([-1 1])

%% R2*/MT/R1 - R2*/MT

lower_mod = Yt;
higher_mod = Yz;

size = sum(mask(:)==1 & lower_mod(:)~=1 & higher_mod(:)~=1);

voxels_l = zeros(size,1);
voxels_h = zeros(size,1);

cmp = 0;
for i=1:181
    for j=1:217
        for k=1:181
            if mask(i,j,k)~=0 && lower_mod(i,j,k)~=1 && higher_mod(i,j,k)~=1
                cmp = cmp+1;
                voxels_l(cmp) = lower_mod(i,j,k);
                voxels_h(cmp) = higher_mod(i,j,k);
            end
        end
    end
end

% Compute the difference and the average
difference = voxels_h - voxels_l;
average = (voxels_h + voxels_l)/2;

subplot(2,2,2);
X = [average, difference];
hist3(X,'Nbins', [100,100])
set(gca, 'FontSize', 12);
surfHandle = get(gca, 'child');
set(surfHandle,'FaceColor','interp', 'CdataMode', 'auto');
xlabel('Average of p-values', 'FontSize', 15);
ylabel('Difference of p-values', 'FontSize', 15);
title('Bland-Altman plot (R2s/MT/R1 - R2s/MT)','FontSize', 15);
colormap(pink(200));
c = colorbar('eastoutside');
caxis([0 1.5e3])
set(c,'Position',[.92 .11 .01 .81], 'YTick', 0:500:2500);
view(2)
xlim([0 1])
ylim([-1 1])

%% MT - R2*/MT

lower_mod = Yd;
higher_mod = Yt;

size = sum(mask(:)==1 & lower_mod(:)~=1 & higher_mod(:)~=1);

voxels_l = zeros(size,1);
voxels_h = zeros(size,1);

cmp = 0;
for i=1:181
    for j=1:217
        for k=1:181
            if mask(i,j,k)~=0 && lower_mod(i,j,k)~=1 && higher_mod(i,j,k)~=1
                cmp = cmp+1;
                voxels_l(cmp) = lower_mod(i,j,k);
                voxels_h(cmp) = higher_mod(i,j,k);
            end
        end
    end
end

% Compute the difference and the average
difference = voxels_h - voxels_l;
average = (voxels_h + voxels_l)/2;

subplot(2,2,3);
X = [average, difference];
hist3(X,'Nbins', [100,100])
set(gca, 'FontSize', 12);
surfHandle = get(gca, 'child');
set(surfHandle,'FaceColor','interp', 'CdataMode', 'auto');
xlabel('Average of p-values', 'FontSize', 15);
ylabel('Difference of p-values', 'FontSize', 15);
title('Bland-Altman plot (R2s/MT - MT)','FontSize', 15);
colormap(pink(200));
caxis([0 1.5e3])
view(2)
xlim([0 1])
ylim([-1 1])

%% R2*/MT/R1 - R2*/R1

lower_mod = Ym;
higher_mod = Yz;

size = sum(mask(:)==1 & lower_mod(:)~=1 & higher_mod(:)~=1);

voxels_l = zeros(size,1);
voxels_h = zeros(size,1);

cmp = 0;
for i=1:181
    for j=1:217
        for k=1:181
            if mask(i,j,k)~=0 && lower_mod(i,j,k)~=1 && higher_mod(i,j,k)~=1
                cmp = cmp+1;
                voxels_l(cmp) = lower_mod(i,j,k);
                voxels_h(cmp) = higher_mod(i,j,k);
            end
        end
    end
end

% Compute the difference and the average
difference = voxels_h - voxels_l;
average = (voxels_h + voxels_l)/2;

subplot(2,2,4);
X = [average, difference];
hist3(X,'Nbins', [100,100])
set(gca, 'FontSize', 12);
surfHandle = get(gca, 'child');
set(surfHandle,'FaceColor','interp', 'CdataMode', 'auto');
xlabel('Average of p-values', 'FontSize', 15);
ylabel('Difference of p-values', 'FontSize', 15);
title('Bland-Altman plot (R2s/MT/R1 - R2s/R1)','FontSize', 15);
colormap(pink(200));
caxis([0 1.5e3])
view(2)
xlim([0 1])
ylim([-1 1])