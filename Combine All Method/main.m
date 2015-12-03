% main function
clc;
%clear all  %���
close all; %�ر�֮ǰ����
RUNS = 10; %%�������
Node_Error_NUM_Percent=0.10; %%%%%%%%%%%%%%%%%%%�ڵ�������Ϣ����İٷֱ�
for_begin=10;%ɨ�������Сֵ
for_gap=5;
for_end=30;%ɨ��������ֵ

Size_Grid=10;  %�����С����λ��m
Room_Length=Size_Grid; %���䳤��
Room_Width=Size_Grid;  %������
scale=5;    %       �ɱ������GM�㷨�Ŀռ���ɢ������
Microphone_Distance=0.2; %�ֻ�������mic֮�����
measure_alpha=0.75;     %%%�и����
percent             = 0.95;      %���㶨λ���ʱ��ֻȡǰ90%���������10%
KNN=4;  %% Basic Hamming parameter ��Hamming������С��KNN����ȡƽ��
location_error_range_abs = 0.03;         %%%%%%%%%%%%%%%%%%%%�ڵ�λ����Χ,��λm
angle_error_range_abs = 5;            %%%%%%%%%%%%%%%%%%%�ڵ�Ƕ���Χ,��λ�Ƕ�
real_statics_run=floor(RUNS*percent);
Node_Number=100;


x_label=for_begin:for_gap:for_end;
Detection_Ratio=3;
FPR_Advanced=zeros(RUNS,(for_end-for_begin)/for_gap+1);
FNR_Advanced=zeros(RUNS,(for_end-for_begin)/for_gap+1);
FPR_Basic=zeros(RUNS,(for_end-for_begin)/for_gap+1);
FNR_Basic=zeros(RUNS,(for_end-for_begin)/for_gap+1);
FPR_Recursion=zeros(RUNS,(for_end-for_begin)/for_gap+1);
FNR_Recursion=zeros(RUNS,(for_end-for_begin)/for_gap+1);
FPR_Bound=zeros(RUNS,(for_end-for_begin)/for_gap+1);
FNR_Bound=zeros(RUNS,(for_end-for_begin)/for_gap+1);
for runs=1:RUNS
    runs
    Random_Node_Sequence=randperm(Node_Number);
    Microphone_Cita=fix(-90+180*(rand(Node_Number,1))); %%���� [-90  90]
    Microphone_Center_Location=fix(Size_Grid*abs((rand(Node_Number,2)))); % ���� λ��
    FPR_Advanced_tmp=zeros((for_end-for_begin)/for_gap+1,1);
    FNR_Advanced_tmp=zeros((for_end-for_begin)/for_gap+1,1);
    FPR_Basic_tmp=zeros((for_end-for_begin)/for_gap+1,1);
    FNR_Basic_tmp=zeros((for_end-for_begin)/for_gap+1,1);
    FPR_Bound_tmp=zeros((for_end-for_begin)/for_gap+1,1);
    FNR_Recursion_tmp=zeros((for_end-for_begin)/for_gap+1,1);
    FPR_Recursion_tmp=zeros((for_end-for_begin)/for_gap+1,1);
    FNR_Bound_tmp=zeros((for_end-for_begin)/for_gap+1,1);
    for Node_Error_NUM_Percent=for_begin:for_gap:for_end
        node_basic_weight=zeros(1,Node_Number);%��������Ȩֵ
        real_data=zeros(Node_Number,circulation);
        measure_data=zeros(Node_Number,circulation);
        real_speaker_location=zeros(circulation,2);
        Node_Error_NUM=floor(Node_Error_NUM_Percent*Node_Number/100);%��������ڵ����
        Error_Node=sort(Random_Node_Sequence(1:Node_Error_NUM));%��������ڵ�
%         if mod(circulation,5)==0
%             sequence=circulation
%         end
        circulation=3;
        %��ó����еĲ�������----------------------
        for sequence=1:circulation
            real_speaker_location(sequence,:)=(Size_Grid*abs((rand(1,2))));
            real_data(:,sequence)=get_sequence(Node_Number,Microphone_Center_Location,Microphone_Cita,real_speaker_location(sequence,:));
            %�и����
            probability=ones(Node_Number,1);
            for i=1:Node_Number
                probability(i)=measure_alpha;
            end
            %����ڵ��λ����ָ�����, ׼����������
            Measure_Cita=Microphone_Cita+angle_error_range_abs*2*(-0.5+rand( size(Microphone_Cita)));
            Measure_Location=Microphone_Center_Location+location_error_range_abs*2*(-0.5+rand(size(Microphone_Center_Location)));
            %���ɴ���ڵ�
            err_node=Error_Node;
            %�����д���Ĳ�������
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
        %��ó����еĲ�������------------------------end
        %��������
        Basic_ErrorNode=Basic_Method(circulation,Error_Node,Node_Number,measure_data,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale);
        %Basic_ErrorNode=zeros(1,20);
        
        %�ݹ鷽��
        %Recursion_ErrorNode=Recursion_Method(measure_data,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale);
        Recursion_ErrorNode=zeros(1,10);
        %��������
        %Advanced_ErrorNode=Advanced_Method(circulation,Error_Node,Node_Number,measure_data,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale);       
        Advanced_ErrorNode=zeros(1,10);
        %Bound����
        %Bound_ErrorNode=Bound_Method(measure_data,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale);
        %Bound_ErrorNode=zeros(1,10);
        
        Bound_ErrorNode=OnlyOne_Method(measure_data,probability,Measure_Location,Microphone_Distance,Measure_Cita,Size_Grid,scale);
        
        [FPR_Basic_tmp((Node_Error_NUM_Percent-for_begin)/for_gap+1),FNR_Basic_tmp((Node_Error_NUM_Percent-for_begin)/for_gap+1)]=False_Rate(Error_Node,Basic_ErrorNode);
        [FPR_Recursion_tmp((Node_Error_NUM_Percent-for_begin)/for_gap+1),FNR_Recursion_tmp((Node_Error_NUM_Percent-for_begin)/for_gap+1)]=False_Rate(Error_Node,Recursion_ErrorNode);
        [FPR_Advanced_tmp((Node_Error_NUM_Percent-for_begin)/for_gap+1),FNR_Advanced_tmp((Node_Error_NUM_Percent-for_begin)/for_gap+1)]=False_Rate(Error_Node,Bound_ErrorNode);
        [FPR_Bound_tmp((Node_Error_NUM_Percent-for_begin)/for_gap+1),FNR_Bound_tmp((Node_Error_NUM_Percent-for_begin)/for_gap+1)]=False_Rate(Error_Node,Bound_ErrorNode);

        
    end
    
    %     pause;
    FPR_Advanced(runs,:)=FPR_Advanced_tmp;
    FNR_Advanced(runs,:)=FNR_Advanced_tmp;
    FPR_Basic(runs,:)=FPR_Basic_tmp;
    FNR_Basic(runs,:)=FNR_Basic_tmp;
    FPR_Recursion(runs,:)=FPR_Recursion_tmp;
    FNR_Recursion(runs,:)=FNR_Recursion_tmp;
    FPR_Bound(runs,:)=FPR_Bound_tmp;
    FNR_Bound(runs,:)=FNR_Bound_tmp;
end

FPR_Advanced_mean = mean(FPR_Advanced(1:RUNS,:));
FNR_Advanced_mean = mean(FNR_Advanced(1:RUNS,:));
FPR_Basic_mean = mean(FPR_Basic(1:RUNS,:));
FNR_Basic_mean = mean(FNR_Basic(1:RUNS,:));
FPR_Recursion_mean = mean(FPR_Recursion(1:RUNS,:));
FNR_Recursion_mean = mean(FNR_Recursion(1:RUNS,:));
FPR_Bound_mean = mean(FPR_Bound(1:RUNS,:));
FNR_Bound_mean = mean(FNR_Bound(1:RUNS,:));
%print figure
save print_data.mat x_label FPR_Advanced_mean FNR_Advanced_mean FPR_Basic_mean...
    FNR_Basic_mean FPR_Recursion_mean FNR_Recursion_mean FPR_Bound_mean FNR_Bound_mean

%clear all;
print_diagram();