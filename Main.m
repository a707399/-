Data0 = dlmread('dataform20160902.csv');
T = Data0(1,:);  %TΪ�¶ȷ�Χ
V = Data0(2:2:1000,:);  %VΪ��Ӧ�¶ȵĵ�ѹ

population_size = 1;
chromosome_size = 90;
cross_rate = 0.6;
mutate_rate = 0.01;
population = zeros(population_size,90);
num_q = zeros(population_size,1);
choose_V = zeros(500,chromosome_size,population_size);
%��ʼ����Ⱥ
%������ɲ����¶ȵ�ĸ�������ֵ

for i = 1:population_size
    for j = 1:chromosome_size
        population(i,j) = round(rand);
    end
end
%����ÿһ���������������¶Ȳ��������
for i = 1:population_size
    for j = 1:chromosome_size
        if population(i,j) == 1
            num_q(i) = num_q(i)+1;
        end
    end
end
%����������¶Ȳ�������в�ֵ����
%���ȸ���������ɵĲ�������г�ʼ��

%��ʼ���¶�
for i = 1:population_size
    k = 1;  %��ֵ��������
    for j = 1:chromosome_size
        if population(i,j)==1
            guess_T(i,k) = T(1,j);
            k = k+1;
        end
    end
end
        

%��ʼ����ѹ
for i = 1:population_size
    x = 1;  %��ֵ��ֵ����
    for j = 1:500
        for k = 1:chromosome_size
            if population(i,k)==1
                choose_V(j,x,i) = V(j,k);
                x = x+1;
            end
        end
    end
end
%���в�ֵ����
%vq = interp1(x,v,xq,'spline') xΪ������ vΪ��Ӧ���� xqΪ��ѯ��
for i = 1:population_size
    for j = 1:500
        guess_V(i,j) = interp1(guess_T(i,1:num_q(i)),choose_V(j,1:num_q(i),i),T,'spline','extrap');
    end
end

%����ֵ�õ�������ʵ�����ݱȽϣ�����ɱ�
for i = 1:population_size
    C(i) = calculator(num_q(i),V,guess_V(i,:));
end

%ѡ�����
%�����ܳɱ����н������򲢸���population
%
%����ǰi���������C
All_C = zeros(1,population_size);
for i = 1:population_size
    if i==1
        All_C(i) = All_C(i)+C(i);
    else
        All_C(i) = All_C(i-1)+C(i);
    end
end
%�����G�ε���ƽ����Ӧ��
G = 1;
All_C_average(G) = All_C(population_size)/population_size;
%�������ŷ����ɱ�����Ӧ�����������������ŷ���
if All_C(population_size)<Smallest_C
    Smallest_C = All_C(population_size);
    Smallest_generation = G;
    for j =1:chromosome_size
        Smallest_individual(j) = population(population_size,j);
    end
end
%ѡ��
