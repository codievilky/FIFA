%使用方程为y=asin(cx)+b
%其中min为希望权值的最大值
%max为希望权值最小值，max_room是可以能的最大距离
%distance是所求节点与声源之间的距离
%weight是最终输出应该的权值
%shift表示所求 权值是随着距离增加还是减少，增加的话shift为1，减少的话shift为-1
function weight=transfer(min,max,max_room,distance,shift)
b=min;
a=max-b;
c=pi/(2*max_room);
if shift==-1
    weight=a*sin(pi/2+c*distance)+b;
elseif shift==1
    weight=a*sin(c*distance)+b;
end