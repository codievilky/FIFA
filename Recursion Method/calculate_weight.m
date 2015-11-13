function node=calculate_weight(main_node,location,cita,elocation,error_node)
Node_Number=length(error_node);
node=zeros(1,Node_Number);
for i=1:Node_Number
    distance=calculate_dis(location(i,:),cita(i,:),elocation);
    if distance>14||distance<0
        disp('出错了少年');
    end
    if error_node(i)==1
        node(i)=transfer(0.7,1,14,distance,1);
    elseif error_node(i)==0
        node(i)=transfer(0,0.3,14,distance,-1);
    end
end
sum_weight=sum(node);
for i=1:Node_Number
    node(i)=node(i)/sum_weight;
    node(i)=main_node(i)+node(i);
end
node;
