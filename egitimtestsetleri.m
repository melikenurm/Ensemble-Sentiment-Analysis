function [training_x,training_y,testing_x,testing_y]=egitimtestsetleri(edata,tdata,x,y)
[~,feature]=size(x);
eornsay=length(edata);
tornsay=length(tdata);
training_x=zeros(eornsay,feature);
training_y=zeros(eornsay,1);
testing_x=zeros(tornsay,feature);
testing_y=zeros(tornsay,1);
%eğitim ve test setlerinin oluşturulması
    for i=1:eornsay
        training_x(i,:)=x(edata(i),:);
        training_y(i,1)=y(edata(i),1);   
    end
    for i=1:tornsay
        testing_x(i,:)=x(tdata(i),:);
        testing_y(i,1)=y(tdata(i),1);      
    end