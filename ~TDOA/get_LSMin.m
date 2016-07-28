function [ bound ] = get_LSMin( hist_array )
%get the longest succession minimum bound
circulation = length(hist_array);
this = [ 0 0 0 ];
number = [ max(hist_array)+1 0 0 ];
i = 1;
while i <= circulation
    this(1) = hist_array(i);
    this(2) = 1;
    this(3) = i;
    if i ~= circulation && hist_array(i) == hist_array(i + 1)
        while i ~= circulation && hist_array(i) == hist_array(i + 1)
            this(2) = this(2) + 1;
            i = i + 1;
        end
        i =i - 1;
    end
    if this(1) <= number(1) && this(2) >= number(2)
        number(1) = this(1);
        number(2) = this(2);
        number(3) = this(3);
    end
    i = i + 1;
end

bound = number(3);
end

