function [ cachefile ] = cache_ssm ( datasetName, d, n, updateCache )
% CACHE_SSM Cache learned subspace models.
% INPUT:
%	updateCache - [false] Force updating cache.
% OUTPUT:
%	
%	
% Author: Junyuan Hong, 2017-03-16, jyhong836@gmail.com

if ~exist('updateCache', 'var') || isempty(updateCache)
	updateCache = 0;
end

[cachefile, foundCache] = check_cache(datasetName, d, n);

doCache = ~foundCache;

if updateCache<=-2
	disp('[CSSM] Force updating ssm cache.');
	doCache = true;
end

if doCache
	disp('Caching subspaces...');
	[ X, test_X, Y, test_Y ] = learn_subspace ( datasetName, d, n );

	descrip.d    = d;
	descrip.n    = n;
	descrip.date = datetime('now');
	descrip.arch = computer('arch');

	save(cachefile, 'X', 'Y', 'test_X', 'test_Y', 'descrip');
	disp(['Saved to ' cachefile]);
end

end

function [cachefile, foundCache] = check_cache(datasetName, d, n)
% Check if cache file exist and its datas.
	global CACHE_DIR
	foundCache = false;

	cachefile = fullfile(CACHE_DIR, [datasetName '-cache' '_n' num2str(n) '_d' num2str(d) '.mat']);
	if exist(cachefile, 'file')
		disp(['[CSSM] Found cachefile: ' cachefile]);
		foundCache = true;
	else
	end
end
