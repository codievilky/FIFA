function weight=measure_to_weight(Node_Number,measure,probability,Location,MDistance,Cita,Size_Grid,scale,get_weight)
estimated_location = GM_Probility_Cutting(Node_Number,measure,probability,Location,MDistance,Cita,Size_Grid,scale);
estimated_data=get_sequence(Node_Number,Location,Cita,estimated_location);
faulty_node=zeros(1,Node_Number);
for i=1:Node_Number
    %������ֵ�������ж�λ���������'��ʵֵ'ʱ��ʵ������Ϊ˵���ýڵ����
    if measure(i)~=estimated_data(i)
        faulty_node(i)=1;
    end
end
%����ÿ�����Ƴ����Ĵ���ڵ����Դ��λ��
%��ΪԽԶԽ�����׳�������Ȩֵ�;���������
%distance_multi=calculate_dis(Microphone_Center_Location_with_error(i,:),Microphone_Cita_with_error(i,:),estimated_location);
%�����ķ���ʹ�þ�����м�Ȩ
weight=calculate_weight(get_weight,Location,Cita,estimated_location,faulty_node);