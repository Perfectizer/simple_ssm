% demo
if ~exist('hasInited', 'var') || hasInited == false
    init;
end

% TODO set your data set name here without '.mat'.
datasetName = 'KARD1_exp1_cv1';

% train subspace models.
updateCache = 0; % -2;
d = 2;
m = 10;
cachefile = cache_ssm ( datasetName, d, m, updateCache );

load(cachefile);

disp('Compute kernel matrix.');
trK = compute_projection_kernel(X, [], m);
teK = compute_projection_kernel(X, test_X, m);

% Run svm.
[ test_err, train_err, W ] = svm_none ( trK, Y, teK, test_Y, struct('C', 100) );

disp(['Test error: ' num2str(test_err)]);
disp(['Train error: ' num2str(train_err)]);
