function weight=measure_to_weight(measure,probability,Location,MDistance,Cita,Size_Grid,scale,get_weight)
Number=length(measure);
estimated_location = GM_Probility_Cutting(Number,measure,probability,Location,MDistance,Cita,Size_Grid,scale);
estimated_data=get_sequence(Number,Location,Cita,estimated_location);
faulty_node=zeros(1,Number);
for i=1:Number
    %������ֵ�������ж�λ���������'��ʵֵ'ʱ��ʵ������Ϊ˵���ýڵ����
    if measure(i)~=estimated_data(i)
        faulty_node(i)=1;
    end
end
% figure;
% bar(faulty_node);
% close all;
if faulty_node==zeros(1,Number);
    weight=zeros(1,Number);
else
    %����ÿ�����Ƴ����Ĵ���ڵ����Դ��λ��
    %��ΪԽԶԽ�����׳�������Ȩֵ�;���������
    %distance_multi=calculate_dis(Microphone_Center_Location_with_error(i,:),Microphone_Cita_with_error(i,:),estimated_location);
    %�����ķ���ʹ�þ�����м�Ȩ
    weight=calculate_weight(get_weight,Location,Cita,estimated_location,faulty_node);
end