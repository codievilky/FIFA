%对于一个数组primary，只保留其中的前Need个数组
function wantage=CutEnd(Primary,Need)
All=numel(Primary);
a=eye(Need);
b=zeros(Need,All-Need);
c=[a b]';
wantage=Primary*c;