function [ Error_Node ] = HistGet_Method( circulation, weight )
[Number,~] = size(weight);
plot(hist(weight,1:1:circulation));
close all;
n = hist(weight,1:1:circulation);
bound = get_LSMin(n) ;
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
end

