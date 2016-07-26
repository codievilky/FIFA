function Error_Node=OnlyOne_Method(weight)
[Number,~]=size(weight);
Error_Node=zeros(1,Number);
Error_Count=1;
bar(weight);
close all;
for i=1:Number
    if weight(i)>1
        Error_Node(Error_Count)=i;
        Error_Count=Error_Count+1;
    end
end
Error_Node=CutEnd(Error_Node,Error_Count-1);
% for i=1:Number
% %y-y0=tan(cita-pi/2)(x-x0)
% %计算一条直线切一个长方形后，这条线的在长方形中的长度
%     k=tan(Cita(i)-pi/2);
%     point=zeros(2);
%     count=1;
%     %如果x=0
%     y1=k*(Location(i,1))+Location(i,2);%y=k(x-x0)+y0
%     if y1<=Size_Grid && y1>=0
%         point(count,1)=0;
%         point(count,2)=y1;
%         count=count+1;
%     end
%     %如果x=Size_Grid
%     y2=k*(Size_Grid-Location(i,1))+Location(i,2);%y=k(x-x0)+y0'
%     if y2<=Size_Grid && y2>=0
%         point(count,1)=Size_Grid;
%         point(count,2)=y2;
%         count=count+1;
%         
%     end
%     %如果y=0
%     x1=(0-Location(i,2))/k+Location(i,1);%x=(y-y0)/k+x0
%     if x1<=Size_Grid && x1>=0
%         point(count,1)=x1;
%         point(count,2)=0;
%         count=count+1;
%     end
%     %如果y=0
%     x2=(Size_Grid-Location(i,2))/k+Location(i,1);
%     if x2<=Size_Grid && x2>=0
%         point(count,1)=x2;
%         point(count,2)=Size_Grid;
%     end
%     unique(point,'rows');
%     error(i)=norm(point(1)-point(2))/(Size_Grid^2);
% end
