function model = learn_ssm ( Y, d, n )
% Learn one subspace model.
%
Y = double(Y);

m   = size(Y,1);
t   = size(Y,2);

% Subtract Mean from Observations
Ymean = mean(Y,2);
Y = bsxfun(@minus, Y, Ymean);

if d == 1
	D = Y;
else
	% Build HanKel Matrix
	tau = t - d+1;
	D = zeros(d*m, tau);

	for i = 1:d
        D((i-1)*m + 1:i*m,:) = Y(:,(0:tau-1) + i);
	end
end

% assert(size(D,2) >= size(D,1), 'Length of time should be larger than dimension.');
if size(D, 2) < n
	D = repmat(D, 1, ceil(n/size(D,2)));
end

[U,S,~] = svd(D,0);
model.U  = U(:,1:n);
model.Ymean = Ymean;
model.s = diag(S(1:n, 1:n));
model.s = model.s./min(model.s);

end
