%�����������������������Ľڵ�
%may_error_node���г����ܳ���Ľڵ�
%node_location��ÿ���ڵ��λ��
%node_cita��ÿ���ڵ�ĽǶ�
%location��˵���ˣ�Ҳ������Դ��λ��
function error_node=create_error_node_with_probility(may_error_node,node_location,node_cita,location)
%ͨ���ڵ�λ�ú���Դλ����ڵ�Ȩֵ��ͨ�������������Ȩֵ�Ƚ���ȷ������ڵ����
probility=rand(10,1);
temp=eye(10);
for i=1:10
    distance=calculate_dis(node_location(may_error_node(i),:),node_cita(may_error_node(i),:),location);
    if probility(i)>=(1-distance/10)
        temp(i,i)=0;
    end
end
error_node=may_error_node*temp;
end
%����Calculate_dis����λλ�ã����ֻ��д��ߵľ���
%����location���ֻ������꣬cita���ֻ��ĳ���
%localization�Ƕ�λ��λ��
function distance=calculate_dis(location,cita,localization)
distance=abs(tan(cita)*localization(1)+localization(2)-tan(cita)*location(1)-location(2))/sqrt(tan(cita)^2+1);
end