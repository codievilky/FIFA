function Error_Node=Promoted_Method(measure,probability,Location,Microphone_Distance,Cita,Size_Grid,scale)
[Number,circulation]=size(measure);
Error_Node=zeros(1,Number);
weight=zeros(1,Number);
for sequence=1:circulation
    estimated_location = GM_Probility_Cutting(Number,measure(:,sequence),probability,Location,Microphone_Distance,Cita,Size_Grid,scale);
    estimated_data=get_sequence(Number,Location,Cita,estimated_location);
    for i=1:Number
        %当测量值不等于有定位结果分析的'真实值'时，实验中认为说明该节点出错
        if measure(i,sequence)~=estimated_data(i)
            weight(i)=weight(i)+1;
        end
    end
end
weight=weight/circulation;
%[~,sequence]=sort(weight,'descend');%降序排序
bar(weight);
%y-y0=tan(cita-pi/2)(x-x0)
error=ones(1,Number);
for i=1:Number
    k=tan(Cita(i)-pi/2);
    point=zeros(2);
    count=1;
    %如果x=0
    y1=k*(Location(i,1))+Location(i,2);%y=k(x-x0)+y0
    if y1<=Size_Grid && y1>=0
        point(count,1)=0;
        point(count,2)=y1;
        count=count+1;
    end
    %如果x=Size_Grid
    y2=k*(Size_Grid-Location(i,1))+Location(i,2);%y=k(x-x0)+y0'
    if y2<=Size_Grid && y2>=0
        point(count,1)=Size_Grid;
        point(count,2)=y2;
        count=count+1;
        
    end
    %如果y=0
    x1=(0-Location(i,2))/k+Location(i,1);%x=(y-y0)/k+x0
    if x1<=Size_Grid && x1>=0
        point(count,1)=x1;
        point(count,2)=0;
        count=count+1;
    end
    %如果y=0
    x2=(Size_Grid-Location(i,2))/k+Location(i,1);
    if x2<=Size_Grid && x2>=0
        point(count,1)=x2;
        point(count,2)=Size_Grid;
    end
    unique(point,'rows');
    error(i)=norm(point(1)-point(2))/(Size_Grid^2);
end
figure;
bar(error);
close all;
    % B=0;
    % Error_Count=0;
    % Error_Average=0;
    % for i=1:Number
    %     if weight(sequence(i))<==B
    %         break;
    %     else
    %         Error_Average=(Error_Average*Error_Count+weight(sequence(i)))/(Error_Count+1);
    %         Error_Count=Error_Count+1;
    %         B=Error_Average/circulation+Error_Count/Number;
    %         Error_Node(Error_Count)=sequence(i);
    %     end
    % end
    % Error_Node=CutEnd(Error_Node,Error_Count);