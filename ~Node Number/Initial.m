function Name=Initial()
Size_Grid=10;  %房间大小，单位：m
Room_Length=Size_Grid; %房间长度
Room_Width=Size_Grid;  %房间宽度
RUNS = 10; %%仿真次数
Sequence_Number=10; %%每次仿真所使用的序列
scale=5;        %%%%%%%%%%%%%%%%%%%%%%%%%%%%可变参数，GM算法的空间离散化步长
Microphone_Distance=0.2; %手机上两个mic之间距离
measure_alpha=0.75;     %%%切割概率
percent             = 0.95;      %计算定位误差时，只取前90%，舍掉最大的10%
KNN=4;  %% Basic Hamming parameter ，Hamming距离最小的KNN个点取平均
location_error_range_abs = 0.05;         %%%%%%%%%%%%%%%%%%%%节点位置误差范围,单位m
angle_error_range_abs = 5;            %%%%%%%%%%%%%%%%%%%节点角度误差范围,单位角度
Node_Error_NUM_Percent=0.1; %%%%%%%%%%%%%%%%%%%节点量测信息出错的百分比
real_statics_run=floor(RUNS*percent);
anchor_min=100;   %最小节点个数
anchor_max=100;  %最大
anchor_gap=10;   %间隔
anchors=anchor_min:anchor_gap:anchor_max ;%%%%%%%%%%%%%%%%%%%%%%%%%%可变参数，实验所使用的结点个数
Node_Number=100;

Node_Error_NUM=floor(Node_Error_NUM_Percent*Node_Number);

save data.mat Size_Grid Room_Length Room_Width RUNS Sequence_Number scale Microphone_Distance ...
    measure_alpha percent KNN location_error_range_abs angle_error_range_abs Node_Error_NUM_Percent ...
    real_statics_run anchor_min anchor_max anchor_gap anchors Node_Number Node_Error_NUM 
Name='data.mat';