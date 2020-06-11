%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make an image binary in order to be used in the image_overlap function %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img = spm_select;
Vp = spm_vol(img);
[Yp, ~] = spm_read_vols(Vp);

% Create the binarization
Yp(isnan(Yp(:))==1) = 0;
Yp(Yp~=0) = 1;

val = Yp;

Vnew = Vp(1);

Vnew.fname = spm_file(Vnew.fname, 'prefix', 'binary_');
Vnew.dt(1) = 2;

Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,val);