%ʹ�÷���Ϊy=asin(c(x-d))+b
%����minΪϣ��Ȩֵ�����ֵ
%maxΪϣ��Ȩֵ��Сֵ��
%min_room�ǿ��ܵ���С���룬max_room�ǿ����ܵ�������
%distance������ڵ�����Դ֮��ľ���
%weight���������Ӧ�õ�Ȩֵ
%shift��ʾ���� Ȩֵ�����ž������ӻ��Ǽ��٣����ӵĻ�shiftΪ1�����ٵĻ�shiftΪ-1
function weight=transfer(min,max,min_room,max_room,distance,shift)
b=min;
a=max-b;
d=min_room;
c=pi/(2*(max_room-d));
if shift==-1
    weight=a*sin(pi/2+c*(distance-d))+b;
elseif shift==1
    weight=a*sin(c*(distance-d))+b;
end