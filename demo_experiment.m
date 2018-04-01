% @Author: Junyuan Hong
% @Date:   2018-04-01
% @Last Modified by:   Junyuan Hong
% @Last Modified time: 2018-04-01

options = [];

% EM = ExperimentManager ( datasetName, options ); % Use default model provider
EM = ExperimentManager ( SsmDataProvider(options), SsmModelProvider() ); % Use customized model provider.
EM.setupExperiments();
EM.run(); % Run all required methods.
results = EM.outputResults();
