%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compare the t-scores between SPM and PALM in an univariate case %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%% Upload the files
palm = 'C:\Users\gsalvoni\Documents\MATLAB\Palm_GM\GM+R2s_n=1000\palm_vox_tstat.nii';
Vp = spm_vol(palm);
[Yp, ~] = spm_read_vols(Vp);

spm_img = 'C:\Users\gsalvoni\Documents\Dataset\Mask\GMR2stest\spmT_0001.nii';
Vs = spm_vol(spm_img);
[Ys, ~] = spm_read_vols(Vs);

mask = 'C:\Users\gsalvoni\Documents\Dataset\WinnerTakesAllMask_GM.nii';
Vm = spm_vol(mask);
[Ym, ~] = spm_read_vols(Vm);


%% Bland-Altman plot with the results

size = sum(Yp(:)~=0 & Ys(:)~=0);

voxels_palm = zeros(size,1);
voxels_spm = zeros(size,1);

cmp = 0;
for i=1:181
    for j=1:217
        for k=1:181
            if Yp(i,j,k)~=0 && Ys(i,j,k)~=0
                cmp = cmp+1;
                voxels_spm(cmp) = Ys(i,j,k);
                voxels_palm(cmp) = Yp(i,j,k);
            end
        end
    end
end

% Compute the difference and the average
difference = voxels_palm - voxels_spm;
average = (voxels_palm + voxels_spm)/2;

% Bland-Altman plot
figure;
subplot(4,4,[2,3,4,6,7,8,10,11,12]);
X = [average, difference];
hist3(X,'Nbins', [100,100])
set(gca, 'FontSize', 12);
xlabel('Average of t-scores', 'FontSize', 15);
ylabel('Difference of t-scores (PALM-SPM)', 'FontSize', 15);
title('Bland-Altman plot','FontSize', 15);
surfHandle = get(gca, 'child');
set(surfHandle,'FaceColor','interp', 'CdataMode', 'auto');
shading flat
colormap(parula);
c = colorbar('eastoutside');
caxis([0 3500])
set(c,'Position',[.92 .32 .01 .61], 'YTick', 0:500:3500);
view(2)
xlim([min(average) max(average)]);
ylim([-0.4 0.5]);

% Plot the histograms of relative frequencies for the difference
y = difference;
numIntervals = 50;
intervalWidth = (max(y) - min(y))/numIntervals;
x = -1:intervalWidth:1;
ncount = histc(y,x);
relativefreq = ncount/length(y);

subplot(4,4,[1,5,9]);
bar(x-intervalWidth/2, relativefreq,1);
xlim([-0.4 0.5]);
camroll(90);
set(gca, 'FontSize', 12);
A = get(gca,'position');
A(1,3) = A(1,3)/2;
set(gca,'position',A);

% For the average
y = average;
numIntervals = 50;
intervalWidth = (max(y) - min(y))/numIntervals;
x = -10:intervalWidth:12;
ncount = histc(y,x);
relativefreq = ncount/length(y);

subplot(4,4,[14,15,16]);
bar(x-intervalWidth/2, relativefreq,1)
xlim([min(x) max(x)])
set(gca,'YDir','reverse');
set(gca, 'FontSize', 12);
A = get(gca,'position');
A(1,4) = A(1,4)/2;
set(gca,'position',A);