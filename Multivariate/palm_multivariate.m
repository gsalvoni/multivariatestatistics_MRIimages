% Path for the PALM toolbox
addpath 'C:\Users\gsalvoni\Documents\MATLAB\PALM_toolbox'

%% GRAY MATTER

% palm -i GMR2s4D.nii -i GMMT4D.nii -i GMR14D.nii -i GMA4D.nii -d design.mat -t design_multi.con -m MaskGM4D.nii -accel tail 0.05 -n 5 -npc -npccon -nouncorrected -o GM

%% WHITE MATTER

% palm -i WMR2s4D.nii -i WMMT4D.nii -i WMR14D.nii -i WMA4D.nii -d design.mat -t design_multi.con -m MaskWM4D.nii -accel tail 0.05 -n 250 -npc -npccon -nouncorrected -o WM
