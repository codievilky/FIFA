function Name=Initial()
Size_Grid=10;  %�����С����λ��m
Room_Length=Size_Grid; %���䳤��
Room_Width=Size_Grid;  %������
RUNS = 10; %%�������
Sequence_Number=10; %%ÿ�η�����ʹ�õ�����
scale=5;        %%%%%%%%%%%%%%%%%%%%%%%%%%%%�ɱ������GM�㷨�Ŀռ���ɢ������
Microphone_Distance=0.2; %�ֻ�������mic֮�����
measure_alpha=0.75;     %%%�и����
percent             = 0.95;      %���㶨λ���ʱ��ֻȡǰ90%���������10%
KNN=4;  %% Basic Hamming parameter ��Hamming������С��KNN����ȡƽ��
location_error_range_abs = 0.05;         %%%%%%%%%%%%%%%%%%%%�ڵ�λ����Χ,��λm
angle_error_range_abs = 5;            %%%%%%%%%%%%%%%%%%%�ڵ�Ƕ���Χ,��λ�Ƕ�
Node_Error_NUM_Percent=0.1; %%%%%%%%%%%%%%%%%%%�ڵ�������Ϣ����İٷֱ�
real_statics_run=floor(RUNS*percent);
anchor_min=100;   %��С�ڵ����
anchor_max=100;  %���
anchor_gap=10;   %���
anchors=anchor_min:anchor_gap:anchor_max ;%%%%%%%%%%%%%%%%%%%%%%%%%%�ɱ������ʵ����ʹ�õĽ�����
Node_Number=100;

Node_Error_NUM=floor(Node_Error_NUM_Percent*Node_Number);

save data.mat Size_Grid Room_Length Room_Width RUNS Sequence_Number scale Microphone_Distance ...
    measure_alpha percent KNN location_error_range_abs angle_error_range_abs Node_Error_NUM_Percent ...
    real_statics_run anchor_min anchor_max anchor_gap anchors Node_Number Node_Error_NUM 
Name='data.mat';