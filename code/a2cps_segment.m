% Batch file of CAT12 segmentation for SPM12 standalone installation
%
%_______________________________________________________________________
% $Id: a2cps_segment.m 1842 2021-06-01 14:41:58Z gaser $

% first undefined data field, that will be dynamically replaced by cat_standalone.sh
matlabbatch{1}.spm.tools.cat.estwrite.data = '<UNDEFINED>';
matlabbatch{1}.spm.tools.cat.estwrite.nproc = '<UNDEFINED>';;
