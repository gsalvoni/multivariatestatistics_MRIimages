function palm_multivariate_proc(job)
% ---------------------------------------------------------
% Code to run the batch Multivariate statistics.
% Using the data entered in the batch, it creates the cell array to be used
% as the input in PALM.
% ---------------------------------------------------------
%% Adding path of PALM 
addpath(char(job.outdir));

%% Get some useful numbers 
n_inputs = numel(job.data);
n_contrasts = numel(job.tcon_file);
n_dsg = numel(job.dsgmatrix);
if isfield(job.maskch,'mask')
    n_mask = numel(job.maskch.mask);
    nb_elements = 2*n_inputs + 2*n_mask + 2*n_dsg + 2*n_contrasts + 2;
elseif isfield(job.maskch,'nomask')
    nb_elements = 2*n_inputs + 2*n_dsg + 2*n_contrasts + 2;   
end
input_plmfct = cell(1,nb_elements);

%% Data
for i = 1:n_inputs
    input_plmfct{i*2-1} = '-i';
    input_plmfct{i*2} = char(job.data{i});
end

%% Mask(s)
if isfield(job.maskch,'mask')
    for i = 1:n_mask
        input_plmfct{2*n_inputs + 2*i - 1} = '-m';
        input_plmfct{2*n_inputs + 2*i} = char(job.maskch.mask{i});
    end
end 

%% Design matrix
if isfield(job.maskch,'mask')
    for i = 1:n_dsg
        input_plmfct{2*n_inputs + 2*n_mask + 2*i - 1} = '-d';
        input_plmfct{2*n_inputs + 2*n_mask + 2*i} = char(job.dsgmatrix{i});
    end
else
    for i = 1:n_dsg
        input_plmfct{2*n_inputs + 2*i - 1} = '-d';
        input_plmfct{2*n_inputs + 2*i} = char(job.dsgmatrix{i});
    end
end

%% T-contrasts files
if isfield(job.maskch,'mask')
    for i = 1:n_contrasts
        input_plmfct{2*n_inputs + 2*n_mask + 2*n_dsg + 2*i - 1} = '-t';
        input_plmfct{2*n_inputs + 2*n_mask + 2*n_dsg + 2*i} = char(job.tcon_file{i});
    end
else
    for i = 1:n_contrasts
        input_plmfct{2*n_inputs + 2*n_dsg + 2*i - 1} = '-t';
        input_plmfct{2*n_inputs + 2*n_dsg + 2*i} = char(job.tcon_file{i});
    end
end

%% Number of permutations
if isfield(job.maskch,'mask')
    input_plmfct{2*n_inputs + 2*n_mask + 2*n_dsg + 2*n_contrasts + 1} = '-n';
    input_plmfct{2*n_inputs + 2*n_mask + 2*n_dsg + 2*n_contrasts + 2} = num2str(job.perm);
else
    input_plmfct{2*n_inputs + 2*n_dsg + 2*n_contrasts + 1} = '-n';
    input_plmfct{2*n_inputs + 2*n_dsg + 2*n_contrasts + 2} = num2str(job.perm);
end

%% Type of permutation
if job.tpperm == 2
    input_plmfct{end+1} = '-ise';
elseif job.tpperm == 3
    input_plmfct{end+1} = '-ee';
    input_plmfct{end+1} = '-ise';
end

%% Algorithm 
if job.algo.npc == 0
    if job.algo.mod == 1
        input_plmfct{end+1} = '-corrmod';
    end
    if job.algo.con == 1
        input_plmfct{end+1} = '-corrcon';
    end
elseif job.algo.npc == 1
    input_plmfct{end+1} = '-npcmethod';
    input_plmfct{end+1} = 'Fisher';
    if job.algo.mod == 1
        input_plmfct{end+1} = '-npcmod';
    end
    if job.algo.con == 1
        input_plmfct{end+1} = '-npccon';
    end
end

%% Options
if job.opt.logch == 1
    input_plmfct{end+1} = '-logp';
end
if job.opt.unco == 0
    input_plmfct{end+1} = '-nouncorrected';
end
if isfield(job.opt.acc,'accval')
    input_plmfct{end+1} = '-accel';
    input_plmfct{end+1} = 'tail';
    input_plmfct{end+1} = num2str(job.opt.acc.accval);
end

%% Output name
input_plmfct{end+1} = '-o';
input_plmfct{end+1} = char(job.outname);

%% Launch PALM 
palm_core(input_plmfct{:});

end