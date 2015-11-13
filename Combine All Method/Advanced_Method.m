function Error_Node=Advanced_Method(circulation,Real_Error_Node,Number,measure,probability,Location,Microphone_Distance,Cita,Size_Grid,scale)
weight=ones(Number,1);
faulty_node=ones(Number,1);
for sequence=1:circulation
    estimated_location = GM_Probility_Cutting(Number,measure(:,sequence),probability,Location,Microphone_Distance,Cita,Size_Grid,scale);
    estimated_data=get_sequence(Number,Location,Cita,estimated_location);
    for i=1:Number
        %当测量值不等于有定位结果分析的'真实值'时，实验中认为说明该节点出错
        if measure(i,sequence)~=estimated_data(i)
            faulty_node(i)=1;
        end
    end
end
%计算每个估计出来的错误节点和声源的位置
%因为越远越不容易出错，所以权值和距离成正相关
%distance_multi=calculate_dis(Microphone_Center_Location_with_error(i,:),Microphone_Cita_with_error(i,:),estimated_location);
%提升的方法使用距离进行加权
weight=calculate_weight(weight,Location,Cita,estimated_location,faulty_node);
%对于计算错误节点中的proportion，从2一直试验到4，寻找效果最好的proportion
miniest=9999;
proportion=2;
for i=1:0.1:4
    c_enode=calculate_error_node(Number,weight,i);
    likeness=False_Positive_Rate(Real_Error_Node,c_enode)+False_Negative_Rate(Real_Error_Node,c_enode);
    if likeness<miniest
        miniest=likeness;
        proportion=i;
    end
end
Error_Node=calculate_error_node(Number,weight,proportion);