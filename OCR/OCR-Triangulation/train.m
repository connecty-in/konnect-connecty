function training = train()
    featuredata = {};
    srcFiles = dir('test\*.jpg');  % the folder in which ur images exists
    for i = 1 : length(srcFiles)
        filename = strcat('test\',srcFiles(i).name);
        S = imread(filename);
        figure, imshow(S);
        prompt = 'Enter the value of Image: ';
        Imagevalue = input(prompt,'s');
        recognisation = recognize(S);
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