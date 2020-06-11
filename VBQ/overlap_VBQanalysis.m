%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script identifies the overlap between the modified       %
% VBQ analysis of two different modalities. In particular, the %
% Dice coefficient and the image_overlap functions are used    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the files 
A = 'C:\Users\gsalvoni\Documents\Dataset\Mask\WMR1test_VBQ\Binary_Fage_005.nii';
Va = spm_vol(A);
[Ya, ~] = spm_read_vols(Va);

B = 'C:\Users\gsalvoni\Documents\Dataset\Mask\WMR2stest_VBQ\Binary_Fage_005.nii';
Vb = spm_vol(B);
[Yb, ~] = spm_read_vols(Vb);

%% Image overlap function

[mJ,mHd,overlap] = image_overlap(B,A);

%% Dice coefficient

vox_act = sum(Ya(:)==1);
vox_act_snd = sum(Yb(:)==1);

coord_first = zeros(vox_act,3);
coord_snd = zeros(vox_act_snd,3);

cmp = 1;
cmp_s = 1;
for i = 1:121
    for j = 1:145
        for k = 1:121
            if Ya(i,j,k) == 1 
                coord_first(cmp,1) = i;
                coord_first(cmp,2) = j;
                coord_first(cmp,3) = k;
                cmp = cmp+1;
            end
            
            if Yb(i,j,k) == 1 
                coord_snd(cmp_s,1) = i;
                coord_snd(cmp_s,2) = j;
                coord_snd(cmp_s,3) = k;
                cmp_s = cmp_s+1;
            end
        end
    end
end

nb_overlap = size(intersect(coord_first,coord_snd,'rows'), 1);

dice = 2*nb_overlap/((cmp-1)+(cmp_s-1));
    