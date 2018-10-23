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
rowwise=[];
columnwise=[];
left=[];
right=[];
top=[];
bottom=[];
%To get pixel values whose values are equal to 1%
for j=1:60
    for i=1:40
        if K(j, i) == 1
            rowwise = [rowwise; j, i, sqrt(( ((centroids(1)-i) * (centroids(1)-i)) + ((centroids(2)-j) * (centroids(2)-j)) ))];
        end
    end
end
for i=1:40
    for j=1:60
        if K(j, i) == 1
            columnwise = [columnwise; j, i];
        end
    end
end
% For Dividing the image into 4 parts Left, Right, Top, Bottom%
for j=1:60
    for i=1:40/2
        if K(j, i) == 1
            left = [left; j, i, sqrt(( ((centroids(1)-i) * (centroids(1)-i)) + ((centroids(2)-j) * (centroids(2)-j)) ))];
        end
    end
end
for j=1:60
    for i=21:40
        if K(j, i) == 1
            right = [right; j, i, sqrt(( ((centroids(1)-i) * (centroids(1)-i)) + ((centroids(2)-j) * (centroids(2)-j)) ))];
        end
    end
end
for i=1:40
    for j=1:60/2
        if K(j, i) == 1
            top = [top; j, i, sqrt(( ((centroids(1)-i) * (centroids(1)-i)) + ((centroids(2)-j) * (centroids(2)-j)) ))];
        end
    end
end
for i=1:40
    for j=31:60
        if K(j, i) == 1
            bottom = [bottom; j, i, sqrt(( ((centroids(1)-i) * (centroids(1)-i)) + ((centroids(2)-j) * (centroids(2)-j)) ))];
        end
    end
end
for i=1:size(rowwise)
    plot([rowwise(i,2) centroids(1)],[rowwise(i,1) centroids(2)]);
end
%For Normalisation%
for i=1:size(left)
    val = left(i,3)/(max(left(:,3)));
    left(i,4) = val;
end
for i=1:size(right)
    val = right(i,3)/(max(right(:,3)));
    right(i,4) = val;
end
for i=1:size(top)
    val = top(i,3)/(max(top(:,3)));
    top(i,4) = val;
end
for i=1:size(bottom)
    val = bottom(i,3)/(max(bottom(:,3)));
    bottom(i,4) = val;
end
%Assigning chars to Normalized values%
for i=1:size(left)
    if(left(i,4)>=0.0 && left(i,4)<=0.1)
        asschar = 'A';
    elseif(left(i,4)>=0.1 && left(i,4)<=0.2)
        asschar = 'B';
        elseif(left(i,4)>=0.2 && left(i,4)<=0.3)
        asschar = 'C';
        elseif(left(i,4)>=0.3 && left(i,4)<=0.4)
        asschar = 'D';
        elseif(left(i,4)>=0.4 && left(i,4)<=0.40)
        asschar = 'E';
        elseif(left(i,4)>=0.40 && left(i,4)<=0.6)
        asschar = 'F';
        elseif(left(i,4)>=0.6 && left(i,4)<=0.7)
        asschar = 'G';
        elseif(left(i,4)>=0.7 && left(i,4)<=0.8)
        asschar = 'H';
    elseif(left(i,4)>=0.8 && left(i,4)<=0.9)
        asschar = 'I';
        elseif(left(i,4)>=0.9 && left(i,4)<=1.0)
        asschar = 'J';
        end
    left(i,40) = asschar;
end
for i=1:size(right)
    if(right(i,4)>=0.0 && right(i,4)<=0.1)
        asschar = 'A';
    elseif(right(i,4)>=0.1 && right(i,4)<=0.2)
        asschar = 'B';
        elseif(right(i,4)>=0.2 && right(i,4)<=0.3)
        asschar = 'C';
        elseif(right(i,4)>=0.3 && right(i,4)<=0.4)
        asschar = 'D';
        elseif(right(i,4)>=0.4 && right(i,4)<=0.40)
        asschar = 'E';
        elseif(right(i,4)>=0.40 && right(i,4)<=0.6)
        asschar = 'F';
        elseif(right(i,4)>=0.6 && right(i,4)<=0.7)
        asschar = 'G';
        elseif(right(i,4)>=0.7 && right(i,4)<=0.8)
        asschar = 'H';
    elseif(right(i,4)>=0.8 && right(i,4)<=0.9)
        asschar = 'I';
        elseif(right(i,4)>=0.9 && right(i,4)<=1.0)
        asschar = 'J';
        end
    right(i,40) = asschar;
end
for i=1:size(top)
    if(top(i,4)>=0.0 && top(i,4)<=0.1)
        asschar = 'A';
    elseif(top(i,4)>=0.1 && top(i,4)<=0.2)
        asschar = 'B';
        elseif(top(i,4)>=0.2 && top(i,4)<=0.3)
        asschar = 'C';
        elseif(top(i,4)>=0.3 && top(i,4)<=0.4)
        asschar = 'D';
        elseif(top(i,4)>=0.4 && top(i,4)<=0.40)
        asschar = 'E';
        elseif(top(i,4)>=0.40 && top(i,4)<=0.6)
        asschar = 'F';
        elseif(top(i,4)>=0.6 && top(i,4)<=0.7)
        asschar = 'G';
        elseif(top(i,4)>=0.7 && top(i,4)<=0.8)
        asschar = 'H';
    elseif(top(i,4)>=0.8 && top(i,4)<=0.9)
        asschar = 'I';
        elseif(top(i,4)>=0.9 && top(i,4)<=1.0)
        asschar = 'J';
        end
    top(i,40) = asschar;
end
for i=1:size(bottom)
    if(bottom(i,4)>=0.0 && bottom(i,4)<=0.1)
        asschar = 'A';
    elseif(bottom(i,4)>=0.1 && bottom(i,4)<=0.2)
        asschar = 'B';
        elseif(bottom(i,4)>=0.2 && bottom(i,4)<=0.3)
        asschar = 'C';
        elseif(bottom(i,4)>=0.3 && bottom(i,4)<=0.4)
        asschar = 'D';
        elseif(bottom(i,4)>=0.4 && bottom(i,4)<=0.40)
        asschar = 'E';
        elseif(bottom(i,4)>=0.40 && bottom(i,4)<=0.6)
        asschar = 'F';
        elseif(bottom(i,4)>=0.6 && bottom(i,4)<=0.7)
        asschar = 'G';
        elseif(bottom(i,4)>=0.7 && bottom(i,4)<=0.8)
        asschar = 'H';
    elseif(bottom(i,4)>=0.8 && bottom(i,4)<=0.9)
        asschar = 'I';
        elseif(bottom(i,4)>=0.9 && bottom(i,4)<=1.0)
        asschar = 'J';
        end
    bottom(i,40) = asschar;
end

%building string with the normalized characters%
leftstring = "";
rightstring = "";
topstring = "";
bottomstring = "";
for i=1:size(left)
    temp = char(left(i,40));
    leftstring = leftstring+temp;
end
for i=1:size(right)
    temp = char(right(i,40));
    rightstring = rightstring+temp;
end
for i=1:size(top)
    temp = char(top(i,40));
    topstring = topstring+temp;
end
for i=1:size(bottom)
    temp = char(bottom(i,40));
    bottomstring = bottomstring+temp;
end
finalstring = leftstring+rightstring+topstring+bottomstring;
end