varia = 'Acolor.png';
variii = 'Images/' + varia ;

srcFiles = dir('E:\New Folder\*.tif');  % the folder in which ur images exists
for i = 1 : length(srcFiles)
    filename = strcat('E:\New Folder\',srcFiles(i).name);
    I = imread(filename);
    figure, imshow(I);
end

for i = 1 : length(srcFiles)
    filename = strcat('Images\',srcFiles(i).name);
    I = imread(filename);
    figure, imshow(I);
    prompt = 'Do you want more? Y/N [Y]: ';
    str = input(prompt,'s');
    fprintf("the image is "+str);
end