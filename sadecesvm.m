% clear all;
% dizin='C:\Users\Melike Nur Mermer\Desktop\Doðal Dil Ýþleme\2siniflifeaturesets\type.arff';
% val=1;
function [acc_svm,scorelar,avgval_svm]=sadecesvm(dizin, val)
rng(1);
[x,y]=arffoku(dizin);
[ornek, ~]=size(x);
cvfold=10;
[eorn,torn]=crossval(ornek,cvfold);
for n=1:cvfold
edata=eorn{1,n};
tdata=torn{1,n};

[training_x,training_y,testing_x,testing_y]=egitimtestsetleri(edata,tdata,x,y);
train_ornek=training_x(1:round((cvfold-2)*size(edata,2)/(cvfold-1)),:);
train_ornek_y=training_y(1:round((cvfold-2)*size(edata,2)/(cvfold-1)),:);
val_ornek=training_x(round(((cvfold-2)*size(edata,2))/(cvfold-1))+1:size(edata,2),:);
val_ornek_y=training_y(round(((cvfold-2)*size(edata,2))/(cvfold-1))+1:size(edata,2),:);

if val==0
    model_svm = fitcsvm(training_x,training_y);
    accval_svm(n)=0;
else if val==1
    model_svm1 = fitcsvm(train_ornek,train_ornek_y);
    model_svm = fitSVMPosterior(model_svm1);
    [tahminval_svm,~]=predict(model_svm,val_ornek);
    basarilival_svm=0;
    [nofsample,~]=size(val_ornek);
        for i=1:nofsample
        if tahminval_svm(i)==val_ornek_y(i);
        basarilival_svm=basarilival_svm+1;
        end
        end
    accval_svm(n)=100*basarilival_svm/nofsample;
end
end
    
[tahmin_svm,scorelar{n}]=predict(model_svm,testing_x);
basarili_svm=0;
[nofsample,noffeature]=size(testing_x);
for i=1:nofsample
    if tahmin_svm(i)==testing_y(i);
    basarili_svm=basarili_svm+1;
    end
end
acc_svm(n)=100*basarili_svm/nofsample;
end
avgval_svm=sum(accval_svm)/(100*cvfold);
avg_svm=sum(acc_svm)/(cvfold);



