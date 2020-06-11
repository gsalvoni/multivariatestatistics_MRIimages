%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script sums the masks of all binarized warped and  %
% modulated tissue classes from all the participants.    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

analysisDir = 'C:\Users\gsalvoni\Documents\Dataset\';

job.template = {[analysisDir,'c_wc_mwc_u\Template_6.nii']}; 
job.vox = [NaN NaN NaN];
job.bb = [NaN NaN NaN; NaN NaN NaN];
job.fwhm = [3 3 3];
job.output.outdir = {['C:\Users\gsalvoni\Documents\Dataset\effects_around_ventricles']};

%% Generate the sum of the masked mwc*

% Select the mwc* files
c_one = spm_select;
c_two = spm_select;

sum_of_allGM = 0;
sum_of_allWM = 0;
for i = 1:138
    disp(i);
    
    job.c1(i).img = c_one(i,:); % mwc*
    job.c2(i).img = c_two(i,:);
    
    c1 = job.c1(i).img;
    c2 = job.c2(i).img;
    
    % Binarization with a very low threshold
    q1 = spm_file(c1,'path',job.output.outdir);
    q2 = spm_file(c2,'path',job.output.outdir);
    p1 = spm_imcalc(c1,q1,'(i1>0.01)');
    p2 = spm_imcalc(c2,q2,'(i1>0.01)');

    V1 = spm_vol(p1.fname);
    [Y1, ~] = spm_read_vols(V1);

    V2 = spm_vol(p2.fname);
    [Y2, ~] = spm_read_vols(V2);
    
    sum_of_allGM = sum_of_allGM + Y1;
    sum_of_allWM = sum_of_allWM + Y2;
end

templ = 'C:\Users\gsalvoni\Documents\Dataset\c_wc_mwc_u\mwc1MQ0882_MT.nii';
Vt = spm_vol(templ);
Vnew = Vt(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'SUMMASKGM_');
Vnew.dt(1) = 16;
Vnew = spm_write_vol(Vnew,sum_of_allGM);

templ2 = 'C:\Users\gsalvoni\Documents\Dataset\c_wc_mwc_u\mwc2MQ0882_MT.nii';
Vt = spm_vol(templ2);
Vnew2 = Vt(1);
Vnew2.fname = spm_file(Vnew2.fname, 'prefix', 'SUMMASKWM_');
Vnew2.dt(1) = 16;
Vnew2 = spm_write_vol(Vnew2,sum_of_allWM);

