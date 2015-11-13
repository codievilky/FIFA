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
FPR_Advanced=zeros(RUNS,for_end-for_begin+1);
FNR_Advanced=zeros(RUNS,for_end-for_begin+1);
FPR_Basic=zeros(RUNS,for_end-for_begin+1);
FNR_Basic=zeros(RUNS,for_end-for_begin+1);
FPR_Recursion=zeros(RUNS,for_end-for_begin+1);
FNR_Recursion=zeros(RUNS,for_end-for_begin+1);
for runs=1:RUNS
    runs
    Random_Node_Sequence=randperm(Node_Number);
    Error_Node=sort(Random_Node_Sequence(1:Node_Error_NUM));
    Microphone_Cita=fix(-90+180*(rand(Node_Number,1))); %%朝向 [-90  90]
    Microphone_Center_Location=fix(Size_Grid*abs((rand(Node_Number,2)))); % 中心 位置
    %不同声源，错误节点相同
    for circulation=for_begin:for_gap:for_end
        
        node_basic_weight=zeros(1,Node_Number);%基本方法权值
        real_data=zeros(Node_Number,circulation);
        measure_data=zeros(Node_Number,circulation);
        real_speaker_location=zeros(circulation,2);
        %获得出所有的测量数据----------------------
        for sequence=1:circulation
            real_speaker_location(sequence,:)=(Size_Grid*abs((rand(1,2))));
            real_data(:,sequence)=get_sequence(Node_Number,Microphone_Center_Location,Microphone_Cita,real_speaker_location(sequence,:));
            %切割概率
            probability=ones(Node_Number,1);
            for i=1:Node_Number
                probability(i)=measure_alpha;
            end
            %加入节点的位置与指向误差, 准备仿真数据
            Measure_Cita=Microphone_Cita+angle_error_range_abs*2*(-0.5+rand(size(Microphone_Cita)));
            Measure_Location=Microphone_Center_Location+location_error_range_abs*2*(-0.5+rand(size(Microphone_Center_Location)));
            %生成错误节点
            err_node=Error_Node;
            %生成有错误的测量数据
            measure_data(:,sequence)=real_data(:,sequence);
            for i=1:Node_Error_NUM
                if err_node(1,i)~=0
                    if measure_data(err_node(1,i),sequence)==0
                        measure_data(err_node(1,i),sequence)=1;
                    else
                        measure_data(err_node(1,i),sequence)=0;
                    end
                end
            end
        end
        %获得三次测量数据------------------------end
        %基本方法
        Basic_ErrorNode=Basic_Method(circulation,Error_Node,Node_Number,measure_data,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale);
        %递归方法
        Recursion_ErrorNode=Recursion_Method(circulation,Node_Number,measure_data,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale);
        %提升方法
        Advanced_ErrorNode=Advanced_Method(circulation,Error_Node,Node_Number,measure_data,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale);
        
        [FPR_Basic_tmp(circulation-for_begin+1),FNR_Basic_tmp(circulation-for_begin+1)]=False_Rate(Error_Node,Basic_ErrorNode);
        [FPR_Recursion_tmp(circulation-for_begin+1),FNR_Recursion_tmp(circulation-for_begin+1)]=False_Rate(Error_Node,Recursion_ErrorNode);
        [FPR_Advanced_tmp(circulation-for_begin+1),FNR_Advanced_tmp(circulation-for_begin+1)]=False_Rate(Error_Node,Advanced_ErrorNode);
        
        
    end
    
    %     pause;
    FPR_Advanced(runs,:)=FPR_Advanced_tmp;
    FNR_Advanced(runs,:)=FNR_Advanced_tmp;
    FPR_Basic(runs,:)=FPR_Basic_tmp;
    FNR_Basic(runs,:)=FNR_Basic_tmp;
    FPR_Recursion(runs,:)=FPR_Recursion_tmp;
    FNR_Recursion(runs,:)=FNR_Recursion_tmp;
end

FPR_Advanced_mean = mean(FPR_Advanced(1:RUNS,:));
FNR_Advanced_mean = mean(FNR_Advanced(1:RUNS,:));
FPR_Basic_mean = mean(FPR_Basic(1:RUNS,:));
FNR_Basic_mean = mean(FNR_Basic(1:RUNS,:));
FPR_Recursion_mean = mean(FPR_Recursion(1:RUNS,:));
FNR_Recursion_mean = mean(FNR_Recursion(1:RUNS,:));
%print figure
save print_data.mat x_label FPR_Advanced_mean FNR_Advanced_mean FPR_Basic_mean...
    FNR_Basic_mean FPR_Recursion_mean FNR_Recursion_mean

%clear all;
print_diagram();