function [ weight ] = Get_Weight(measure,probability,Location,Microphone_Distance,Cita,Size_Grid,scale)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[Number,circulation]=size(measure);
weight=zeros(Number,1);
for sequence=1:circulation
    estimated_location = GM_Probility_Cutting(Number,measure(:,sequence),probability,Location,Microphone_Distance,Cita,Size_Grid,scale);
    estimated_data=get_sequence(Number,Location,Cita,estimated_location,0);
    for i=1:Number
        %当测量值不等于有定位结果分析的'真实值'时，实验中认为说明该节点出错
        if measure(i,sequence)~=estimated_data(i)
            weight(i)=weight(i)+1;
        end
    end
end
bar(weight);
hist(weight,0:1:10);
close all;
end

