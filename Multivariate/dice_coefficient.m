%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine the overlap of voxels activated between two NIFTI images.   %   
% The two images are in this case, p-values images obtained from PALM.  %
% In this sense, the Dice coefficient is computed. The aim is to assess %
% the minimum number of permutations required for stable results.       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Selection of the two images to compare

first = spm_select(1,'image');
Vm = spm_vol(first);
[Ym, XYZ] = spm_read_vols(Vm);

snd = spm_select(1,'image');
Vms = spm_vol(snd);
[Yms, XYZs] = spm_read_vols(Vms);

%% Pick up the coordinates of the activated voxels in each image

% Only considering the voxels under a threshold of 0.05
Ym(Ym >= 0.05) = 0;
Yms(Yms >= 0.05) = 0;

vox_act = sum(Ym(:)<0.05)-sum(Ym(:)==0);
vox_act_snd = sum(Yms(:)<0.05)-sum(Yms(:)==0);

coord_first = zeros(vox_act,3);
coord_snd = zeros(vox_act_snd,3);

cmp = 1;
cmp_s = 1;
for i = 1:181
    for j = 1:217
        for k = 1:181
            if Ym(i,j,k) > 0 
                coord_first(cmp,1) = i;
                coord_first(cmp,2) = j;
                coord_first(cmp,3) = k;
                cmp = cmp+1;
            end
            
            if Yms(i,j,k) > 0
                coord_snd(cmp_s,1) = i;
                coord_snd(cmp_s,2) = j;
                coord_snd(cmp_s,3) = k;
                cmp_s = cmp_s+1;
            end
        end
    end
end

%% Find the overlapping voxels

nb_overlap = size(intersect(coord_first,coord_snd,'rows'), 1);

%% Compute the dice coefficient

% smaller_to_2000 = 100*(cmp-1)/(cmp_s-1); % comparison w.r.t 2000
% permutations
dice = 2*nb_overlap/((cmp-1)+(cmp_s-1));