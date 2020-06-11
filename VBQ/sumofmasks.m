%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% The script sums the masks of all binarized smoothed, warped and  %
% modulated tissue classes from all the participants.              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select the files or interest
c_one = spm_select;
c_two = spm_select;

% Sum all of them and then normalize
sum_of_maskGM = 0;
sum_of_maskWM = 0;
for i = 1:138
    V1 = spm_vol(c_one(i,:));
    [Y1, ~] = spm_read_vols(V1);
    
    Y1(Y1(:)>0.8) = 1;
    
    V2 = spm_vol(c_two(i,:));
    [Y2, ~] = spm_read_vols(V2);
    
    Y2(Y2(:)>0.8) = 1;
    
    sum_of_maskGM = sum_of_maskGM + Y1;
    sum_of_maskWM = sum_of_maskWM + Y2;
end

sum_of_maskGM = sum_of_maskGM/138;
sum_of_maskWM = sum_of_maskWM/138;

% Creation of the NIFTI image
templ = 'C:\Users\gsalvoni\Documents\Dataset\Snd_mask\weights=mwc\smwc1MQ059_MT.nii';
Vt = spm_vol(templ);
Vnew = Vt(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'SUMMASKGM_');
Vnew.dt(1) = 16;
Vnew = spm_write_vol(Vnew,sum_of_maskGM);

templ2 = 'C:\Users\gsalvoni\Documents\Dataset\Snd_mask\weights=mwc\smwc2MQ059_MT.nii';
Vt = spm_vol(templ2);
Vnew2 = Vt(1);
Vnew2.fname = spm_file(Vnew2.fname, 'prefix', 'SUMMASKWM_');
Vnew2.dt(1) = 16;
Vnew2 = spm_write_vol(Vnew2,sum_of_maskWM);