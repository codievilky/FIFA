% main function
clc;
clear all  %���
close all; %�ر�֮ǰ����
Size_Grid=10;  %�����С����λ��m
Room_Length=Size_Grid; %���䳤��
Room_Width=Size_Grid;  %������
RUNS = 10; %%�������
scale=5;        %%%%%%%%%%%%%%%%%%%%%%%%%%%%�ɱ������GM�㷨�Ŀռ���ɢ������
Microphone_Distance=0.2; %�ֻ�������mic֮�����
measure_alpha=0.75;     %%%�и����
percent             = 0.95;      %���㶨λ���ʱ��ֻȡǰ90%���������10%
KNN=4;  %% Basic Hamming parameter ��Hamming������С��KNN����ȡƽ��
location_error_range_abs = 0.05;         %%%%%%%%%%%%%%%%%%%%�ڵ�λ����Χ,��λm
angle_error_range_abs = 5;            %%%%%%%%%%%%%%%%%%%�ڵ�Ƕ���Χ,��λ�Ƕ�
Node_Error_NUM_Percent=0.1; %%%%%%%%%%%%%%%%%%%�ڵ�������Ϣ����İٷֱ�
real_statics_run=floor(RUNS*percent);
Node_Number=100;
Node_Error_NUM=floor(Node_Error_NUM_Percent*Node_Number);
for_begin=1;
for_gap=1;
for_end=10;%�¼����ֵ
x_label=for_begin:for_gap:for_end;
Detection_Ratio=3;
for runs=1:RUNS
    count=0;
    runs  
    Random_Node_Sequence=randperm(Node_Number);
    Error_Node=sort(Random_Node_Sequence(1:Node_Error_NUM));
    Microphone_Cita=fix(-90+180*(rand(Node_Number,1))); %%���� [-90  90]
    Microphone_Center_Location=fix(Size_Grid*abs((rand(Node_Number,2)))); % ���� λ��
    %��ͬ��Դ������ڵ���ͬ
    for circulation_var=for_begin:for_gap:for_end
        count=count+1;
        node_promote_weight=zeros(1,Node_Number);%�Ľ�����Ȩֵ
        node_basic_weight=zeros(1,Node_Number);%��������Ȩֵ
        promote_ratio=[];
        basic_ratio=[];
        for sequence=1:circulation_var
            real_speaker_location=(Size_Grid*abs((rand(1,2))));
            measure_data=get_sequence(Microphone_Center_Location,Microphone_Cita,real_speaker_location);
            %�и����
            measure_data_probability=ones(Node_Number,1);
            for i=1:Node_Number
                measure_data_probability(i)=measure_alpha;
            end
            %����ڵ��λ����ָ�����, ׼����������
            Microphone_Cita_with_error=Microphone_Cita+angle_error_range_abs*2*(-0.5+rand(size(Microphone_Cita)));
            Microphone_Center_Location_with_error=Microphone_Center_Location+location_error_range_abs*2*(-0.5+rand(size(Microphone_Center_Location)));
            %���ɴ���ڵ�
            err_node=Error_Node;
            %err_node=create_error_node_with_probility(Error_Node,Microphone_Center_Location,Microphone_Cita,real_speaker_location(1,:));
            %�����д���Ĳ�������
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
            %���ö�λ����
            estimated_location = GM_Probility_Cutting(Node_Number,measure_data_with_error...
                ,measure_data_probability,Microphone_Center_Location_with_error...
                ,Microphone_Distance,Microphone_Cita_with_error,Size_Grid,scale);
            
            estimated_data=get_sequence(Microphone_Center_Location_with_error,Microphone_Cita_with_error,estimated_location);
            faulty_node=zeros(1,100);
            for i=1:Node_Number
                %������ֵ�������ж�λ���������'��ʵֵ'ʱ��ʵ������Ϊ˵���ýڵ����
                if measure_data_with_error(i)~=estimated_data(i)
                    faulty_node(i)=1;
                end
            end
            %����ÿ�����Ƴ����Ĵ���ڵ����Դ��λ��
            %��ΪԽԶԽ�����׳�������Ȩֵ�;���������
            %distance_multi=calculate_dis(Microphone_Center_Location_with_error(i,:),Microphone_Cita_with_error(i,:),estimated_location);
            %�����ķ���ʹ�þ�����м�Ȩ
            node_promote_weight=calculate_weight(node_promote_weight,Microphone_Center_Location_with_error...
                ,Microphone_Cita_with_error,estimated_location,faulty_node);
            node_basic_weight=node_basic_weight+faulty_node;
        end
        figure;
        bar(node_basic_weight);
        %���ڼ������ڵ��е�proportion����2һֱ���鵽4��Ѱ��Ч����õ�proportion
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
        %��ʵ�������д�ӡ
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
