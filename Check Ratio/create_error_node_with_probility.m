%这个函数输出的是真正会出错的节点
%may_error_node是列出可能出错的节点
%node_location是每个节点的位置
%node_cita是每个节点的角度
%location是说话人，也就是声源的位置
function error_node=create_error_node_with_probility(may_error_node,node_location,node_cita,location)
%通过节点位置和声源位置求节点权值，通过生成随机数和权值比较来确定错误节点与否
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
%函数Calculate_dis是求定位位置，到手机中垂线的距离
%其中location是手机的坐标，cita是手机的朝向
%localization是定位的位置
function distance=calculate_dis(location,cita,localization)
distance=abs(tan(cita)*localization(1)+localization(2)-tan(cita)*location(1)-location(2))/sqrt(tan(cita)^2+1);
end