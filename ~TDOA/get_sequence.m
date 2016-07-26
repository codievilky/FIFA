function sequence=get_sequence(Number,location,cita,acoustic_location,TODA)
load data.mat
sequence=zeros(Number,1);
Microphone_1_Location=zeros(Number,2);
Microphone_2_Location=zeros(Number,2);	
TDOA_tmp = zeros(Number,1);
for  i=1:Number
        %%(L/2,0)
	    Microphone_1_Location(i,1)=location(i,1) + 0.5*Microphone_Distance*(cos(cita(i)*pi/180));
        Microphone_1_Location(i,2)=location(i,2) + 0.5*Microphone_Distance*(-sin(cita(i)*pi/180));  
		 %%(-L/2,0)
        Microphone_2_Location(i,1)=location(i,1) - 0.5*Microphone_Distance*(cos(cita(i)*pi/180));
        Microphone_2_Location(i,2)=location(i,2) - 0.5*Microphone_Distance*(-sin(cita(i)*pi/180));        
end		
for i = 1:Number
    TDOA_tmp(i) = GetDistance(acoustic_location,Microphone_1_Location(i,:)) - GetDistance(acoustic_location,Microphone_2_Location(i,:));
end
% Mic_vector_tmp=Microphone_1_Location-Microphone_2_Location;      
% aa=Mic_vector_tmp(1:end,1);
% bb=Mic_vector_tmp(1:end,2);
% xx0=location(1:end,1);
% yy0=location(1:end,2);
% sequence_tmp=aa.*(acoustic_location(1)-xx0)+bb.*(acoustic_location(2)-yy0)
TDOA_tmp = TDOA_tmp * 44100 / 340;
TDOA_tmp = TDOA_tmp + TODA * 2 * (-0.5 + rand(size(TODA)));
%通过每个最终的定位结果估计每个节点应该的数值
for i=1:Number
            if TDOA_tmp(i)<0
                sequence(i)=1;
            else
                sequence(i)=0;
            end
end