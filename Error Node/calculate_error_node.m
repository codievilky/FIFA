%通过给出的每个节点的权重与所定义的比例proportion来判断出真正的错误节点
%暂时使用的方法不需要比率proportion，而采用去权值最高的n个节点，n为所提供的错误节点个数
function Calculated_ENode=calculate_error_node(Node_Number,node_weight,proportion)
%之前的proportion方法
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

% %现在的方法，proportion作为错误节点个数
% [~,sort_weight]=sort(node_weight);
% Calculated_ENode=sort_weight(length(sort_weight)-9:end);