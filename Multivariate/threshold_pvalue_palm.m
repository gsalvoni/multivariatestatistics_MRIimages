%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Take -log10(p-value) of an image for better visualisation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select the image of interest
Pimg = spm_select;
Vimg = spm_vol(Pimg);
Yimg = spm_read_vols(Vimg);
 
val = squeeze(Yimg(:,:,:,1));
% Only consider significant voxels
val(val >= 0.05) = 0;

for i = 1:181
    for j = 1:217
        for k = 1:181
            if val(i,j,k) ~= 0 
                val(i,j,k) = -log10(val(i,j,k));
            end
        end
    end
end

Vnew = Vimg(1);
Vnew.fname = spm_file(Vnew.fname, 'prefix', 'Visual_-log10_');
Vnew.dt(1) = Vimg.dt(1);
Vnew.descrip = 'Threshold at 0.05';
Vnew = spm_create_vol(Vnew);
Vnew = spm_write_vol(Vnew,val);