addpath 'C:\Users\gsalvoni\Documents\MATLAB\spm'

%%
% Which quantitative parameter you are looking for
q_param = 'R2s';
% Load the desired SPM.mat to get the Age vector
load('C:\Users\gsalvoni\Documents\Dataset\Mask\GMR2stest\SPM.mat')

%% 
% Select the images 
P = spm_select;
% Get images information
V = spm_vol(P);
% Select the corresponding mask
Mask = spm_select;
% Get the coordinates of the voxel as well as the intensity values
[Y, XYZ] = spm_read_vols(V, Mask); % Y = 4D double, XYZ = 3 x (vox_x*vox_y*vox_z)

%%
% Look at a location in mm
XYZmm = [10 17 -2];
% Search the coordinate in the XYZ volume
idx = find(XYZ(1,:)==XYZmm(1) & XYZ(2,:)==XYZmm(2) & XYZ(3,:)==XYZmm(3));
% Get the location you were looking for, confirmation purpose
% mm = XYZ(:,idx);
% Transform the volume index to voxel coordinates
[Xvox, Yvox, Zvox] = ind2sub(size(Y(:,:,:,1)),idx);

%%
% Calculate the intensity at the desired voxel
tc = Y(Xvox, Yvox, Zvox,:);

% If R1, change the unit from 1000/s to 1/s
if strcmp(q_param,'R1') == 1
    tc = tc/1000;
end
% If R2s, change the unit from .001/s to 1/s
if strcmp(q_param,'R2s') == 1
    tc = tc*1000;
end

%%

% tc is a 4D, need to be squeezed to plot 
tc_sq = squeeze(tc);

figure;
scatter(SPM.xC(1).rc, tc_sq);
xlabel('Age (years)');
ylabel('GMR2s (1/s)');
title('Caudate Nucleus [10 17 -2]');

p = polyfit(SPM.xC(1).rc, tc_sq, 1);
f = polyval(p,SPM.xC(1).rc);

hold on;
plot(SPM.xC(1).rc, f, 'r');