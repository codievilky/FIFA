% main function
clc;
clear all  %清除
close all; %关闭之前数据
Size_Grid=10;  %房间大小，单位：m
Room_Length=Size_Grid; %房间长度
Room_Width=Size_Grid;  %房间宽度
RUNS = 10; %%仿真次数
scale=5;        %%%%%%%%%%%%%%%%%%%%%%%%%%%%可变参数，GM算法的空间离散化步长
Microphone_Distance=0.2; %手机上两个mic之间距离
measure_alpha=0.75;     %%%切割概率
percent             = 0.95;      %计算定位误差时，只取前90%，舍掉最大的10%
KNN=4;  %% Basic Hamming parameter ，Hamming距离最小的KNN个点取平均
location_error_range_abs = 0.05;         %%%%%%%%%%%%%%%%%%%%节点位置误差范围,单位m
angle_error_range_abs = 5;            %%%%%%%%%%%%%%%%%%%节点角度误差范围,单位角度
Node_Error_NUM_Percent=0.1; %%%%%%%%%%%%%%%%%%%节点量测信息出错的百分比
real_statics_run=floor(RUNS*percent);
Node_Number=100;
Node_Error_NUM=floor(Node_Error_NUM_Percent*Node_Number);
for_begin=1;
for_gap=1;
for_end=10;%事件最大值
x_label=for_begin:for_gap:for_end;
Detection_Ratio=3;
for runs=1:RUNS
    count=0;
    runs  
    Random_Node_Sequence=randperm(Node_Number);
    Error_Node=sort(Random_Node_Sequence(1:Node_Error_NUM));
    Microphone_Cita=fix(-90+180*(rand(Node_Number,1))); %%朝向 [-90  90]
    Microphone_Center_Location=fix(Size_Grid*abs((rand(Node_Number,2)))); % 中心 位置
    %不同声源，错误节点相同
    for circulation_var=for_begin:for_gap:for_end
        count=count+1;
        node_promote_weight=zeros(1,Node_Number);%改进方法权值
        node_basic_weight=zeros(1,Node_Number);%基本方法权值
        promote_ratio=[];
        basic_ratio=[];
        for sequence=1:circulation_var
            real_speaker_location=(Size_Grid*abs((rand(1,2))));
            measure_data=get_sequence(Microphone_Center_Location,Microphone_Cita,real_speaker_location);
            %切割概率
            measure_data_probability=ones(Node_Number,1);
            for i=1:Node_Number
                measure_data_probability(i)=measure_alpha;
            end
            %加入节点的位置与指向误差, 准备仿真数据
            Microphone_Cita_with_error=Microphone_Cita+angle_error_range_abs*2*(-0.5+rand(size(Microphone_Cita)));
            Microphone_Center_Location_with_error=Microphone_Center_Location+location_error_range_abs*2*(-0.5+rand(size(Microphone_Center_Location)));
            %生成错误节点
            err_node=Error_Node;
            %err_node=create_error_node_with_probility(Error_Node,Microphone_Center_Location,Microphone_Cita,real_speaker_location(1,:));
            %生成有错误的测量数据
            measure_data_with_error=measure_data;
            for i=1:Node_Error_NUM
                if err_node(1,i)~=0
                    if measure_data_with_error(err_node(1,i))==0
                        measure_data_with_error(err_node(1,i))=1;
                    else
                        measure_data_with_error(err_node(1,i))=0;
                    end
                end
            end         
            %调用定位方法
            estimated_location = GM_Probility_Cutting(Node_Number,measure_data_with_error...
                ,measure_data_probability,Microphone_Center_Location_with_error...
                ,Microphone_Distance,Microphone_Cita_with_error,Size_Grid,scale);
            
            estimated_data=get_sequence(Microphone_Center_Location_with_error,Microphone_Cita_with_error,estimated_location);
            faulty_node=zeros(1,100);
            for i=1:Node_Number
                %当测量值不等于有定位结果分析的'真实值'时，实验中认为说明该节点出错
                if measure_data_with_error(i)~=estimated_data(i)
                    faulty_node(i)=1;
                end
            end
            %计算每个估计出来的错误节点和声源的位置
            %因为越远越不容易出错，所以权值和距离成正相关
            %distance_multi=calculate_dis(Microphone_Center_Location_with_error(i,:),Microphone_Cita_with_error(i,:),estimated_location);
            %提升的方法使用距离进行加权
            node_promote_weight=calculate_weight(node_promote_weight,Microphone_Center_Location_with_error...
                ,Microphone_Cita_with_error,estimated_location,faulty_node);
            node_basic_weight=node_basic_weight+faulty_node;
        end
        figure;
        bar(node_basic_weight);
        %对于计算错误节点中的proportion，从2一直试验到4，寻找效果最好的proportion
        miniest=9999;
        proportion=1;
        for i=1:0.1:4
            c_enode=calculate_error_node(Node_Number,node_promote_weight,i);
            likeness=xubao(Error_Node,c_enode)+wubao(Error_Node,c_enode);
            if likeness<miniest
                miniest=likeness;
                proportion=i;
            end
        end
        mini_basic=9999;
        propor_basic=2;
        for i=2:0.1:4
            c_enode=calculate_error_node(Node_Number,node_basic_weight,i);
            likeness=xubao(Error_Node,c_enode)+wubao(Error_Node,c_enode);
            if likeness<mini_basic
                mini_basic=likeness;
                propor_basic=i;
            end
        end
        %对实验结果进行打印
        %figure(count);
        %bar(node_promote_weight,2);
        Error_Node;
%         promote_ratio=[promote_ratio proportion];
%         basic_ratio=[basic_ratio propor_basic];
        promote_method=calculate_error_node(Node_Number,node_promote_weight,proportion);
        basic_method=calculate_error_node(Node_Number,node_basic_weight,propor_basic);
        FPR_Advance_tmp(count)=xubao(Error_Node,promote_method);
        FNR_Advance_tmp(count)=wubao(Error_Node,promote_method);
        FPR_Basic_tmp(count)=xubao(Error_Node,basic_method);
        FNR_Basic_tmp(count)=wubao(Error_Node,basic_method);
        node_basic_weight_temp(count,:)=node_basic_weight;
    end
    
%     pause;
    FPR_Advance(runs,:)=FPR_Advance_tmp;
    FNR_Advance(runs,:)=FNR_Advance_tmp;
    FPR_Basic(runs,:)=FPR_Basic_tmp;
    FNR_Basic(runs,:)=FNR_Basic_tmp;
end

FPR_Advance_mean = mean(FPR_Advance(1:RUNS,:));
FNR_Advance_mean = mean(FNR_Advance(1:RUNS,:));
FPR_Basic_mean = mean(FPR_Basic(1:RUNS,:));
FNR_Basic_mean = mean(FNR_Basic(1:RUNS,:));
%print figure
save sequence_data.mat RUNS x_label FPR_Advance FNR_Advance FPR_Basic FNR_Basic...
    FPR_Advance_mean FNR_Advance_mean FPR_Basic_mean FNR_Basic_mean promote_ratio...
    basic_ratio
%clear all;
load sequence_data.mat

figure('Position',[1 1 1200 900])
plot(x_label, FPR_Advance_mean, 'rs-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
hold on;
plot(x_label, FPR_Basic_mean, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
hold off
legend('\fontsize{12}\bf Advance','\fontsize{12}\bf Basic ');

xlabel('\fontsize{12}\bf Sequence Number');
ylabel('\fontsize{12}\bf FPR');
title('\fontsize{12}\bf  Sequence Number vs. FPR');

figure('Position',[1 1 1200 900])
plot(x_label, FNR_Advance_mean, 'rs-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
hold on;
plot(x_label, FNR_Basic_mean, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
hold off
legend('\fontsize{12}\bf Advance','\fontsize{12}\bf Basic ');

xlabel('\fontsize{12}\bf Sequence Number');
ylabel('\fontsize{12}\bf FNR');
title('\fontsize{12}\bf  Sequence Number vs. FNR');
