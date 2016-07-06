function num=DoNotFind(main,other)
flag=1;
num=0;
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