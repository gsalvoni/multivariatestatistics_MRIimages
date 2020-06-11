%%%%%%%%%%%%%%%%%%%%%
% Plot some results %
%%%%%%%%%%%%%%%%%%%%%

nb_perm = [50 100 250 500 750 1000 2000];
perc = [15.7489, 15.7489, 15.7489, 16.6046, 17.3647, 17.3647, 17.9678];
perc_th = [4.2231, 3.3201, 4.3627, 3.9739, 4.0918, 4.0828, 4.0633];

figure;
figu_one = plot(nb_perm, perc, '-o');
set(figu_one, 'LineWidth', 1.5);
set(gca, 'FontSize', 12);
xlabel('Number of permutations', 'FontSize', 15);
ylabel('% voxels activated in the GM (w/out threshold)', 'FontSize', 15);
title('Multivariate analysis with PALM (inc. with age)','FontSize', 15);

figure;
figu_one = plot(nb_perm, perc_th, '-o');
set(figu_one, 'LineWidth', 1.5);
set(gca, 'FontSize', 12);
xlabel('Number of permutations', 'FontSize', 15);
ylabel('Percentage of voxels activated (<0.05) in the GM', 'FontSize', 15);
title('Multivariate analysis with PALM (increase with age)','FontSize', 15);

%%

figure;
c = {'50';'100';'250';'500';'750';'1000'};
data1 = [1.039 0.817 1.074 0.978 1.007 1.005];
x = 1:1:6;
bar(x,data1);
for i1=1:numel(data1)
    text(x(i1),data1(i1),num2str(data1(i1),'%0.4f'),'HorizontalAlignment','center', 'VerticalAlignment','bottom');
end
set(gca,'xticklabel',c, 'FontSize', 12);
ylim([0 1.2])
ylabel('Ratio of voxels activated','FontSize', 15);
xlabel('Number of permutations','FontSize', 15);
% title('Voxels activated (<0.05) in x with respect to 2000 permutations', 'FontSize', 15);

%%

figure;
c = {'50';'100';'250';'500';'750';'1000'};
data1 = [0.9807 0.8993 0.9645 0.9889 0.9965 0.9976];
x = 1:1:6;
bar(x,data1);
for i1=1:numel(data1)
    text(x(i1),data1(i1),num2str(data1(i1),'%0.4f'),'HorizontalAlignment','center', 'VerticalAlignment','bottom');
end
set(gca,'xticklabel',c, 'FontSize', 12);
ylim([0 1.1])
ylabel('Dice coefficient','FontSize', 15);
xlabel('Number of permutations','FontSize', 15);
% title('Dice coefficient between x and 2000 permutations', 'FontSize', 15);
