function finalstring = recognize(S)
    Sgray = rgb2gray(S);
    Sbin = imbinarize(Sgray);
    a=imcomplement(Sbin);
    st = regionprops(a, 'BoundingBox' );
    rectangle('Position',[st(1).BoundingBox(1),st(1).BoundingBox(2),st(1).BoundingBox(3),st(1).BoundingBox(4)],...
    'EdgeColor','r','LineWidth',2 )
    croppedImage = imcrop(a, [st(1).BoundingBox(1),st(1).BoundingBox(2),st(1).BoundingBox(3),st(1).BoundingBox(4)]);
    K = imresize(croppedImage,[60 40]);
    c = regionprops(K,'centroid');
    centroids = cat(1, c.Centroid);
    imshow(K)
    hold on
    plot(centroids(1),centroids(2), 'r*');
    horizontal=[];
    vertical=[];
    
    %For Finding area and Storing them with respective coordinates%
    for j=1:59
        temp = [];
        for i=1:40
            if K(j, i) == 1
                temp = [temp; i];
            end
        end
        minimum = min(temp);
        maximum = max(temp);
        x = [minimum, maximum, centroids(1)];
        y = [j, j, centroids(2)];
        area = polyarea(x,y);
        horizontal = [horizontal; j, minimum, maximum, area];
    end
    for i=1:39
        temp = [];
        for j=1:60
            if K(j, i) == 1
                temp = [temp; j];
            end
        end
        minimum = min(temp);
        maximum = max(temp);
        x = [i, i, centroids(1)];
        y = [minimum, maximum, centroids(2)];
        area = polyarea(x, y);
        vertical = [vertical; i, minimum, maximum, area];
    end
    arradata=[];
    finald=[];
    for lines = 1:(60+40-1)
        startcol = max(1, lines-60);
        tcount = min(lines, 60);
        count = min(tcount, 40-startcol);
        for q=1:count
            abc = real(min(60, lines)-q-1);
            cde = real(startcol+q);
            if (abc > 0 ) && (cde > 0)
                if K(abc, cde) == 1
                    arradata = [arradata; cde, abc];
                end
            end
        end
        sizes = size(arradata);
        if sizes ~= 0
            if(arradata(1,:) ~= arradata(sizes(1),:))
                finald = [finald; arradata(1,1), arradata(1,2), arradata(sizes(1),1), arradata(sizes(1),2)];
            end
        end
        arradata=[];
    end
    darea = [];
    for i=1:size(finald)
        x = [finald(i,1), finald(i,3), centroids(1)];
        y = [finald(i,2), finald(i,4), centroids(2)];
        area = polyarea(x, y);
        darea = [darea; area];
    end
    
    %For Normalising the Area Values%
    hmax = max(horizontal(:,4));
    vmax = max(vertical(:,4));
    dmax = max(darea);
    horizontalnor=[];
    verticalnor=[];
    dnor=[];
    for i=1:size(horizontal)
        norvalue = horizontal(i,4)/hmax;
        horizontalnor = [horizontalnor; norvalue];
    end
    for i=1:size(vertical)
        norvalue = vertical(i,4)/vmax;
        verticalnor = [verticalnor; norvalue];
    end
    for i=1:size(darea)
        norvalue = darea(i,1)/dmax;
        dnor = [dnor; norvalue];
    end
    
    %For Assigning Unique characters to Each Normalised Value%
    for i=1:size(horizontalnor)
        if(horizontalnor(i,1)>=0.0 && horizontalnor(i,1)<=0.1)
            asschar = 'A';
        elseif(horizontalnor(i,1)>=0.1 && horizontalnor(i,1)<=0.2)
            asschar = 'B';
        elseif(horizontalnor(i,1)>=0.2 && horizontalnor(i,1)<=0.3)
            asschar = 'C';
        elseif(horizontalnor(i,1)>=0.3 && horizontalnor(i,1)<=0.4)
            asschar = 'D';
        elseif(horizontalnor(i,1)>=0.4 && horizontalnor(i,1)<=0.40)
            asschar = 'E';
        elseif(horizontalnor(i,1)>=0.40 && horizontalnor(i,1)<=0.6)
            asschar = 'F';
        elseif(horizontalnor(i,1)>=0.6 && horizontalnor(i,1)<=0.7)
            asschar = 'G';
        elseif(horizontalnor(i,1)>=0.7 && horizontalnor(i,1)<=0.8)
            asschar = 'H';
        elseif(horizontalnor(i,1)>=0.8 && horizontalnor(i,1)<=0.9)
            asschar = 'I';
        elseif(horizontalnor(i,1)>=0.9 && horizontalnor(i,1)<=1.0)
            asschar = 'J';
        end
        horizontalnor(i,2) = asschar;
    end
    for i=1:size(verticalnor)
        if(verticalnor(i,1)>=0.0 && verticalnor(i,1)<=0.1)
            asschar = 'A';
        elseif(verticalnor(i,1)>=0.1 && verticalnor(i,1)<=0.2)
            asschar = 'B';
        elseif(verticalnor(i,1)>=0.2 && verticalnor(i,1)<=0.3)
            asschar = 'C';
        elseif(verticalnor(i,1)>=0.3 && verticalnor(i,1)<=0.4)
            asschar = 'D';
        elseif(verticalnor(i,1)>=0.4 && verticalnor(i,1)<=0.40)
            asschar = 'E';
        elseif(verticalnor(i,1)>=0.40 && verticalnor(i,1)<=0.6)
            asschar = 'F';
        elseif(verticalnor(i,1)>=0.6 && verticalnor(i,1)<=0.7)
            asschar = 'G';
        elseif(verticalnor(i,1)>=0.7 && verticalnor(i,1)<=0.8)
            asschar = 'H';
        elseif(verticalnor(i,1)>=0.8 && verticalnor(i,1)<=0.9)
            asschar = 'I';
        elseif(verticalnor(i,1)>=0.9 && verticalnor(i,1)<=1.0)
            asschar = 'J';
        end
        verticalnor(i,2) = asschar;
    end
    for i=1:size(dnor)
        if(dnor(i,1)>=0.0 && dnor(i,1)<=0.1)
            asschar = 'A';
        elseif(dnor(i,1)>=0.1 && dnor(i,1)<=0.2)
            asschar = 'B';
        elseif(dnor(i,1)>=0.2 && dnor(i,1)<=0.3)
            asschar = 'C';
        elseif(dnor(i,1)>=0.3 && dnor(i,1)<=0.4)
                asschar = 'D';
        elseif(dnor(i,1)>=0.4 && dnor(i,1)<=0.40)
            asschar = 'E';
        elseif(dnor(i,1)>=0.40 && dnor(i,1)<=0.6)
            asschar = 'F';
        elseif(dnor(i,1)>=0.6 && dnor(i,1)<=0.7)
            asschar = 'G';
        elseif(dnor(i,1)>=0.7 && dnor(i,1)<=0.8)
            asschar = 'H';
        elseif(dnor(i,1)>=0.8 && dnor(i,1)<=0.9)
            asschar = 'I';
        elseif(dnor(i,1)>=0.9 && dnor(i,1)<=1.0)
            asschar = 'J';
        end
        dnor(i,2) = asschar;
    end
    hstring = "";
    vstring = "";
    dstring = "";
    
    %For Converting Stored ASCII Values to Characters and then to String%
    for i=1:size(horizontalnor)
        temp = char(horizontalnor(i,2));
        hstring = hstring+temp;
    end
    for i=1:size(verticalnor)
        temp = char(verticalnor(i,2));
        vstring = vstring+temp;
    end
    for i=1:size(dnor)
        temp = char(dnor(i,2));
        dstring = dstring+temp;
    end
    %for x = 1:size(vertical)
    %   plot([vertical(x,1) vertical(x,1)],[vertical(x,2) vertical(x,3)])
    %   plot([vertical(x,1) centroids(1)],[vertical(x,2) centroids(2)])
    %   plot([vertical(x,1) centroids(1)],[vertical(x,3) centroids(2)])
    %    
    %end
    %for x = 1:size(horizontal)
    %    plot([horizontal(x,2) horizontal(x,3)],[horizontal(x,1) horizontal(x,1)])
    %    plot([horizontal(x,2) centroids(1)],[horizontal(x,1) centroids(2)])
    %    plot([horizontal(x,3) centroids(1)],[horizontal(x,1) centroids(2)])
    %end
    finalstring = hstring+vstring+dstring;
end