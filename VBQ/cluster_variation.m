%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Show the variation in a ROI between the outputs of 2 or 3 VBQ analyses %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% Load the cluster of interest
cluster_cortical = 'C:\Users\gsalvoni\Desktop\clustermiddle.nii';
Vcc = spm_vol(cluster_cortical);
[Ycc, ~] = spm_read_vols(Vcc);

% Load the information regarding the participants (age is interesting here)
load('C:\Users\gsalvoni\Documents\Dataset\Analysis 20121221T171249_Subjects_VBQ_ALLsubj');

% Compare two or three analyses/data
third = 0;

%% First analysis

% Select the files (138 must normally be selected)
MT1_files = spm_select;

age_participants = zeros(1,138);
mean_cluster = zeros(1,138);
for i=1:138
    Vmt = spm_vol(MT1_files(i,:));
    [Ymt, ~] = spm_read_vols(Vmt);

    Ymt(isnan(Ymt(:))==1) = 0;

    % Get cluster values in the participant images
    val = Ymt.*Ycc;

    % Take the mean value in that cluster
    cmp = 0;
    sum = 0;
    for i1 = 1:121
        for i2 = 1:145
            for i3 = 1:121
                if val(i1,i2,i3) ~= 0 
                    cmp = cmp+1;
                    sum = sum+val(i1,i2,i3);
                end
            end
        end
    end

    % Store in vectors
    mean_cluster(i) = sum/cmp;
    age_participants(i) = Subjects.Age(i,1);
    
end

%% Second analysis

% Select the files
MT2_files = spm_select;

age_participants = zeros(1,138);
mean_cluster_one = zeros(1,138);
for i=1:138
    Vmt = spm_vol(MT2_files(i,:));
    [Ymt, ~] = spm_read_vols(Vmt);

    Ymt(isnan(Ymt(:))==1) = 0;

    % Get cluster values in the participant MT image
    val = Ymt.*Ycc;

    % Take the mean value in that cluster
    cmp = 0;
    sum = 0;
    for i1 = 1:121
        for i2 = 1:145
            for i3 = 1:121
                if val(i1,i2,i3) ~= 0 
                    cmp = cmp+1;
                    sum = sum+val(i1,i2,i3);
                end
            end
        end
    end

    % Store in vectors
    mean_cluster_one(i) = sum/cmp;
    age_participants(i) = Subjects.Age(i,1);
end

%% Third analysis
if third == 1
    % Select the files
    MT3_files = spm_select;

    age_participants = zeros(1,138);
    mean_cluster_two = zeros(1,138);
    for i=1:138
        Vmt = spm_vol(MT3_files(i,:));
        [Ymt, ~] = spm_read_vols(Vmt);

        Ymt(isnan(Ymt(:))==1) = 0;

        % Get cluster values in the participant MT image
        val = Ymt.*Ycc;

        % Take the mean value in that cluster
        cmp = 0;
        sum = 0;
        for i1 = 1:121
            for i2 = 1:145
                for i3 = 1:121
                    if val(i1,i2,i3) ~= 0 
                        cmp = cmp+1;
                        sum = sum+val(i1,i2,i3);
                    end
                end
            end
        end

        % Store in vectors
        mean_cluster_two(i) = sum/cmp;
        age_participants(i) = Subjects.Age(i,1);
    end
end

%% Plot the results

% figure;
subplot(1,2,1);
scatter(age_participants, mean_cluster);
hold on;
scatter(age_participants, mean_cluster_one,'r');
if third == 1
    scatter(age_participants, mean_cluster_two,'g');
end

p = polyfit(age_participants, mean_cluster, 1);
f = polyval(p,age_participants);
plot(age_participants, f, 'b');
p = polyfit(age_participants, mean_cluster_one, 1);
f = polyval(p,age_participants);
plot(age_participants, f, 'r');
if third == 1
    p = polyfit(age_participants, mean_cluster_two, 1);
    f = polyval(p,age_participants);
    plot(age_participants, f, 'g');
end

set(gca, 'FontSize', 12);
xlabel('Age (years)', 'FontSize', 15);
ylabel('WMMT', 'FontSize', 15);
title('ROI in the Body', 'FontSize', 15);
if third == 0
    legend('Normal VBQ analysis', 'Modified VBQ analysis');
elseif third == 1
    legend('Parameter map (ws)', 'Tissue class (wc)', 'Jacobian');
end