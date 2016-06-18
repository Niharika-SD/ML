n.m

%applying logistic regression function on the breast cancer data.

%load the data and divide into the feature set and the labels

breastcancer = dlmread('breast-cancer.txt')

X=breastcancer(:,2:end);

%normalizing the data

m=mean(X);

s=std(X);

for i=1:size(X,1)

for j=1:size(X,2)

X1(i,j)=(X(i,j)-m(j))./s(j);

end

end

%Change the target as value =0 if label='2' and value =1 if label='4'

t=breastcancer(:,1);

for i=1:size(X,1)

if t(i,1)==2

t(i,1)=0;

else

t(i,1)=1;

end

end

%run both IRLS method and stochastic gradient descent method

w_irls=logistic_training(X1,t,100,0.05,'IRLS');

w_sgd=logistic_training(X1,t,100,0.05,'stochastic');

%finding the accuracy

y_irls=zeros(size(X1,1),1);

for i=1:size(X1,1)

y_irls(i,1)=1./(1+exp(-1*X1(i,:)*w_irls));

if y_irls(i,1)>0.5

y_irls(i,1)=1;

else

y_irls(i,1)=0;

end

end

IRLSacc= 1 -(sum(abs(t-y_irls))/size(X,1))

y_sgd=zeros(size(X1,1),1);

for i=1:size(X1,1)

y_sgd(i,1)=1./(1+exp(-1*X1(i,:)*w_sgd));

if y_sgd(i,1)>0.5

y_sgd(i,1)=1;

else

y_sgd(i,1)=0;

end

end

SGDacc= 1 -(sum(abs(t-y_sgd))/size(X,1))

%function implementing the logistic regression function

%function to train the data using logistic regression - Iterative

%re-weighted least squares method and stochastic gradient descent method

function [w_new]=logistic_training(X,t,maxiterations,epsilon,method)

[rows,columns]=size(X);

W_old=zeros(columns,1);

if strcmp(method,'IRLS')==1

%IRLS method

for k=1:maxiterations

[obJ,R,Y]=matrixR(w_old,X,t);

objectivefunIRLS(k)=obJ;

z=(transpose(X)*R*X*w_old) - (transpose(X)*(Y-t));

w_new=(transpose(X)*R*X)\z;

if(sum(abs(w_new-w_old))<epsilon)

fprintf('converged at %d iteration\n',k);

break;

else

w_old=w_new;

end

end

fprintf('Iterations reached: %d\n',k);

figure, plot(objectivefunIRLS);

elseif strcmp(method,'stochastic')==1

%Stochastic gradient descent method

alpha=0.2;

for k = 1:maxiterations

[J, gradient] = lrCostFunction(wold,X,t);

objectivefunSGD(k)=J;

w_new = w_old - alpha * gradient;

if(sum(abs(w_new-w_old))<epsilon)

fprintf('converged at %d iteration\n',k);

break;

else

w_old=w_new;

end

end

fprintf('Iterations reached: %d\n',k);

figure, plot(objectivefunSGD);

end

end

%function calculating the matrices R and y for IRLS method

function [costJ,R,Y]=matrixR(w_old,X,t)

[n,m]=size(X);

R=zeros(n,n);

Y=zeros(n,1);

y=sigmoid(X*w_old);

costJ = (-1/n) * sum( t .* log(y) + (1-t) .* log(1-y) );

for i=1:n

Y(i)=sigmoid(X(i,:)*w_old);

R(i,i)=Y(i).*(1-Y(i));

end

end

%function calculating the gradient and the cost function in Stochastic

%gradient method

function [costJ, grad] = lrCostFunction(w_old, X, t)

n = size(t,1);

y = sigmoid(X*w_old);

grad=zeros(size(w_old));

costJ = (-1/n) * sum( t .* log(y) + (1-t) .* log(1-y) );

for i=1:n

grad=grad+(y(i)-t(i))*transpose(X(i,:));

end

grad=(1/n)*grad;

end

%function to obtain the sigmoid of an input

function [value]=sigmoid(input)

value=1./(1+exp(-1*input));

end
