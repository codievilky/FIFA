function Error_Node=Basic_Method(Node_Alpha,measure,probability,Location,Microphone_Distance,Cita,Size_Grid,scale)
[Number,circulation]=size(measure);
weight=zeros(Number,1);
%获取
for sequence=1:circulation
    estimated_location = GM_Probility_Cutting(Number,measure(:,sequence),probability,Location,Microphone_Distance,Cita,Size_Grid,scale);
    estimated_data=get_sequence(Number,Location,Cita,estimated_location);
    for i=1:Number
        %当测量值不等于有定位结果分析的'真实值'时，实验中认为说明该节点出错
        if measure(i,sequence)~=estimated_data(i)
            weight(i)=weight(i)+1;
        end
    end
end
x=0.03;
proportion=Node_Alpha+rand*x*2-x;
Error_Node=calculate_error_node(Number,weight,proportion);