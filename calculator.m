function C = calculator(num_q,origin_s,guess_s)
%�������㷽���ɱ�
%num_qΪѡȡ������ĸ���  origin_sΪ��ʵ�ĵ�ѹ  guess_sΪ�ɲ�ֵ�õ��ĵ�ѹ
%����ⶨ�ɱ�
C = 0;
M = 500;
Q = 50;
Qn = Q*num_q;
s = zeros(M,90);
tmp = zeros(M,90);
sum_s = zeros(M,1);
sum_c = zeros(M,1);
%�������ɱ�
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
%�������ı궨���ɱ�֮��
for i=1:M
    sum_s(i) = sum(s,2);
end
%�������궨�ɱ�
for i=1:M
    sum_c(i) = sum_s(i) + Qn;
end
%���㷽��ƽ���ɱ�
for i=1:M
    C = C + sum_c(i);
end
C = C/M;
end