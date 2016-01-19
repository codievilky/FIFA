%proportion直接给出错误节点的百分比，由权值排列由上到下进行比对
function Error_Node=calculate_error_node(Node_Number,node_weight,proportion)
% proportion=proportion+rand/25-0.02;
[~,Sorted_Sequence]=sort(node_weight,'descend');
Error_Node_Number=round(Node_Number*proportion);
Error_Node=zeros(1,Error_Node_Number);
for i=1:Error_Node_Number
    Error_Node(i)=Sorted_Sequence(i);
end
Error_Node=sort(Error_Node);