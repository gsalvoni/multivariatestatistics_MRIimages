%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Compare the Z-scores or the P-values       %
% between SPM and PALM in an univariate case %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Transform PALM p-values to z-scores

palm_img = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_GM\GM+R2s_n=1000\palm_vox_tstat_uncp.nii';
Vm = spm_vol(palm_img);
[Ym, ~] = spm_read_vols(Vm);

% P TO Z
z = @(p) sqrt(2) * erfcinv(p*2);
z_palm = z(Ym);

%% Transform SPM t-scores to z-scores

spm_img = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMR2stest\spmT_0001.nii';
Vs = spm_vol(spm_img);
[Ys, ~] = spm_read_vols(Vs);

dof = 133;
% T TO Z
z_spm = spm_t2z(Ys,dof);
% T TO P : better than T TO Z TO P
p_spm = spm_Tcdf(Ys,dof);

%% Z = 1 or 0, if Z scores or P values comparison respectively

z = 1;

cmp = 0;

if z == 1
% Z SCORES    
    z_scores = zeros(sum(z_palm(:)~=-Inf & z_spm(:)~=0),2);
    for i = 1:181
        for j = 1:217
            for k = 1:181
                if z_palm(i,j,k) ~= -Inf && z_spm(i,j,k) ~= 0
                    cmp = cmp + 1;
                    z_scores(cmp,1) = z_palm(i,j,k);
                    z_scores(cmp,2) = z_spm(i,j,k);
                end
            end
        end
    end
% P VALUES
elseif z == 0
    p_values = zeros(sum(Ym(:)~=0 & p_spm(:)~=0.5),2); 

    for i = 1:181
        for j = 1:217
            for k = 1:181
                if Ym(i,j,k) ~= 0 && p_spm(i,j,k)~=0.5
                    cmp = cmp+1;
                    p_values(cmp,1) = Ym(i,j,k);
                    p_values(cmp,2) = 1-p_spm(i,j,k);
                end
            end
        end
    end
end

%% PLOT
if z == 1
    h = plot(z_scores(:,1), z_scores(:,2),'.');
    set(h,'markersize',6);
    set(gca, 'FontSize', 12);
    xlabel('PALM', 'FontSize', 15);
    ylabel('SPM', 'FontSize', 15);
    title('Z-scores comparison','FontSize', 15);
elseif z == 0
    h = plot(p_values(:,1), p_values(:,2),'.');
    set(h,'markersize',6)
    set(gca, 'FontSize', 12);
    xlabel('PALM', 'FontSize', 15);
    ylabel('SPM', 'FontSize', 15);
    title('P-values comparison','FontSize', 15);
end