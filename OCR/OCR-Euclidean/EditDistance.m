function D = Edit_Distance(s, t)
    
    s_size = length(s);
    t_size = length(t);

    E = zeros(s_size+1,t_size+1);

    for i=1:s_size+1
        E(i,1) = i-1;
    end

    for j=1:t_size+1
        E(1,j) = j-1;
    end

    for i=2:s_size+1
        for j=2:t_size+1
            if s(i-1) == t(j-1)
                E(i,j) = E(i-1,j-1);
            else
                E(i,j) = min(E(i-1,j-1)+1, min(E(i-1,j)+1, E(i,j-1)+1));
            end
        end
    end

    %disp('Edit Distance:');
    %disp(E(s_size+1,t_size+1));
    D = E(s_size+1, t_size+1);
end