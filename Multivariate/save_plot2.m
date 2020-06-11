%%%%%%%%%%%%%%%%%%%%%
% Plot some results %
%%%%%%%%%%%%%%%%%%%%%

nb_mod = [1 2 3 4];
perc = [4.8864 5.6227 3.6209 4.2810];

figure;
figu_one = plot(nb_mod, perc, '-o');
set(figu_one, 'LineWidth', 1.5);
set(gca, 'FontSize', 12);
xlabel('Number of modalities', 'FontSize', 15);
ylabel('% voxels activated in the GM (<0.05)', 'FontSize', 15);
title('Percentage of activation for different nb of modalities','FontSize', 15);

%%
nb_mod = [1 2 3 4];
php = [75.65 77.45 73.69 73.75];

figure;
figu_one = plot(nb_mod, php, '-o');
set(figu_one, 'LineWidth', 1.5);
set(gca, 'FontSize', 12);
xlabel('Number of modalities', 'FontSize', 15);
ylabel('Percentage', 'FontSize', 15);
title('Post-Hoc Power','FontSize', 15);
