function check = check(population)
%����ѡ�����¶�
Data0 = dlmread('dataform20160902.csv');
T = Data0(1,:);  %TΪ�¶ȷ�Χ
V = Data0(2:2:1000,:);  %VΪ��Ӧ�¶ȵĵ�ѹ
j = 0;
chromosome_size = 90;
for i = 1:chromosome_size
    if population(i)==1
        check(j) = T(i);
        j = j+1;
    end
end
