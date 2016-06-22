%通过TDOA来计算是否出错的方法
%2015.11.17
function Error_Node=Calculate_Error(TDOA,Error_Number)
Number=numel(TDOA);
rand(1,Number);
percent=transfer(0.5,1,max(TDOA),TDOA,1);
Error_Node=zeros(1,Number);
count=0;
for i=1:Number
    if rand(i)<percent
        count=count+1;
        Error_Number(count)=i;
    end
end
Error_Node=CutEnd(Error_Node,count);
