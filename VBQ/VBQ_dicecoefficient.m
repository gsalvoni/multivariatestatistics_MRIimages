%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine the overlap of voxels activated between two NIFTI images.   %   
% The two images are in this case, F-scores of various VBQ analyses.    %
% In this sense, the Dice coefficient is computed.                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Selection of the two images to compare

first = spm_select;
Vm = spm_vol(first);
[Ym, ~] = spm_read_vols(Vm);

snd = spm_select;
Vms = spm_vol(snd);
[Yms, ~] = spm_read_vols(Vms);

% Remove NaN values
Ym(isnan(Ym(:))==1) = 0;
Yms(isnan(Yms(:))==1) = 0;

%% Coordinates of the activated voxels in each image

vox_act = sum(Ym(:)~=0);
vox_act_snd = sum(Yms(:)~=0);

coord_first = zeros(vox_act,3);
coord_snd = zeros(vox_act_snd,3);

cmp = 1;
cmp_s = 1;
for i = 1:121
    for j = 1:145
        for k = 1:121
            if Ym(i,j,k) ~= 0 
                coord_first(cmp,1) = i;
                coord_first(cmp,2) = j;
                coord_first(cmp,3) = k;
                cmp = cmp+1;
            end
            
            if Yms(i,j,k) ~= 0
                coord_snd(cmp_s,1) = i;
                coord_snd(cmp_s,2) = j;
                coord_snd(cmp_s,3) = k;
                cmp_s = cmp_s+1;
            end
        end
    end
end

%% Find the percentage of overlap

nb_overlap = size(intersect(coord_first,coord_snd,'rows'), 1);

%% Compute the difference with 2000 and the dice coefficient

dice = 2*nb_overlap/((cmp-1)+(cmp_s-1));