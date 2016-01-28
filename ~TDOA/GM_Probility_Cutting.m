function [return_value]=GM_Probility_Cutting(Node_number,measure_data,measure_data_probability,Microphone_Center_Location,Microphone_Distance,Microphone_Cita,Size_Grid,scale)



Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
step=scale;  %测试步长

        Microphone_1_Location=zeros(Node_number,2);
		Microphone_2_Location=zeros(Node_number,2);
		
        for  i=1:Node_number
        %%(L/2,0)
	    Microphone_1_Location(i,1)=Microphone_Center_Location(i,1) + 0.5*Microphone_Distance*(cos(Microphone_Cita(i)*pi/180));
        Microphone_1_Location(i,2)=Microphone_Center_Location(i,2) + 0.5*Microphone_Distance*(-sin(Microphone_Cita(i)*pi/180));  
		 %%(-L/2,0)
        Microphone_2_Location(i,1)=Microphone_Center_Location(i,1) - 0.5*Microphone_Distance*(cos(Microphone_Cita(i)*pi/180));
        Microphone_2_Location(i,2)=Microphone_Center_Location(i,2) - 0.5*Microphone_Distance*(-sin(Microphone_Cita(i)*pi/180));        
        end
		
Mic_vector=Microphone_1_Location-Microphone_2_Location;
Room_tag=zeros(Room_Length*step,Room_Width*step); %记录房间内点是否符合条件 1为符合 0为不符合
Room_tag=Incise_probability(Node_number,measure_data,measure_data_probability,Microphone_Center_Location,Microphone_Distance,Mic_vector,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale);

[x,y]=Coordinate2(Room_tag,Size_Grid,scale);

xx=1:Room_Width*step;
xx=xx./step;
yy=1:Room_Width*step;
yy=yy./step;
[X,Y]=meshgrid(xx,yy);
Z=Room_tag;

estimated_location=[x y];
return_value=estimated_location;