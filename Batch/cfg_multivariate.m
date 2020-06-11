function multivariate = cfg_multivariate
%% PALM path
palmdir         = cfg_files;
palmdir.tag     = 'outdir';
palmdir.name    = 'PALM directory';
palmdir.help    = {
    'Select the directory where the Permutation Analysis of Linear Models (PALM) toolbox is located.'
    'The path to this folder will be added so as to use the toolbox.'
    }';
palmdir.filter = 'dir';
palmdir.ufilter = '.*';
palmdir.num     = [1 1];

%% Modalities
input          = cfg_files;
input.tag      = 'data';
input.name     = 'Data';
input.help     = {
    'Select the data to be permuted.'
    'Note that 4D images must be chosen, each of the same size.'
    }';
input.ufilter  = '.*';
input.num      = [1 Inf];

%% Mask
% -----------
% Mask choice
% -----------
maskn         = cfg_menu;
maskn.tag     = 'nomask';
maskn.name    = 'No mask';
maskn.help    = {
    'In this case, a mask will not be inserted in the analysis.'
    }';
maskn.labels  = {'No'};
maskn.values  = {1};
maskn.val     = {1};

% --------------
% Mask(s) selection
% --------------
maskinput           = cfg_files;
maskinput.tag       = 'mask';
maskinput.name      = 'Mask file';
maskinput.help      = {
    'Select the 4D mask(s) associated to your data.'
    'Either one mask for all inputs or one mask per input.'
    ['If several masks are selected, the same order as the inputs selection ',...
    'must be respected.']
    }';
maskinput.ufilter   = '.*';
maskinput.num       = [1 Inf];

% ------------
% Use of mask?
% ------------
maskchoice         = cfg_choice;
maskchoice.tag     = 'maskch';
maskchoice.name    = 'Mask';
maskchoice.help    = {
    'Possibility to choose a mask associated with the data previously selected.'
    ['If masks are to be selected, two cases are possible: either use ',...
    'one mask for all inputs or one mask per input. In the latter case, be careful to ',...
    'supply the masks in the same order as the inputs were.']
    }';
maskchoice.values  = {maskn maskinput };
maskchoice.val     = {maskinput};


%% Design matrix
dsgmat         = cfg_files;
dsgmat.tag     = 'dsgmatrix';
dsgmat.name    = 'Design matrix';
dsgmat.help    = {
    'Insert the design matrix. Several design matrices can be selected.'
    'The format must be csv or the vest format from fsl.'
    ['Refer to https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/GLM/CreatingDesignMatricesByHand ',...
    'for creating a design matrix compatible with PALM.']
    }';
dsgmat.ufilter = '.mat';
dsgmat.num       = [1 Inf];

%% T-contrasts
tcon         = cfg_files;
tcon.tag     = 'tcon_file';
tcon.name    = 'T-contrast file';
tcon.help    = {
    'Select the t-contrasts files, in csv or vest format.'
    'The number of t-files must be 1 or equal to the number of design matrices selected.'
    'More than one contrast can be inserted in a single t-contrast file.'
    ['Refer to https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/GLM/CreatingDesignMatricesByHand ',...
    'for creating t-contrasts files compatible with PALM.']
    }';
tcon.ufilter = '.con';
tcon.num       = [1 Inf];

%% Number of permutations
perm         = cfg_entry;
perm.tag     = 'perm';
perm.name    = 'Number of permutations';
perm.val     = {1000};
perm.strtype = 'e';
perm.help    = {
    'Specify the total number of permutations to perform on your data.'
    }';

%% EE and/or ISE ?

tpperm        = cfg_menu;
tpperm.tag    = 'tpperm';
tpperm.name   = 'Assumptions';
tpperm.help   = {
    'Choose the assumption on the errors and consequently the type of shufflings.'
    'EE: assume exchangeable errors. In this case, only permutations will be carried out.'
    ['ISE: assume independent and symmetric errors. In this case, only sign',...
    ' flippings will be performed.']
    ['Both: assume exchangeable, and independent and symmetric errors.',...
    ' Permutations and sign-flippings will be done.']
    };
tpperm.labels = {'EE' 'ISE' 'Both'};
tpperm.values = {1 2 3};
tpperm.val    = {1};

%% Algorithm

% --------------------------
% Correction over contrasts
% --------------------------
con        = cfg_menu;
con.tag    = 'con';
con.name   = 'Correction over contrasts';
con.help   = {
    'Select Yes to apply a correction over contrasts.'
    'Select No otherwise.'
    };
con.labels = {'Yes' 'No'};
con.values = {1 0};
con.val    = {1};

% --------------------------
% Correction over modalities
% --------------------------
mod        = cfg_menu;
mod.tag    = 'mod';
mod.name   = 'Correction over modalities';
mod.help   = {
    'Select Yes to apply a correction over modalities.'
    'Select No otherwise.'
    };
mod.labels = {'Yes' 'No'};
mod.values = {1 0};
mod.val    = {1};

% ---
% NPC
% ---
npc        = cfg_menu;
npc.tag    = 'npc';
npc.name   = 'NPC';
npc.help   = {
    'Select Yes to run the NPC algorithm.'
    'Select No to run simple permutations.'
    };
npc.labels = {'Yes' 'No'};
npc.values = {1 0};
npc.val    = {1};

% ------------------------
% Options of the algorithm
% ------------------------
algo         = cfg_branch;
algo.tag     = 'algo';
algo.name    = 'Algorithm';
algo.val     = {npc mod con};
algo.help    = {
    ['Specify the type of algorithm to run. Two cases are possible: either ',...
    'do a modified Non-Parametric Combination (NPC) or simple rearrangements.',...
    ' The NPC should be preferred in the case of multiple inputs.']
    ' '
    ['Once the algorithm is selected, specify if a correction over modalities and ',...
    'a correction over contrasts is desired. It applies FWER-correction of p-values ',...
    'over multiple modalities/inputs and multiple contrasts respectively.']
    ['Such cases must only be considered if several inputs and/or contrasts (within one ',...
    'single t-contrast file or with more than one t-contrast file) have been selected.']
    }';

%% Option
% -------------------
% Acceleration method
% -------------------

% Value of the tail
accval         = cfg_entry;
accval.tag     = 'accval';
accval.name    = 'Tail value';
accval.val     = {0.1};
accval.strtype = 'e';
accval.help    = {
    ['Specify the value of the tail. It corresponds to the p-value below ',...
    'which the fit is to be used.']
    }';
% Choose if apply the method
accmth        = cfg_menu;
accmth.tag    = 'accmth';
accmth.name   = 'No tail';
accmth.help   = {
    'In this case, any acceleration method will be used in the process.'
    };
accmth.labels = {'No'};
accmth.values = {0};
accmth.val    = {0};

% Acceleration branch
acc         = cfg_choice;
acc.tag     = 'acc';
acc.name    = 'Acceleration methods';
acc.values  = {accmth accval};
acc.val     = {accmth};
acc.help    = {
    'Choose whether to apply a tail approximation at your non-parametric analysis.'
    'Select Tail value to use a tail approximation.'
    'Select No tail otherwise.'
    }';


% --------------------
% Uncorrected p-values
% --------------------
unco        = cfg_menu;
unco.tag    = 'unco';
unco.name   = 'Uncorrected';
unco.help   = {
    'Select Yes to produce uncorrected p-values as well.'
    'Select No to generate only corrected p-values.'
    };
unco.labels = {'Yes' 'No'};
unco.values = {1 0};
unco.val    = {0};

% -----
% Log p
% -----
logchoice        = cfg_menu;
logchoice.tag    = 'logch';
logchoice.name   = 'Save as -log10(p)';
logchoice.help   = {
    'Select Yes to save the output values as -log10(p).'
    'Select No otherwise.'
    };
logchoice.labels = {'Yes' 'No'};
logchoice.values = {1 0};
logchoice.val    = {0};

% -------
% Options
% -------
options         = cfg_branch;
options.tag     = 'opt';
options.name    = 'Options';
options.val     = {acc unco logchoice};
options.help    = {
    'Various useful options can be considered.'
    ['Acceleration methods: possibility to use a tail approximation. It is a ',...
    'modelling of the tail of the statistic distribution by fitting a generalised ',...
    'pareto distribution (GPD). It is likely to allow a reduction of the processing time ',...
    'when using big data.']
    ''
    ['Uncorrected: decide whether to generate outputs containing the uncorrected ',...
    'p-values. With cumbersome data, a significant amount of computation time ',...
    'can be saved.']
    ''
    ['Save as -log10(p): choose if the output p-values are saved in terms of ',...
    'p-values or in terms of -log10(p). The latter has visual advantages.']
    }';

%% Output name

outname         = cfg_entry;
outname.tag     = 'outname';
outname.name    = 'Output prefix name';
outname.val     = {''};
outname.strtype = 's';
outname.help    = {
    'Specify the prefix name of the outputs generated by PALM.'
    'All outputs will be in the form: prefix_*'
    }';
outname.num     = [0 Inf];
outname.hidden  = false;

%% Multivariate
multivariate        = cfg_exbranch;
multivariate.tag    = 'multi';
multivariate.name   = 'Multivariate statistics';
multivariate.val    = {palmdir input maskchoice dsgmat tcon perm tpperm algo options outname};
multivariate.help   = {
    'Applying permutation tests using PALM toolbox.'
    }';
multivariate.check  = @check_multi_batch;
multivariate.prog   = @palm_multivariate_proc;

end

function out = check_multi_batch(job)

out = '';

if isfield(job.maskch,'mask')
    n_inputs = numel(job.data);
    n_mask = numel(job.maskch.mask);

    if n_mask > 1
       if n_mask ~= n_inputs
          out = [out 'Incompatible number of masks and of inputs.'];
       end
    end
end

end