%����һ������primary��ֻ�������е�ǰNeed������
function wantage=CutEnd(Primary,Need)
All=numel(Primary);
a=eye(Need);
b=zeros(Need,All-Need);
c=[a b]';
wantage=Primary*c;