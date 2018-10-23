function training = train()
    featuredata = {};
    srcFiles = dir('test\*.jpg');  % the folder in which ur images exists
    for i = 1 : length(srcFiles)
        filename = strcat('test\',srcFiles(i).name);
        I = imread(filename);
        figure, imshow(I);
        prompt = 'Enter the value of Image: ';
        Imagevalue = input(prompt,'s');
        recognisation = recognize(I);
        featuredata = [featuredata; {Imagevalue, recognisation}];
    end
    fileID = fopen('data.dat','w');
    featuredata
    formatSpec = '%s %s \n';
    [nrows,ncols] = size(featuredata);
    for i = 1:size(featuredata)
        fprintf(fileID,formatSpec,featuredata{i,:});
    end
end