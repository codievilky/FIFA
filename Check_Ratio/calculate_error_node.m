%ͨ��������ÿ���ڵ��Ȩ����������ı���proportion���жϳ������Ĵ���ڵ�
%��ʱʹ�õķ�������Ҫ����proportion��������ȥȨֵ��ߵ�n���ڵ㣬nΪ���ṩ�Ĵ���ڵ����
function Calculated_ENode=calculate_error_node(Node_Number,node_weight,proportion)
%֮ǰ��proportion����
sum=0;
for i=1:Node_Number
    sum=sum+node_weight(i);
end
average=sum/length(node_weight);
Calculated_ENode=[];
for i=1:Node_Number
    if node_weight(i)>=average*proportion
        Calculated_ENode=[Calculated_ENode i];
    end
end

% %���ڵķ�����proportion��Ϊ����ڵ����
% [~,sort_weight]=sort(node_weight);
% Calculated_ENode=sort_weight(length(sort_weight)-9:end);