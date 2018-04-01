classdef SsmDataProvider < DataProvider
% Demo for data provider
%
% Author: Junyuan Hong, 2018-03-06, jyhong836@gmail.com

methods
function obj = SsmDataProvider (options)
	% obj@DataProvider(varargin{:});
end
end

methods (Access = protected)

function names = getNames (obj)
	names = {'KARD1_exp1_cv1'};
end

function loaded = load_from_file (DP, dataname)
% Load from file and return data in struct 'loaded'.
%	You can customize the function to adapt your file format.

	updateCache = 0; % -2;
	d = 2;
	m = 10;
	cachefile = cache_ssm ( dataname, d, m, updateCache );
	loaded = load(cachefile);
end

function [X, test_X, Y, test_Y] = process_data (DP, ds, options)
% You can customize the function to adapt your data format.
%	For example, you can slice the data dimension.

	X      = ds.X;
	test_X = ds.test_X;
	Y      = ds.Y;
	test_Y = ds.test_Y;
end

end

end
