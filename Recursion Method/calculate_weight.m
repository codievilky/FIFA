function node=calculate_weight(main_node,location,cita,elocation,error_node)
Node_Number=length(error_node);
node=zeros(1,Node_Number);
for i=1:Node_Number
    distance_multi=calculate_dis(location(i,:),cita(i,:),elocation);
    if error_node(i)==1
        main_node(i);
        node(i)=main_node(i)+exp(-0.72/(distance_multi+0.068));
    elseif error_node(i)==0
        node(i)=main_node(i)+(1-exp(-0.72/(distance_multi+0.068)));
    end
end