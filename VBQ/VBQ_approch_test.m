%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script contains various VBQ analyses conducted. Those not presented %
% here below were performed via the batch interface.                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% VBQ approach not patient specific for the warped parameter map
%
% [ g * (|Di(phi)|ti(phi)s(phi) ] /  [ g * (|Di(phi)|ti(phi)) ]
%

% Select the weights = mwc*
mwc1_files = spm_select;
mwc2_files = spm_select;

analysisDir = 'C:\Users\gsalvoni\Documents\Dataset\';

job.fwhm = [3 3 3];

job.output.outdir = {['C:\Users\gsalvoni\Documents\Dataset\VBQ\1subj_0.5FWHM_young']};
job.tpm = {['C:\Users\gsalvoni\Documents\MATLAB\spm\toolbox\hMRI\etpm\eTPM.nii']};
job.vols_pm = {{[analysisDir,'s_ws\wMQ0687_MT.nii']}};

for m=1:138
    disp(m);
    job.vols_mwc = {{[mwc1_files(m,:)]};{[mwc2_files(m,:)]}};
    hmri_run_proc_smooth(job); 
    %the code of hmri_run_proc_smooth was changed to modify the name of the
    %outputs
end

%% TSPOON 
%
% [ g * (mask_i s(phi)) ] /  [ g * mask_i ]
%

analysisDir = 'C:\Users\gsalvoni\Documents\Dataset\';

job.template = {[analysisDir,'c_wc_mwc_u\Template_6.nii']}; 
job.vox = [NaN NaN NaN];
job.bb = [NaN NaN NaN; NaN NaN NaN];
job.fwhm = [3 3 3];
job.output.outdir = {['C:\Users\gsalvoni\Documents\Dataset\TSPOON']};

% Select the ws* maps
MT_files = spm_select;
for i = 1:138
    job.subjd(i).mp_vols = MT_files(i,:);
end

% Select the mwc* files, previously binarized (see from lines 114 to 140)
c_one = spm_select;
c_two = spm_select;
for i = 1:138
    job.c1(i).img = c_one(i,:);
    job.c2(i).img = c_two(i,:);
end

for nm=1:138
    
        disp(nm);
        
        p = spm_str_manip(job.subjd(28).mp_vols,'h');        
        f = job.subjd(28).mp_vols; % w* MPM image of a young participant
        
        c1 = job.c1(nm).img; 
        c2 = job.c2(nm).img;
        
        % Take the patient number
        cmp = 1;
        h = '';
        [one two] = fileparts(c1);
        for i=5:20
            if two(i) == '_'
                break;
            end
            h(cmp) = two(i);
            cmp = cmp+1;
        end
    

        % p* = (mask*)(ws...{A, R1, R2s, MT})
        q1 = spm_file(f,'prefix','p1_','path',job.output.outdir);
        q2 = spm_file(f,'prefix','p2_','path',job.output.outdir);
        p1= spm_imcalc(strvcat(char(c1),char(f)),q1,'i1.*i2');
        p2= spm_imcalc(strvcat(char(c2),char(f)),q2,'i1.*i2');
        
        % n* = g * (p) 
        n1 = spm_file(p1.fname,'prefix','s','path',job.output.outdir);
        n2 = spm_file(p2.fname,'prefix','s','path',job.output.outdir);
        spm_smooth(p1,n1,job.fwhm);
        spm_smooth(p2,n2,job.fwhm);
        
        % m* = g * mask
        m1 = spm_file(c1,'prefix','s','path',job.output.outdir);
        m2 = spm_file(c2,'prefix','s','path',job.output.outdir);
        spm_smooth(c1,m1,job.fwhm);
        spm_smooth(c2,m2,job.fwhm);

        % TSPOON
        % q* = n* / m* = [g * (mask.ws*)] / [g * mask]
        t1 = spm_file(p1.fname,'prefix',['ts_',h,'_'],'path',job.output.outdir);
        t2 = spm_file(p2.fname,'prefix',['ts_',h,'_'],'path',job.output.outdir);
        q1 = spm_imcalc(strvcat(n1,m1,m1),t1,'(i1./i2).*(i3>0.05)');
        q2 = spm_imcalc(strvcat(n2,m2,m2),t2,'(i1./i2).*(i3>0.05)');
        
        delfiles = strrep({char(p1.fname),char(p2.fname),n1,n2,m1,m2},'.nii,1','.nii');

        for ii=1:numel(delfiles)
            delete(delfiles{ii});
        end
   
end

%% Generate binarized mwc* for the TSPOON analysis

analysisDir = 'C:\Users\gsalvoni\Documents\Dataset\';
job.template = {[analysisDir,'c_wc_mwc_u\Template_6.nii']}; 
job.vox = [NaN NaN NaN];
job.bb = [NaN NaN NaN; NaN NaN NaN];
job.fwhm = [3 3 3];
job.output.outdir = {['C:\Users\gsalvoni\Documents\Dataset\TSPOON\Norm_bin_c']};

% Select the mwc*
c_one = spm_select;
c_two = spm_select;
for i = 1:138
    job.c1(i).img = c_one(i,:);
    job.c2(i).img = c_two(i,:);
    
    c1 = job.c1(i).img;
    c2 = job.c2(i).img;
    
    q1 = spm_file(c1,'path',job.output.outdir);
    q2 = spm_file(c2,'path',job.output.outdir);
    % Apply a 20% threshold according to Lee, A study of diffusion tensor 
    % imaging by tissue-specific, smoothing-compensated voxel-based analysis
    p1= spm_imcalc(c1,q1,'(i1>0.2)');
    p2= spm_imcalc(c2,q2,'(i1>0.2)');
end

%% Create Jacobian and do a VBQ analysis with the Jacobian as weights
%
% |D(phi)| = |D(phi)|t(phi) / t(phi) = mwc* / wc* 
% [ g * (|Di(phi)|s(phi)) ] /  [ g * |Di(phi) ]
%

% Select mwc* files
mwc1_files = spm_select;
mwc2_files = spm_select;
% Select wc* files
wc1_files = spm_select;
wc2_files = spm_select;

analysisDir = 'C:\Users\gsalvoni\Documents\Dataset\';
job.fwhm = [3 3 3];
job.output.outdir = {['C:\Users\gsalvoni\Documents\Dataset\jac_weights']};
job.tpm = {['C:\Users\gsalvoni\Documents\MATLAB\spm\toolbox\hMRI\etpm\eTPM.nii']};
job.vols_pm = {{[analysisDir,'s_ws\wMQ0687_MT.nii']}};

for m=1:138
    
    c1 = mwc1_files(m,:);
    c2 = mwc2_files(m,:);
    d1 = wc1_files(m,:);
    d2 = wc2_files(m,:);
    
    q1 = spm_file(c1,'path',job.output.outdir);
    q2 = spm_file(c2,'path',job.output.outdir);
    p1 = spm_imcalc(strvcat(char(c1),char(d1)),q1,'(i1./i2)');
    p2 = spm_imcalc(strvcat(char(c2),char(d2)),q2,'(i1./i2)');

    disp(m);
    job.vols_mwc = {{q1};{q2}};
    hmri_run_proc_smooth(job);
end
