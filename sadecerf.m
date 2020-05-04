% clear all;
% dizin='C:\Users\Melike Nur Mermer\Desktop\Doðal Dil Ýþleme\2siniflifeaturesets\kokler.arff';
% val=1;
function [acc_rf,scorelar,avgval_rf,testing_y1]=sadecerf(dizin, val)
rng(1);
[x,y]=arffoku(dizin);
[ornek, ozellik]=size(x);
cvfold=10;
[eorn,torn]=crossval(ornek,cvfold);
for n=1:cvfold
edata=eorn{1,n};
tdata=torn{1,n};

[training_x,training_y,testing_x,testing_y]=egitimtestsetleri(edata,tdata,x,y);
testing_y1{n}=testing_y;
train_ornek=training_x(1:round((cvfold-2)*size(edata,2)/(cvfold-1)),:);
train_ornek_y=training_y(1:round((cvfold-2)*size(edata,2)/(cvfold-1)),:);
val_ornek=training_x(round(((cvfold-2)*size(edata,2))/(cvfold-1))+1:size(edata,2),:);
val_ornek_y=training_y(round(((cvfold-2)*size(edata,2))/(cvfold-1))+1:size(edata,2),:);

if val==0
    model_rf = TreeBagger(100,training_x,training_y);
    accval_rf(n)=0;
else if val==1
    model_rf = TreeBagger(100,train_ornek,train_ornek_y);
    [tahminval_rf,~]=predict(model_rf,val_ornek);
    tahminval_rf=str2double(tahminval_rf);
    basarilival_rf=0;
    [nofsample,~]=size(val_ornek);
        for i=1:nofsample
        if tahminval_rf(i)==val_ornek_y(i);
        basarilival_rf=basarilival_rf+1;
        end
        end
    accval_rf(n)=100*basarilival_rf/nofsample;
end
end
    
[tahmin_rf1,score]=predict(model_rf,testing_x);
tahmin_rf=str2double(tahmin_rf1);
scorelar{n}=score;
basarili_rf=0;
[nofsample,noffeature]=size(testing_x);
for i=1:nofsample
    if tahmin_rf(i)==testing_y(i);
    basarili_rf=basarili_rf+1;
    end
end
acc_rf(n)=100*basarili_rf/nofsample;
end
avgval_rf=sum(accval_rf)/(100*cvfold);
avg_rf=sum(acc_rf)/(cvfold);
% % save('rf_'tahmin_rf)


