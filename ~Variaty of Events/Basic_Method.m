function Error_Node = Basic_Method(~,weight)
[Number,~] = size(weight);
% x=0.04;
% proportion=Node_Alpha+rand*x*2-x;
% Error_Node=calculate_error_node(Number,weight,proportion);
SortWeight = sort(weight);
sum_weight = 0;
count = 0;
for i = 1:Number
    sum_weight = sum_weight + SortWeight(i);
    if(SortWeight(i) ~= 0)
        count = count + 1;
    end
end
bound = sum_weight / count;
Error_Count = 0;
for i = 1:Number
    if weight(i) >= bound
        Error_Count = Error_Count + 1;
    end
end
Error_Node = zeros(1,Error_Count);
Error_Count = 1;
for i = 1:Number
    if weight(i) >= bound
       Error_Node(Error_Count) = i;
       Error_Count = Error_Count + 1;
    end
end