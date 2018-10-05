function check = check(population)
%返回选定的温度
Data0 = dlmread('dataform20160902.csv');
T = Data0(1,:);  %T为温度范围
V = Data0(2:2:1000,:);  %V为对应温度的电压
j = 0;
chromosome_size = 90;
for i = 1:chromosome_size
    if population(i)==1
        check(j) = T(i);
        j = j+1;
    end
end
