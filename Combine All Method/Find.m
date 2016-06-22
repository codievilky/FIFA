function num=Find(main,other)
num=0;
for i=other(1:end)
    for j=main(1:end)
        if i==j
            num=num+1;
            break;
        end
    end
end