disp('R. Recognition');
disp('T. Training');
prompt = 'Select your Choice [R/T] : ';
choice = input(prompt,'s');
if (choice == 'R')
    recogdata = {};
    resul="";
    I = imread('Acolor.png');
    recognisation = recognize(I);
    fid = fopen('data.dat','r');
    formatSpec = '%s %s \n';
    exam = textscan(fid,formatSpec);
    for i=1:size(exam{2})
        comparestring = exam{2}{i};
        D = EditDistance(comparestring,recognisation{1});
        recogdata = [recogdata; {D, i}];
    end
    minvalue = min([recogdata{:,1}]);
    for j=1:size(recogdata)
        if recogdata{j,1} == minvalue
            result = recogdata{j,2};
        end
    end
    disp('Character Identified is:');
    disp(exam{1}{result})
elseif (choice == 'T')
    train();
end
    
    