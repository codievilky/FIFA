function [Room_tag] = Incise_probability(Node_number,measure_data,measure_data_probability,Microphone_Center_Location,Microphone_Distance,Mic_vector,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale)
Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
step=scale;  %测试步长
%%手机中心位置Microphone_Center_Location
Microphone_Center_Location=(Microphone_1_Location+Microphone_2_Location)/2;
%方向矢量Direct_vector
Mic_vector=Microphone_1_Location-Microphone_2_Location;
a=Mic_vector(1:end,1);
b=Mic_vector(1:end,2);
x0=Microphone_Center_Location(1:end,1);
y0=Microphone_Center_Location(1:end,2); 

Room_tag=zeros(Room_Length*step,Room_Width*step); %记录房间内点是否符合条件 1为符合 0为不符合 
for Node_ii=1:Node_number  %第Node_ii个结点
	    %遍历整个房间，不符合条件的点置0
	for x_i=1:Room_Width*step
    	for y_j=1:Room_Length*step
               tmp11=a(Node_ii).*(x_i/step-x0(Node_ii))+b(Node_ii).*(y_j/step-y0(Node_ii)); 
             if tmp11>0
             	tmp11=1;
             else 
             	%tmp11=-1;
             	tmp11=0;
             end
 
             if tmp11==measure_data(Node_ii)
             	Room_tag(x_i,y_j)=Room_tag(x_i,y_j)+ measure_data_probability(Node_ii);
             else 
                Room_tag(x_i,y_j)=Room_tag(x_i,y_j)+ 1-measure_data_probability(Node_ii);
             end
 
        end
    end       
end
end

