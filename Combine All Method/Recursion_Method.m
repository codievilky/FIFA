function Error_Node=Recursion_Method(measure,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale)
[Number,circulation]=size(measure);
Error_Node=zeros(1,Number);
weight=zeros(1,Number);
for sequence=1:circulation
    weight=measure_to_weight(measure(:,sequence),probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale,weight);
    if weight==zeros(1,Number);
        break;
    end
end
Error_Count=0;
%while numel(Error_Node)~=10
while weight~=zeros(1,Number);
    Error_Count=Error_Count+1;
    [~,sequence]=sort(weight,'descend');%降序排序
    figure(1);
    bar(weight);
    close all;
    Error=sequence(1);%将最高值认为是错误节点    
    Error_Node(Error_Count)=Error;
    measure(Error,:)=~measure(Error,:);%修改错误节点的所有数据
    weight=zeros(1,Number);
    for sequence=1:circulation
        weight=measure_to_weight(measure(:,sequence)...
            ,probability,Measure_Location...
            ,Microphone_Distance,Measure_Cita,Size_Grid,scale,weight);
        if weight==zeros(1,Number);
            break;
        end
    end
end

Error_Node=CutEnd(Error_Node,Error_Count);
%Recursion Method-------------------------end