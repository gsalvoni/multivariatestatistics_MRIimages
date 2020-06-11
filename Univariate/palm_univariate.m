% Path for the PALM toolbox
addpath 'C:\Users\gsalvoni\Documents\MATLAB\PALM_toolbox'

%%
palm -i GMR2s4D.nii -d design.mat -t design_incage.con -m MaskGM4D.nii -n 1000 -o R2s
