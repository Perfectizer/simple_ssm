function [ trM, teM, trY, teY ] = learn_subspace ( datasetName, d, n )
% learn_subspace 
% INPUT:
%	
% OUTPUT:
%	
%	
% Author: Junyuan Hong, 2017-03-16, jyhong836@gmail.com

global DATA_FOLDER
if ischar(datasetName)
	datasetName = fullfile(DATA_FOLDER, datasetName);
	ds = load([datasetName '.mat']);
else
	ds = datasetName;
	clear('datasetName');
end

if isfield(ds, 'training'); trM = learn_ssm_set(ds.training, d, n); else; trM = []; end
if isfield(ds, 'testing');  teM = learn_ssm_set(ds.testing,  d, n); else; teM = []; end
if isfield(ds, 'training_label');  trY = ds.training_label; else; trY = []; end
if isfield(ds, 'testing_label');   teY = ds.testing_label; else; teY = []; end

end

% ////////////////
function M = learn_ssm_set ( S, d, n )
% Learn set of subspace models.

N = length(S);
M = [];
for ii=1:N
	M{ii} = learn_ssm(S{ii}, d, n);
end

end
