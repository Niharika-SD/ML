clear all
clc
x = (-pi):0.1:(pi); 
size(x)
data = sin(x);
p = 9; 
train_X = zeros(numel(x), p);
for j=1:p
	train_X(:, j) = x.^j;
end
[n,m]= size(train_X);
lambda =[10^-3, 10^-2,10^-1,1,10,100,1000];
a=[0.1,0.5,1,2,10];
v = zeros(5,7) ;
for k=1:5
for s=1:7
    S ='Lambda=';
    disp(S);
    disp(lambda(s));
    S ='a=';
    disp(S);
    disp(a(k));
    train_Y =(data + a(k)*normrnd(0,1,size(x)))';
    W=pinv(lambda(s)*ones(p,p)+train_X'*train_X)*train_X'*train_Y;
    % calculate train accuracy
    train_err=0;
    for i=1:n
        y=train_X(i,:)*W;
        train_err=train_err+0.5*power(y-train_Y(i),2);
    end
    train_err=sqrt(2*train_err/n);
    v(k,s)= train_err;
    S='Error';
    disp(S);
    disp(train_err);
end
end



