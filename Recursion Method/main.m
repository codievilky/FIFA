% main function
clc;
%clear all  %清除
close all; %关闭之前数据
Size_Grid=10;  %房间大小，单位：m
Room_Length=Size_Grid; %房间长度
Room_Width=Size_Grid;  %房间宽度
RUNS = 20; %%仿真次数
scale=5;    %       可变参数，GM算法的空间离散化步长
Microphone_Distance=0.2; %手机上两个mic之间距离
measure_alpha=0.75;     %%%切割概率
percent             = 0.95;      %计算定位误差时，只取前90%，舍掉最大的10%
KNN=4;  %% Basic Hamming parameter ，Hamming距离最小的KNN个点取平均
location_error_range_abs = 0.03;         %%%%%%%%%%%%%%%%%%%%节点位置误差范围,单位m
angle_error_range_abs = 5;            %%%%%%%%%%%%%%%%%%%节点角度误差范围,单位角度
Node_Error_NUM_Percent=0.10; %%%%%%%%%%%%%%%%%%%节点量测信息出错的百分比
real_statics_run=floor(RUNS*percent);
Node_Number=100;
Node_Error_NUM=floor(Node_Error_NUM_Percent*Node_Number);
for_begin=1;
for_gap=1;
for_end=10;%事件最大值
x_label=for_begin:for_gap:for_end;
Detection_Ratio=3;
FPR_Advance=zeros(RUNS,for_end-for_begin+1);
FNR_Advance=zeros(RUNS,for_end-for_begin+1);
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
        measure_data=zeros(Node_Number,circulation_var);
        measure_data_with_error=zeros(Node_Number,circulation_var);
        real_speaker_location=zeros(circulation_var,2);
        %获得出所有的测量数据----------------------
        for sequence=1:circulation_var
            real_speaker_location(sequence,:)=(Size_Grid*abs((rand(1,2))));
            measure_data(:,sequence)=get_sequence(Node_Number,Microphone_Center_Location,Microphone_Cita,real_speaker_location(sequence,:));
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
            %生成有错误的测量数据
            measure_data_with_error(:,sequence)=measure_data(:,sequence);
            for i=1:Node_Error_NUM
                if err_node(1,i)~=0
                    if measure_data_with_error(err_node(1,i),sequence)==0
                        measure_data_with_error(err_node(1,i),sequence)=1;
                    else    
                        measure_data_with_error(err_node(1,i),sequence)=0;
                    end
                end
            end
        end
        %获得三次测量数据------------------------end
        %Recursion Method-------------------------
        promote_method=[];            
        %通过测量数据求得三次的权值
        for sequence=1:circulation_var
            node_promote_weight=measure_to_weight(Node_Number,measure_data_with_error(:,sequence)...
                ,measure_data_probability,Microphone_Center_Location_with_error...
                ,Microphone_Distance,Microphone_Cita_with_error,Size_Grid,scale,node_promote_weight);
        end
        [sorted_weight,sequence]=sort(node_promote_weight,'descend');
        while all(numel(promote_method)~=10)
            figure(1);
            bar(node_promote_weight);
            %将最高值认为是错误节点
            error_node=sequence(1);
            promote_method=[promote_method error_node(1)];
            %删除错误节点的所有数据
            measure_data_with_error(error_node(1),:)=~measure_data_with_error(error_node(1),:);
            %改进方法权值
            node_promote_weight=zeros(1,Node_Number);
            %通过测量数据求得三次的权值
            for sequence=1:circulation_var
                node_promote_weight=measure_to_weight(Node_Number,measure_data_with_error(:,sequence)...
                    ,measure_data_probability,Microphone_Center_Location_with_error...
                    ,Microphone_Distance,Microphone_Cita_with_error,Size_Grid,scale,node_promote_weight);    
            end
            [sorted_weight,sequence]=sort(node_promote_weight,'descend');            
        end
        %Recursion Method-------------------------end
        %basic_method=calculate_error_node(Node_Number,node_basic_weight,propor_basic);
        FPR_Advance_tmp(count)=xubao(Error_Node,promote_method);
        FNR_Advance_tmp(count)=wubao(Error_Node,promote_method);
        %FPR_Basic_tmp(count)=xubao(Error_Node,basic_method);
       % FNR_Basic_tmp(count)=wubao(Error_Node,basic_method);
        %node_basic_weight_temp(count,:)=node_basic_weight;
    end
    
    %     pause;
    FPR_Advance(runs,:)=FPR_Advance_tmp;
    FNR_Advance(runs,:)=FNR_Advance_tmp;
   % FPR_Basic(runs,:)=FPR_Basic_tmp;
   % FNR_Basic(runs,:)=FNR_Basic_tmp;
end

FPR_Advance_mean = mean(FPR_Advance(1:RUNS,:));
FNR_Advance_mean = mean(FNR_Advance(1:RUNS,:));
%FPR_Basic_mean = mean(FPR_Basic(1:RUNS,:));
%FNR_Basic_mean = mean(FNR_Basic(1:RUNS,:));
%print figure
save sequence_data.mat RUNS x_label FPR_Advance FNR_Advance  ...
    FPR_Advance_mean FNR_Advance_mean   ...
    
%clear all;
load sequence_data.mat
figure;
%figure('Position',[1 1 1200 900])
plot(x_label, FPR_Advance_mean, 'rs-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
hold on;
%plot(x_label, FPR_Basic_mean, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
hold off
legend('\fontsize{12}\bf Advance');

xlabel('\fontsize{12}\bf Sequence Number');
ylabel('\fontsize{12}\bf FPR');
title('\fontsize{12}\bf  Sequence Number vs. FPR');
figure;
%figure('Position',[1 1 1200 900])
plot(x_label, FNR_Advance_mean, 'rs-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
hold on;
%plot(x_label, FNR_Basic_mean, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
hold off
legend('\fontsize{12}\bf Advance');

xlabel('\fontsize{12}\bf Sequence Number');
ylabel('\fontsize{12}\bf FNR');
title('\fontsize{12}\bf  Sequence Number vs. FNR');
