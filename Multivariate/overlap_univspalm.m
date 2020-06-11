%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Voxels overlap between set of univariate and PALM.          %
% Creation of the tables union and intersection to see        %
% what can be gained and lost using the multivariate analysis.%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load files of interest

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

% Put all NaN values to 0
YR2(isnan(YR2(:))==1) = 0;
YR1(isnan(YR1(:))==1) = 0;
YMT(isnan(YMT(:))==1) = 0;
YA(isnan(YA(:))==1) = 0;

%% INTERSECTION

uno = zeros(4,1);
duo = zeros(6,1);
trio = zeros(4,1);
quatro = 0;

for i=1:181
    for j=1:217
        for k=1:181
            %% One modality
            % overlap between PALM and R2*
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)~=0 && YR1(i,j,k)==0 && YMT(i,j,k)==0 && YA(i,j,k)==0
                uno(1) = uno(1)+1;
            end
            % overlap between PALM and R1
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)~=0 && YMT(i,j,k)==0 && YA(i,j,k)==0
                uno(2) = uno(2)+1;
            end
            % overlap between PALM and MT
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)==0 && YMT(i,j,k)~=0 && YA(i,j,k)==0
                uno(3) = uno(3)+1;
            end
            % overlap between PALM and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)==0 && YMT(i,j,k)==0 && YA(i,j,k)~=0
                uno(4) = uno(4)+1;
            end
            %% Two modalities
            % overlap between PALM, R2* and R1
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)~=0 && YR1(i,j,k)~=0 && YMT(i,j,k)==0 && YA(i,j,k)==0
                duo(1) = duo(1)+1;
            end
            % overlap between PALM, R2* and MT
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)~=0 && YR1(i,j,k)==0 && YMT(i,j,k)~=0 && YA(i,j,k)==0
                duo(2) = duo(2)+1;
            end
            % overlap between PALM, R2* and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)~=0 && YR1(i,j,k)==0 && YMT(i,j,k)==0 && YA(i,j,k)~=0
                duo(3) = duo(3)+1;
            end
            % overlap between PALM, R1 and MT
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)~=0 && YMT(i,j,k)~=0 && YA(i,j,k)==0
                duo(4) = duo(4)+1;
            end
            % overlap between PALM, R1 and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)~=0 && YMT(i,j,k)==0 && YA(i,j,k)~=0
                duo(5) = duo(5)+1;
            end
            % overlap between PALM, MT and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)==0 && YMT(i,j,k)~=0 && YA(i,j,k)~=0
                duo(6) = duo(6)+1;
            end
            %% Three modalities
            % overlap between PALM, R2*, R1 and MT
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)~=0 && YR1(i,j,k)~=0 && YMT(i,j,k)~=0 && YA(i,j,k)==0
                trio(1) = trio(1)+1;
            end
            % overlap between PALM, R2*, MT and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)~=0 && YR1(i,j,k)==0 && YMT(i,j,k)~=0 && YA(i,j,k)~=0
                trio(2) = trio(2)+1;
            end
            % overlap between PALM, R2*, R1 and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)~=0 && YR1(i,j,k)~=0 && YMT(i,j,k)==0 && YA(i,j,k)~=0
                trio(3) = trio(3)+1;
            end
            % overlap between PALM, R1, MT and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)~=0 && YMT(i,j,k)~=0 && YA(i,j,k)~=0
                trio(4) = trio(4)+1;
            end
            %% Four modalities
            % overlap between PALM and all UNIs
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)~=0 && YR1(i,j,k)~=0 && YMT(i,j,k)~=0 && YA(i,j,k)~=0
                quatro = quatro+1;
            end
        end
    end
end

%% Of the voxels activated in some UNI, what is the % also present in PALM?

tot_voxact_uno = [sum(YR2(:)~=0); sum(YR1(:)~=0); sum(YMT(:)~=0); sum(YA(:)~=0)];
uno = 100*uno./tot_voxact_uno;

tot_voxact_duo = [sum(YR2(:)~=0 & YR1(:)~=0); sum(YR2(:)~=0 & YMT(:)~=0); sum(YR2(:)~=0 & YA(:)~=0); sum(YR1(:)~=0 & YMT(:)~=0); sum(YR1(:)~=0 & YA(:)~=0); sum(YMT(:)~=0 & YA(:)~=0)];
duo = 100*duo./tot_voxact_duo;

tot_voxact_trio = [sum(YR2(:)~=0 & YR1(:)~=0 & YMT(:)~=0); sum(YR2(:)~=0 & YMT(:)~=0 & YA(:)~=0); sum(YR2(:)~=0 & YR1(:)~=0 & YA(:)~=0); sum(YR1(:)~=0 & YMT(:)~=0 & YA(:)~=0)];
trio = 100*trio./tot_voxact_trio;

tot_voxact_quatro = sum(YR2(:)~=0 & YR1(:)~=0 & YMT(:)~=0 & YA(:)~=0);
quatro = 100*quatro/tot_voxact_quatro;

%% Of the voxels activated in PALM, what is the % also present in some UNI?

tot_nb_palm = sum(Yp(:)<0.05 & Yp(:)~=0);
uno = 100*uno./tot_nb_palm;
duo = 100*duo./tot_nb_palm;
trio = 100*trio./tot_nb_palm;
quatro = 100*quatro/tot_nb_palm;

%% Of the voxels activated in the intersection of SPM, what is the % also present in some UNI?
tot_union = sum(YR2(:)~=0 & YR1(:)~=0 & YMT(:)~=0 & YA(:)~=0);
uno = 100*uno./tot_union;
duo = 100*duo./tot_union;
trio = 100*trio./tot_union;
quatro = 100*quatro/tot_union;


%% UNION

uno = zeros(4,1);
duo = zeros(6,1);
trio = zeros(4,1);
quatro = 0;

for i=1:181
    for j=1:217
        for k=1:181
            %% One modality
            % overlap between PALM and R2*
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)~=0 && YR1(i,j,k)==0 && YMT(i,j,k)==0 && YA(i,j,k)==0
                uno(1) = uno(1)+1;
            end
            % overlap between PALM and R1
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)~=0 && YMT(i,j,k)==0 && YA(i,j,k)==0
                uno(2) = uno(2)+1;
            end
            % overlap between PALM and MT
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)==0 && YMT(i,j,k)~=0 && YA(i,j,k)==0
                uno(3) = uno(3)+1;
            end
            % overlap between PALM and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)==0 && YMT(i,j,k)==0 && YA(i,j,k)~=0
                uno(4) = uno(4)+1;
            end
            %% Two modalities
            % overlap between PALM and the union of R2* and R1
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && (YR2(i,j,k)~=0 || YR1(i,j,k)~=0) && YMT(i,j,k)==0 && YA(i,j,k)==0
                duo(1) = duo(1)+1;
            end
            % overlap between PALM and the union of R2* and MT
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && (YR2(i,j,k)~=0 || YMT(i,j,k)~=0) && YR1(i,j,k)==0 && YA(i,j,k)==0
                duo(2) = duo(2)+1;
            end
            % overlap between PALM and the union of R2* and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && (YR2(i,j,k)~=0 || YA(i,j,k)~=0) && YR1(i,j,k)==0 && YMT(i,j,k)==0 
                duo(3) = duo(3)+1;
            end
            % overlap between PALM and the union of R1 and MT
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && (YR1(i,j,k)~=0 || YMT(i,j,k)~=0) && YA(i,j,k)==0
                duo(4) = duo(4)+1;
            end
            % overlap between PALM and the union of R1 and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YMT(i,j,k)==0 && (YR1(i,j,k)~=0 || YA(i,j,k)~=0)
                duo(5) = duo(5)+1;
            end
            % overlap between PALM and the union of MT and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && YR1(i,j,k)==0 && (YMT(i,j,k)~=0 || YA(i,j,k)~=0)
                duo(6) = duo(6)+1;
            end
            %% Three modalities
            % overlap between PALM and the union of R2*, R1 and MT
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && (YR2(i,j,k)~=0 || YR1(i,j,k)~=0 || YMT(i,j,k)~=0) && YA(i,j,k)==0
                trio(1) = trio(1)+1;
            end
            % overlap between PALM and the union of R2*, MT and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && (YR2(i,j,k)~=0 || YMT(i,j,k)~=0 || YA(i,j,k)~=0) && YR1(i,j,k)==0
                trio(2) = trio(2)+1;
            end
            % overlap between PALM and the union of R2*, R1 and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && (YR2(i,j,k)~=0 || YR1(i,j,k)~=0 || YA(i,j,k)~=0) && YMT(i,j,k)==0
                trio(3) = trio(3)+1;
            end
            % overlap between PALM and the union of R1, MT and A
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && YR2(i,j,k)==0 && (YR1(i,j,k)~=0 || YMT(i,j,k)~=0 || YA(i,j,k)~=0)
                trio(4) = trio(4)+1;
            end
            %% Four modalities
            % overlap between PALM and the union of all UNIs
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && (YR2(i,j,k)~=0 || YR1(i,j,k)~=0 || YMT(i,j,k)~=0 || YA(i,j,k)~=0)
                quatro = quatro+1;
            end
        end
    end
end

%% Of the voxels activated in some UNI, what is the % also present in PALM?

tot_voxact_uno = [sum(YR2(:)~=0); sum(YR1(:)~=0); sum(YMT(:)~=0); sum(YA(:)~=0)];
uno = 100*uno./tot_voxact_uno;

tot_voxact_duo = [sum(YR2(:)~=0 | YR1(:)~=0); sum(YR2(:)~=0 | YMT(:)~=0); sum(YR2(:)~=0 | YA(:)~=0); sum(YR1(:)~=0 | YMT(:)~=0); sum(YR1(:)~=0 | YA(:)~=0); sum(YMT(:)~=0 | YA(:)~=0)];
duo = 100*duo./tot_voxact_duo;

tot_voxact_trio = [sum(YR2(:)~=0 | YR1(:)~=0 | YMT(:)~=0); sum(YR2(:)~=0 | YMT(:)~=0 | YA(:)~=0); sum(YR2(:)~=0 | YR1(:)~=0 | YA(:)~=0); sum(YR1(:)~=0 | YMT(:)~=0 | YA(:)~=0)];
trio = 100*trio./tot_voxact_trio;

tot_voxact_quatro = sum(YR2(:)~=0 | YR1(:)~=0 | YMT(:)~=0 | YA(:)~=0);
quatro = 100*quatro/tot_voxact_quatro;

%% Of the voxels activated in PALM, what is the % also present in some UNI?

tot_nb_palm = sum(Yp(:)<0.05 & Yp(:)~=0);
uno = 100*uno./tot_nb_palm;
duo = 100*duo./tot_nb_palm;
trio = 100*trio./tot_nb_palm;
quatro = 100*quatro/tot_nb_palm;

%% Of the voxels activated in the union of SPM, what is the % also present in some UNI?
tot_union = sum(YR2(:)~=0 | YR1(:)~=0 | YMT(:)~=0 | YA(:)~=0);
uno = 100*uno./tot_union;
duo = 100*duo./tot_union;
trio = 100*trio./tot_union;
quatro = 100*quatro/tot_union;