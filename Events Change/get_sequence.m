function sequence=get_sequence(location,cita,acoustic_location)
load data.mat
sequence=zeros(Node_Number,1);
Microphone_1_Location=zeros(Node_Number,2);
Microphone_2_Location=zeros(Node_Number,2);		
for  i=1:Node_Number
        %%(L/2,0)
	    Microphone_1_Location(i,1)=location(i,1) + 0.5*Microphone_Distance*(cos(cita(i)*pi/180));
        Microphone_1_Location(i,2)=location(i,2) + 0.5*Microphone_Distance*(-sin(cita(i)*pi/180));  
		 %%(-L/2,0)
        Microphone_2_Location(i,1)=location(i,1) - 0.5*Microphone_Distance*(cos(cita(i)*pi/180));
        Microphone_2_Location(i,2)=location(i,2) - 0.5*Microphone_Distance*(-sin(cita(i)*pi/180));        
end		
Mic_vector_tmp=Microphone_1_Location-Microphone_2_Location;      
aa=Mic_vector_tmp(1:end,1);
bb=Mic_vector_tmp(1:end,2);
xx0=location(1:end,1);
yy0=location(1:end,2);
sequence_tmp=aa.*(acoustic_location(1)-xx0)+bb.*(acoustic_location(2)-yy0);
%通过每个最终的定位结果估计每个节点应该的数值
for i=1:Node_Number
            if sequence_tmp(i)>0
                sequence(i)=1;
            else
                sequence(i)=0;
            end
end