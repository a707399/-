Data0 = dlmread('dataform20160902.csv');
T = Data0(1,:);  %T为温度范围
V = Data0(2:2:1000,:);  %V为对应温度的电压

population_size = 1;
chromosome_size = 90;
cross_rate = 0.6;
mutate_rate = 0.01;
population = zeros(population_size,90);
num_q = zeros(population_size,1);
choose_V = zeros(500,chromosome_size,population_size);
%初始化种群
%随机生成测量温度点的个数及数值

for i = 1:population_size
    for j = 1:chromosome_size
        population(i,j) = round(rand);
    end
end
%计算每一个个体所包含的温度测量点个数
for i = 1:population_size
    for j = 1:chromosome_size
        if population(i,j) == 1
            num_q(i) = num_q(i)+1;
        end
    end
end
%根据随机的温度测量点进行插值处理
%首先根据随机生成的测量点进行初始化

%初始化温度
for i = 1:population_size
    k = 1;  %赋值辅助变量
    for j = 1:chromosome_size
        if population(i,j)==1
            guess_T(i,k) = T(1,j);
            k = k+1;
        end
    end
end
        

%初始化电压
for i = 1:population_size
    x = 1;  %赋值赋值变量
    for j = 1:500
        for k = 1:chromosome_size
            if population(i,k)==1
                choose_V(j,x,i) = V(j,k);
                x = x+1;
            end
        end
    end
end
%进行插值处理
%vq = interp1(x,v,xq,'spline') x为样本点 v为对应函数 xq为查询点
for i = 1:population_size
    for j = 1:500
        guess_V(i,j) = interp1(guess_T(i,1:num_q(i)),choose_V(j,1:num_q(i),i),T,'spline','extrap');
    end
end

%将插值得到数据与实际数据比较，计算成本
for i = 1:population_size
    C(i) = calculator(num_q(i),V,guess_V(i,:));
end

%选择过程
%按照总成本进行降序排序并更新population
%
%计算前i个个体的总C
All_C = zeros(1,population_size);
for i = 1:population_size
    if i==1
        All_C(i) = All_C(i)+C(i);
    else
        All_C(i) = All_C(i-1)+C(i);
    end
end
%计算第G次迭代平均适应度
G = 1;
All_C_average(G) = All_C(population_size)/population_size;
%更新最优方案成本，对应迭代次数，保留最优方案
if All_C(population_size)<Smallest_C
    Smallest_C = All_C(population_size);
    Smallest_generation = G;
    for j =1:chromosome_size
        Smallest_individual(j) = population(population_size,j);
    end
end
%选择
