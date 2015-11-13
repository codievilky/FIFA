function Error_Node=Advanced_Method(circulation,Real_Error_Node,Number,measure,probability,Location,Microphone_Distance,Cita,Size_Grid,scale)
weight=ones(Number,1);
faulty_node=ones(Number,1);
for sequence=1:circulation
    estimated_location = GM_Probility_Cutting(Number,measure(:,sequence),probability,Location,Microphone_Distance,Cita,Size_Grid,scale);
    estimated_data=get_sequence(Number,Location,Cita,estimated_location);
    for i=1:Number
        %������ֵ�������ж�λ���������'��ʵֵ'ʱ��ʵ������Ϊ˵���ýڵ����
        if measure(i,sequence)~=estimated_data(i)
            faulty_node(i)=1;
        end
    end
end
%����ÿ�����Ƴ����Ĵ���ڵ����Դ��λ��
%��ΪԽԶԽ�����׳�������Ȩֵ�;���������
%distance_multi=calculate_dis(Microphone_Center_Location_with_error(i,:),Microphone_Cita_with_error(i,:),estimated_location);
%�����ķ���ʹ�þ�����м�Ȩ
weight=calculate_weight(weight,Location,Cita,estimated_location,faulty_node);
%���ڼ������ڵ��е�proportion����2һֱ���鵽4��Ѱ��Ч����õ�proportion
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