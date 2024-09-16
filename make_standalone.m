function make_standalone()

outdir = '../standalone';
gateway = 'spm_standalone.m';
contentsver = '';

%==========================================================================
%-Static listing of SPM toolboxes
%==========================================================================
fid = fopen(fullfile(spm('Dir'),'config','spm_cfg_static_tools.m'),'wt');
fprintf(fid,'function values = spm_cfg_static_tools\n');
fprintf(fid,...
    '%% Static listing of all batch configuration files in the SPM toolbox folder\n');
%-Get the list of toolbox directories
tbxdir = fullfile(spm('Dir'),'toolbox');
d = [tbxdir; cellstr(spm_select('FPList',tbxdir,'dir'))];
ft = {};
%-Look for '*_cfg_*.m' files in these directories
for i=1:numel(d)
    fi = spm_select('List',d{i},'.*_cfg_.*\.m$');
    if ~isempty(fi)
        ft = [ft(:); cellstr(fi)];
    end
end
%-Create code to insert toolbox config
if isempty(ft)
    ftstr = '';
else
    ft = spm_file(ft,'basename');
    ftstr = sprintf('%s ', ft{:});
end
fprintf(fid,'values = {%s};\n', ftstr);
fclose(fid);

%==========================================================================
%-Static listing of batch application initialisation files
%==========================================================================
cfg_util('dumpcfg');

%==========================================================================
%-Duplicate Contents.m in Contents.txt for use in spm('Ver')
%==========================================================================
sts = copyfile(fullfile(spm('Dir'),'Contents.m'),...
    fullfile(spm('Dir'),'Contents.txt'));
if ~sts, warning('Copy of Contents.m failed.'); end
if ~isempty(contentsver)
    % Format: 'xxxx (SPMx) dd-mmm-yyyy'
    f = fileread(fullfile(spm('Dir'),'Contents.txt'));
    f = regexprep(f,'% Version \S+ \S+ \S+',['% Version ' contentsver]);
    fid = fopen(fullfile(spm('Dir'),'Contents.txt'),'w');
    fprintf(fid,'%s',f);
    fclose(fid);
end

%==========================================================================
%-Trim FieldTrip
%==========================================================================
d = fullfile(spm('Dir'),'external','fieldtrip','compat');
d = cellstr(spm_select('FPList',d,'dir'));
for i=1:numel(d)
    f = spm_file(d{i},'basename');
    nrmv = strncmp(f,'matlablt',8);
    if nrmv
        [dummy,I] = sort({f(9:end),version('-release')});
        nrmv = I(1) == 2;
    end
    if ~nrmv
        [sts, msg] = rmdir(d{i},'s');
    end
end

%==========================================================================
%-Compilation
%==========================================================================
% Nopts = {'-p',fullfile(matlabroot,'toolbox','signal')};
% if ~exist(Nopts{2},'dir'), Nopts = {}; end
Ropts = {'-R','-singleCompThread'} ;
% Ropts = {};
if ~ismac && spm_check_version('matlab','8.4') >= 0
    Ropts = [Ropts, {'-R','-softwareopengl'}];
end
mcc('-m', '-C', '-v',...
    '-o',lower(spm('Ver')),...
    '-d',outdir,...
    Ropts{:},...
    '-a',spm('Dir'),...
    gateway);


% gateway_path = which(gateway);
% unclear why, but the command below does not generate a ctf file
% res = compiler.build.standaloneApplication(gateway_path, "AdditionalFiles", spm('Dir'), "OutputDir",outdir, "Verbose",true);

compiler.package.docker(...
    [{fullfile(outdir, 'spm12')}; {fullfile(outdir, 'spm12.ctf')}], ...
    fullfile(outdir, 'requiredMCRProducts.txt'), ...
    "ImageName","cat12",...
    "DockerContext", outdir, ...
    "ExecuteDockerBuild", 'off', ...
    "EntryPoint", 'spm12')
