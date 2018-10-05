function C = calculator(num_q,origin_s,guess_s)
%用来计算方案成本
%num_q为选取测量点的个数  origin_s为真实的电压  guess_s为由插值得到的电压
%计算测定成本
C = 0;
M = 500;
Q = 50;
Qn = Q*num_q;
s = zeros(M,90);
tmp = zeros(M,90);
sum_s = zeros(M,1);
sum_c = zeros(M,1);
%计算误差成本
for i=1:M
    for j=1:90
        tmp(i,j)=abs(origin_s(i,j)-guess_s(i,j));
        if tmp(i,j)<=0.5
            s(i,j)=0;
        elseif tmp(i,j)>0.5&&tmp(i,j)<=1
            s(i,j)=1;
        elseif tmp(i,j)>1&&tmp(i,j)<=1.5
            s(i,j)=5;
        elseif tmp(i,j)>1.5&&tmp(i,j)<=2
            s(i,j)=10;
        else s(i,j)=10000;
        end
    end
end
%计算个体的标定误差成本之和
for i=1:M
    sum_s(i) = sum(s,2);
end
%计算个体标定成本
for i=1:M
    sum_c(i) = sum_s(i) + Qn;
end
%计算方案平均成本
for i=1:M
    C = C + sum_c(i);
end
C = C/M;
end