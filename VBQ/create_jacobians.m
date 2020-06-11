%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The script creates Jacobian files using the batch     %
% Util -> Deformation using Dartel Flow Field as inputs.%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

analysisDir = 'C:\Users\gsalvoni\Documents\Dataset\';

% Select the flowfields files
flowfields = spm_select;

job{1}.spm.util.defs.comp{1}.dartel.times = [0 1]; % forward
job{1}.spm.util.defs.comp{1}.dartel.K = 5; % time steps = 32
job{1}.spm.util.defs.comp{1}.dartel.template = {[analysisDir,'c_wc_mwc_u\Template_6.nii']};
job{1}.spm.util.defs.out{1}.savejac.savedir.saveusr = {'C:\Users\gsalvoni\Documents\Dataset\jacobian\Forward_32'};

for ii=1:138
    
    cmp = 1;
    h = '';
    [one two] = fileparts(flowfields(ii,:));
    for i=2:20
        if two(i) == '_'
            break;
        end
        h(cmp) = two(i);
        cmp = cmp+1;
    end
    
    job{1}.spm.util.defs.comp{1}.dartel.flowfield = {['C:\Users\gsalvoni\Documents\Dataset\c_wc_mwc_u\',two,'.nii']};
    job{1}.spm.util.defs.out{1}.savejac(1).ofname = h;
    
    % Initialisation
    spm_jobman('initcfg'); 
    % Running of the job
    spm_jobman('run', job); 
end