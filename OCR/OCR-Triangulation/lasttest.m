recogdata = {};
resul="";
I = imread('image14.jpg');
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
disp('Output :');
disp(exam{1}{result})
    
    