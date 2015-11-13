function Error_Node=Recursion_Method(circulation,Number,measure,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale)
Error_Node=[];
weight=zeros(1,Number); 
%通过测量数据求得三次的权值
for sequence=1:circulation
    weight=measure_to_weight(Number,measure(:,sequence),probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale,weight);
end
[~,sequence]=sort(weight,'descend');
while all(numel(Error_Node)~=10)
%     figure(1);
%     bar(weight);
    %将最高值认为是错误节点
    error_node=sequence(1);
    Error_Node=[Error_Node error_node(1)];
    %删除错误节点的所有数据
    measure(error_node(1),:)=~measure(error_node(1),:);
    %改进方法权值
    weight=zeros(1,Number);
    %通过测量数据求得三次的权值
    for sequence=1:circulation
        weight=measure_to_weight(Number,measure(:,sequence)...
            ,probability,Measure_Location...
            ,Microphone_Distance,Measure_Cita,Size_Grid,scale,weight);
    end
    [~,sequence]=sort(weight,'descend');
end
%Recursion Method-------------------------end