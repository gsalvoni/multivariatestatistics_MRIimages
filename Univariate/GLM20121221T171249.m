clear jobs

analysisDir = 'C:\Users\gsalvoni\Documents\Dataset\';
load('C:\Users\gsalvoni\Documents\Dataset\Analysis 20121221T171249_Subjects_modified');

MPM = 'WMMT'; 
maskFolder = 'Mask\';
mask = 'WinnerTakesAllMask_WM.nii,1';

%%

jobs{1}.spm.stats.factorial_design.dir = {[analysisDir maskFolder MPM 'test_VBQ']};
jobs{1}.spm.stats.factorial_design.des.mreg.scans = eval(['Subjects.',MPM]);
jobs{1}.spm.stats.factorial_design.des.mreg.mcov = struct('c', {}, 'cname', {}, 'iCC', {});

jobs{1}.spm.stats.factorial_design.des.mreg.mcov(1).c = Subjects.Age;
jobs{1}.spm.stats.factorial_design.des.mreg.mcov(1).cname = 'Age';
jobs{1}.spm.stats.factorial_design.des.mreg.mcov(1).iCC = 1;

jobs{1}.spm.stats.factorial_design.des.mreg.mcov(2).c = double(Subjects.Gender);

jobs{1}.spm.stats.factorial_design.des.mreg.mcov(2).cname = 'Gender';
jobs{1}.spm.stats.factorial_design.des.mreg.mcov(2).iCC = 1;

jobs{1}.spm.stats.factorial_design.des.mreg.mcov(3).c = cell2mat(Subjects.TIV)';
jobs{1}.spm.stats.factorial_design.des.mreg.mcov(3).cname = 'TIV';
jobs{1}.spm.stats.factorial_design.des.mreg.mcov(3).iCC = 1;

jobs{1}.spm.stats.factorial_design.des.mreg.mcov(4).c = Subjects.Trio;
jobs{1}.spm.stats.factorial_design.des.mreg.mcov(4).cname = 'TRIO?';
jobs{1}.spm.stats.factorial_design.des.mreg.mcov(4).iCC = 1;

jobs{1}.spm.stats.factorial_design.des.mreg.incint = 1;

jobs{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
jobs{1}.spm.stats.factorial_design.masking.im = 1;
jobs{1}.spm.stats.factorial_design.masking.em = {[analysisDir mask]};

jobs{1}.spm.stats.factorial_design.globalc.g_omit = 1;
jobs{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
jobs{1}.spm.stats.factorial_design.globalm.glonorm = 1;

spm_jobman('initcfg'); % initialisation
spm_jobman('interactive', jobs);

%%
clear jobs
jobs{1}.spm.stats.fmri_est.spmmat = {[analysisDir maskFolder MPM 'test_VBQ\SPM.mat']};
jobs{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('initcfg'); % initialisation
spm_jobman('run', jobs); % actual running of the job
