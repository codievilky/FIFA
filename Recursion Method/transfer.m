%ʹ�÷���Ϊy=asin(cx)+b
%����minΪϣ��Ȩֵ�����ֵ
%maxΪϣ��Ȩֵ��Сֵ��max_room�ǿ����ܵ�������
%distance������ڵ�����Դ֮��ľ���
%weight���������Ӧ�õ�Ȩֵ
%shift��ʾ���� Ȩֵ�����ž������ӻ��Ǽ��٣����ӵĻ�shiftΪ1�����ٵĻ�shiftΪ-1
function weight=transfer(min,max,max_room,distance,shift)
b=min;
a=max-b;
c=pi/(2*max_room);
if shift==-1
    weight=a*sin(pi/2+c*distance)+b;
elseif shift==1
    weight=a*sin(c*distance)+b;
end