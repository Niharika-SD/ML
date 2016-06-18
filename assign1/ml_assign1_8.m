clear all
clc
X=5+sqrt(2).*randn(1000,1);
M=zeros(100,1);
V=zeros(100,1);
for i=1:100
    data=datasample(X,10);
    M(i)=mean(data);
    V(i)=var(data);
end
S='Bias of the Mean =';
b_o_M=mean(M)-5;
disp(S);
disp(b_o_M);
S='Bias of the Variance =';
b_o_V=mean(V)-2;
disp(S);
disp(b_o_V);
S='Variance of the Mean =';
V_o_M=var(M);
disp(S);
disp(V_o_M);
S='Variance of the Variance =';
V_o_V=var(V);
disp(S);
disp(V_o_V);