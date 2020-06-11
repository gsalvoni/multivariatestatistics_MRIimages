%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script highlights the voxels that are different between one       %
% non-parametric analysis and the other. The aim is to evaluate         %
% whether the differences are at the borders or if there are different  %
% clusters activated.                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load the files of interest

palm = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\4_mod\GM_vox_npc_fisher_fwep.nii';
Vp = spm_vol(palm);
[Yp, ~] = spm_read_vols(Vp);

uni = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\1_mod\R2s\R2s_vox_tstat_cfwep_c1.nii';
Vu = spm_vol(uni);
[Yu, ~] = spm_read_vols(Vu);

duo = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\2_mod\AR2s\GM_AR2s_vox_npc_fisher_fwep.nii';
Vd = spm_vol(duo);
[Yd, ~] = spm_read_vols(Vd);

trio = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_TestofPower\3_mod\R2s_R1_A\GM_R1AR2s_vox_npc_fisher_fwep.nii';
Vt = spm_vol(trio);
[Yt, ~] = spm_read_vols(Vt);

mask = 'C:\Users\gsalvoni\Documents\Dataset\WinnerTakesAllMask_GM.nii';
Vm = spm_vol(mask);
[Ym, ~] = spm_read_vols(Vm);

%% Percentage of voxels in one, not in the other

% Between R2s and 4 modalities
cmp = zeros(2,1);
for i=1:181
    for j=1:217
        for k=1:181
            if Yu(i,j,k)<0.05 && Yu(i,j,k)~=0 && Yp(i,j,k)>0.05
                cmp(1) = cmp(1)+1;
            end
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && Yu(i,j,k)>0.05
                cmp(2) = cmp(2)+1;
            end
        end
    end
end

perc14(1) = 100*cmp(1)/sum(Yu(:)<0.05 & Yu(:)~=0);
perc14(2) = 100*cmp(2)/sum(Yp(:)<0.05 & Yp(:)~=0);

% Between R2s-A and 4 modalities
cmp = zeros(2,1);
for i=1:181
    for j=1:217
        for k=1:181
            if Yd(i,j,k)<0.05 && Yd(i,j,k)~=0 && Yp(i,j,k)>0.05
                cmp(1) = cmp(1)+1;
            end
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && Yd(i,j,k)>0.05
                cmp(2) = cmp(2)+1;
            end
        end
    end
end

perc24(1) = 100*cmp(1)/sum(Yd(:)<0.05 & Yd(:)~=0);
perc24(2) = 100*cmp(2)/sum(Yp(:)<0.05 & Yp(:)~=0);

% Between R2s-A-R1 and 4 modalities
cmp = zeros(2,1);
for i=1:181
    for j=1:217
        for k=1:181
            if Yt(i,j,k)<0.05 && Yt(i,j,k)~=0 && Yp(i,j,k)>0.05
                cmp(1) = cmp(1)+1;
            end
            if Yp(i,j,k)<0.05 && Yp(i,j,k)~=0 && Yt(i,j,k)>0.05
                cmp(2) = cmp(2)+1;
            end
        end
    end
end

perc34(1) = 100*cmp(1)/sum(Yt(:)<0.05 & Yt(:)~=0);
perc34(2) = 100*cmp(2)/sum(Yp(:)<0.05 & Yp(:)~=0);

%% Compare R2s with 4 modalities

one_mod = Yu;
four_mod = Yp;

cmp = zeros(2,1);
cmp2 = zeros(2,1);
for i=1:181
    for j=1:217
        for k=1:181
            if one_mod(i,j,k)<0.05 && one_mod(i,j,k)~=0
                cmp2(1) = cmp2(1)+1;
                one_mod(i,j,k) = 10;
            end
            if one_mod(i,j,k)==10 && Yp(i,j,k)>0.05 
                cmp(1) = cmp(1)+1;
                one_mod(i,j,k) = 100;
            end  

            if four_mod(i,j,k)<0.05 && four_mod(i,j,k)~=0
                cmp2(2) = cmp2(2)+1;
                four_mod(i,j,k) = 10;
            end
            if four_mod(i,j,k)==10 && Yu(i,j,k)>0.05 
                cmp(2) = cmp(2)+1;
                four_mod(i,j,k) = 100;
            end  

        end
    end
end
    
Vnew = Vp(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'Diffwith1_');
Vnew.dt(1) = 2;
Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,four_mod);
    
Vnew2 = Vu(1);
Vnew2.fname = spm_file(Vnew2.fname, 'prefix', 'Diffwith4_');
Vnew2.dt(1) = 2;
Vnew2 = spm_create_vol(Vnew2);
Vnew2 = spm_write_vol(Vnew2,one_mod);

%% Compare R2s-A mod with 4

two_mod = Yd;
four_mod = Yp;

cmp = zeros(2,1);
cmp2 = zeros(2,1);
for i=1:181
    for j=1:217
        for k=1:181
            if two_mod(i,j,k)<0.05 && two_mod(i,j,k)~=0
                cmp2(1) = cmp2(1)+1;
                two_mod(i,j,k) = 10;
            end
            if two_mod(i,j,k)==10 && Yp(i,j,k)>0.05 
                cmp(1) = cmp(1)+1;
                two_mod(i,j,k) = 100;
            end  

            if four_mod(i,j,k)<0.05 && four_mod(i,j,k)~=0
                cmp2(2) = cmp2(2)+1;
                four_mod(i,j,k) = 10;
            end
            if four_mod(i,j,k)==10 && Yd(i,j,k)>0.05 
                cmp(2) = cmp(2)+1;
                four_mod(i,j,k) = 100;
            end  
        end
    end
end
    
Vnew = Vp(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'Diffwith2_');
Vnew.dt(1) = 2;
Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,four_mod);
    
Vnew2 = Vd(1);
Vnew2.fname = spm_file(Vnew2.fname, 'prefix', 'Diffwith4_');
Vnew2.dt(1) = 2;
Vnew2 = spm_create_vol(Vnew2);
Vnew2 = spm_write_vol(Vnew2,two_mod);
    

%% Compare R2s-A-R1 mod with 4

thr_mod = Yt;
four_mod = Yp;

cmp = zeros(2,1);
cmp2 = zeros(2,1);
for i=1:181
    for j=1:217
        for k=1:181
            if thr_mod(i,j,k)<0.05 && thr_mod(i,j,k)~=0
                cmp2(1) = cmp2(1)+1;
                thr_mod(i,j,k) = 10;
            end
            if thr_mod(i,j,k)==10 && Yp(i,j,k)>0.05 
                cmp(1) = cmp(1)+1;
                thr_mod(i,j,k) = 100;
            end  

            if four_mod(i,j,k)<0.05 && four_mod(i,j,k)~=0
                cmp2(2) = cmp2(2)+1;
                four_mod(i,j,k) = 10;
            end
            if four_mod(i,j,k)==10 && Yt(i,j,k)>0.05 
                cmp(2) = cmp(2)+1;
                four_mod(i,j,k) = 100;
            end  
        end
    end
end
    
Vnew = Vp(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'Diffwith3_');
Vnew.dt(1) = 2;
Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,four_mod);
    
Vnew2 = Vt(1);
Vnew2.fname = spm_file(Vnew2.fname, 'prefix', 'Diffwith4_');
Vnew2.dt(1) = 2;
Vnew2 = spm_create_vol(Vnew2);
Vnew2 = spm_write_vol(Vnew2,thr_mod);
    
%% Compare R2s mod with R2s-A

one_mod = Yu;
two_mod = Yd;

cmp = zeros(2,1);
cmp2 = zeros(2,1);
for i=1:181
    for j=1:217
        for k=1:181
            if two_mod(i,j,k)<0.05 && two_mod(i,j,k)~=0
                cmp2(1) = cmp2(1)+1;
                two_mod(i,j,k) = 10;
            end
            if two_mod(i,j,k)==10 && Yu(i,j,k)>0.05 
                cmp(1) = cmp(1)+1;
                two_mod(i,j,k) = 100;
            end  

            if one_mod(i,j,k)<0.05 && one_mod(i,j,k)~=0
                cmp2(2) = cmp2(2)+1;
                one_mod(i,j,k) = 10;
            end
            if one_mod(i,j,k)==10 && Yd(i,j,k)>0.05 
                cmp(2) = cmp(2)+1;
                one_mod(i,j,k) = 100;
            end  
        end
    end
end
    
Vnew = Vu(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'Diffwith2_');
Vnew.dt(1) = 2;
Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,one_mod);
    
Vnew2 = Vd(1);
Vnew2.fname = spm_file(Vnew2.fname, 'prefix', 'Diffwith1_');
Vnew2.dt(1) = 2;
Vnew2 = spm_create_vol(Vnew2);
Vnew2 = spm_write_vol(Vnew2,two_mod);
    

%% Compare R2s mod with R2s-A-R1

thr_mod = Yt;
one_mod = Yu;

cmp = zeros(2,1);
cmp2 = zeros(2,1);
for i=1:181
    for j=1:217
        for k=1:181
            if thr_mod(i,j,k)<0.05 && thr_mod(i,j,k)~=0
                cmp2(1) = cmp2(1)+1;
                thr_mod(i,j,k) = 10;
            end
            if thr_mod(i,j,k)==10 && Yu(i,j,k)>0.05 
                cmp(1) = cmp(1)+1;
                thr_mod(i,j,k) = 100;
            end  

            if one_mod(i,j,k)<0.05 && one_mod(i,j,k)~=0
                cmp2(2) = cmp2(2)+1;
                one_mod(i,j,k) = 10;
            end
            if one_mod(i,j,k)==10 && Yt(i,j,k)>0.05 
                cmp(2) = cmp(2)+1;
                one_mod(i,j,k) = 100;
            end  
        end
    end
end
    
Vnew = Vu(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'Diffwith3_');
Vnew.dt(1) = 2;
Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,one_mod);

Vnew2 = Vt(1);
Vnew2.fname = spm_file(Vnew2.fname, 'prefix', 'Diffwith1_');
Vnew2.dt(1) = 2;
Vnew2 = spm_create_vol(Vnew2);
Vnew2 = spm_write_vol(Vnew2,thr_mod);
    

%% Compare R2s-A mod with R2s-A-R1

thr_mod = Yt;
two_mod = Yd;

cmp = zeros(2,1);
cmp2 = zeros(2,1);
for i=1:181
    for j=1:217
        for k=1:181
            if thr_mod(i,j,k)<0.05 && thr_mod(i,j,k)~=0
                cmp2(1) = cmp2(1)+1;
                thr_mod(i,j,k) = 10;
            end
            if thr_mod(i,j,k)==10 && Yd(i,j,k)>0.05 
                cmp(1) = cmp(1)+1;
                thr_mod(i,j,k) = 100;
            end  

            if two_mod(i,j,k)<0.05 && two_mod(i,j,k)~=0
                cmp2(2) = cmp2(2)+1;
                two_mod(i,j,k) = 10;
            end
            if two_mod(i,j,k)==10 && Yt(i,j,k)>0.05 
                cmp(2) = cmp(2)+1;
                two_mod(i,j,k) = 100;
            end  
        end
    end
end
    
Vnew = Vd(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'Diffwith3_');
Vnew.dt(1) = 2;
Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,two_mod);

Vnew2 = Vt(1);
Vnew2.fname = spm_file(Vnew2.fname, 'prefix', 'Diffwith2_');
Vnew2.dt(1) = 2;
Vnew2 = spm_create_vol(Vnew2);
Vnew2 = spm_write_vol(Vnew2,thr_mod);
    
    