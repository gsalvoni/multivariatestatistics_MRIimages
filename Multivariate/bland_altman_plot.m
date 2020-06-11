%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function creates Bland-Altman plot between 2 non-parametric %
% analyses carried out in PALM.                                   %  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bland_altman_plot(mask, lower_mod, higher_mod)
    
    % Find the number of voxels in the mask (exclude the case where both 
    % p-values are equal to 1: better cause otherwise a lot of points)
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
    
    figure;
    % Plot Bland-Altman plot: average vs difference
    subplot(4,7,[2,3,4,9,10,11,16,17,18]);
    h = plot(average,difference,'.');
    set(h,'markersize',4.5,'MarkerEdgeColor',[0/255 5/255 215/255])    
    set(gca, 'FontSize', 12);
    xlabel('Average of p-values', 'FontSize', 15);
    ylabel('Difference of p-values', 'FontSize', 15);
    title('Bland-Altman plot','FontSize', 15);
    ylim([-1 1])
   
    hold on;
    % Insert the mean
    mu = mean(difference);
    plot(min(average):0.001:max(average),mu,'r-');
    % Insert the limits of agreement
    std_diff = std(difference);
    up = mu+1.96*std_diff;
    plot(min(average):0.001:max(average),up,'r-');
    down = mu-1.96*std_diff;
    plot(min(average):0.001:max(average),down,'r-');
    xlim([min(average) max(average)]);
    hold off;

    % Plot the histograms of relative frequencies for the difference
    numIntervals = 50;
    intervalWidth = (max(difference) - min(difference))/numIntervals;
    x = min(difference):intervalWidth:max(difference);
    ncount = histc(difference,x);
    relativefreq = ncount/length(difference);
    
    subplot(4,7,[1,8,15]);
    bar(x-intervalWidth/2, relativefreq,1,'FaceColor',[5/255 30/255 105/255]);
    xlim([-1 1])
    camroll(90);
    set(gca, 'FontSize', 12);
    A = get(gca,'position');
    A(1,3) = A(1,3)/2;
    set(gca,'position',A);

    % Plot the histograms of relative frequencies for the average
    intervalWidth = (max(average) - min(average))/numIntervals;
    x = min(average):intervalWidth:max(average);
    ncount = histc(average,x);
    relativefreq = ncount/length(average);
    
    subplot(4,7,[23,24,25]);
    bar(x-intervalWidth/2, relativefreq,1,'FaceColor',[5/255 30/255 105/255]);
    xlim([min(x) max(x)])
    ylim([0 0.1])
    set(gca,'YDir','reverse');
    set(gca, 'FontSize', 12);
    A = get(gca,'position');
    A(1,4) = A(1,4)/2;
    set(gca,'position',A);
    
    % Plot the Bland-Altman plot showing the density of points
    subplot(4,7,[5,6,7,12,13,14,19,20,21]);
    X = [average, difference];
    hist3(X,'Nbins', [100,100])
    set(gca, 'FontSize', 12);
    surfHandle = get(gca, 'child');
    set(surfHandle,'FaceColor','interp', 'CdataMode', 'auto');
    colormap(pink(200));
    c = colorbar('eastoutside');
    caxis([0 2.5e3])
    set(c,'Position',[.92 .32 .01 .61], 'YTick', 0:500:2500);
    view(2)
    xlim([0 1])
    ylim([-1 1])
    
end