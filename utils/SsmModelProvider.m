classdef SsmModelProvider < ModelProvider
% Demo for model provider
%
% Author: Junyuan Hong, 2018-03-06, jyhong836@gmail.com

methods

function MP = SsmModelProvider (options)
	InfoSystem.say('Customized model provider.')
end

function names = getNames (MP)
	names =  {'svm_rbf', % SVM classifier with RBF kernel
	}; 
end

function [preprocessor, classifier, modelParam] = getModelByName ( MP, name, options )
% A method provides real models by name.
% INPUT:
%   name - The name of model.
%   options - The option to be provided to `ModelParamProvider`, see `ModelParamProvider.m` for details.

	% Prepare
	switch name
		case 'svm_rbf'
			modelParam = ModelParam({'C',   power(10, 0:4), ...  % classifier param
									 'm',   [1:2:5]});
	                                 % 'gam', power(10, 0:-2:-4)}); % kernel param
			classifier   = @svm;
			preprocessor = @projection_kernel_pre;
		otherwise
			error(['Unknown model name: ' name]);
	end
end

end

end

% /////////// Some functions /////////////

function [ W, test_err, train_err ] = svm (data)
	% process classifier options.
	if isfield(data, 'options'); options = data.options; else; options = []; end;
	[C] = process_options (options, 'C', 1);

	[ test_err, train_err, W ] = svm_none ( data.X.K, data.Y, data.test_X.K, data.test_Y, ...
		                                   struct('C', C) );
end

function newdata = projection_kernel_pre (data, options)
	% process kernel options
	if ~exist('options', 'var'); options = []; end;
	[m] = process_options (options, 'm', 1000);

	disp('Compute kernel matrix.');
	newdata.X.K = compute_projection_kernel(data.X, [], m);
	newdata.test_X.K = compute_projection_kernel(data.X, data.test_X, m);
	newdata.Y = data.Y;
	newdata.test_Y = data.test_Y;
end

