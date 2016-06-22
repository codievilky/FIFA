function result=wubao(main,other)
num=0;
flag=1;
for i=main(1:end)
    for j=other(1:end)
        if i==j
            flag=0;
        end
    end
    if flag==1
        num=num+1;
    else
        flag=1;
    end
end
result=num/length(main);