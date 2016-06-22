function Error_Node=Bound_Method(measure,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale)
[Number,circulation]=size(measure);
Error_Node=zeros(1,Number);
weight=zeros(1,Number);
for sequence=1:circulation
    weight=measure_to_weight(measure(:,sequence),probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale,weight);
end
figure;
bar(weight);

[~,sequence]=sort(weight,'descend');%Ωµ–Ú≈≈–Ú
B=0;
Error_Count=0;
Error_Average=0;
for i=1:Number
    if weight(sequence(i))<=B
        break;
    else
        Error_Average=(Error_Average*Error_Count+weight(sequence(i)))/(Error_Count+1);
        Error_Count=Error_Count+1;
        B=Error_Average/circulation+Error_Count/Number;
        Error_Node(Error_Count)=sequence(i);
    end
end
Error_Node=CutEnd(Error_Node,Error_Count);