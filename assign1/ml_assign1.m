function [lambda_vec, error_train, error_val] = ml_assign1(file) 
data = dlmread(file);
k = data(randperm(size(data,1)),:);
[m,n] = size(k);
ytrain=k(1:floor(0.6*m),1);
ytest=k(ceil(0.6*m):end,1);
xtrain=k(1:floor(0.6*m),2:n);
xtest=k(ceil(0.6*m):end,2:n);
[lambda_vec, error_train, error_val] = MyvalidationCurve(xtrain, ytrain, xtest, ytest);
error_train
error_val
end


