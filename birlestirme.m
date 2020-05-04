clear all;
load('10foldcvsonuclar.mat');
load('testing_y1.mat');
cvfold=10;
avg_uni_rf=sum(acc_uni_rf)/cvfold;
avg_uni_svm=sum(acc_uni_svm)/cvfold;
avg_bi_rf=sum(acc_bi_rf)/cvfold;
avg_bi_svm=sum(acc_bi_svm)/cvfold;
avg_type_rf=sum(acc_type_rf)/cvfold;
avg_type_svm=sum(acc_type_svm)/cvfold;

% dizin='C:\Users\Melike Nur Mermer\Desktop\Doðal Dil Ýþleme\2siniflifeaturesets\kokler.arff';
% [~,~,~,testing_y1]=sadecerf(dizin, 1);
% voting rule
for i=1:cvfold
    [~,votes_uni_rf]=max(score_uni_rf{i},[],2);
    [~,votes_uni_svm]=max(score_uni_svm{i},[],2);
    [~,votes_bi_rf]=max(score_bi_rf{i},[],2);
    [~,votes_bi_svm]=max(score_bi_svm{i},[],2);
    [~,votes_type_rf]=max(score_type_rf{i},[],2);
    [~,votes_type_svm]=max(score_type_svm{i},[],2);
    
    ornsay=size(votes_uni_rf,1);
    ortak_oylar=zeros(size(votes_uni_rf,1),2);
    ortak_oylar_agr=zeros(size(votes_uni_rf,1),2);
    for j=1:ornsay
        %voting - rf+svm
        ortak_oylar(j,votes_uni_rf(j))=ortak_oylar(j,votes_uni_rf(j))+1;
        ortak_oylar(j,votes_uni_svm(j))=ortak_oylar(j,votes_uni_svm(j))+1;
        ortak_oylar(j,votes_bi_rf(j))=ortak_oylar(j,votes_bi_rf(j))+1;
        ortak_oylar(j,votes_bi_svm(j))=ortak_oylar(j,votes_bi_svm(j))+1;
        ortak_oylar(j,votes_type_rf(j))=ortak_oylar(j,votes_type_rf(j))+1;
        ortak_oylar(j,votes_type_svm(j))=ortak_oylar(j,votes_type_svm(j))+1;

        %%weighted voting - rf+svm
        ortak_oylar_agr(j,votes_uni_rf(j))=ortak_oylar(j,votes_uni_rf(j))+2;
        ortak_oylar_agr(j,votes_uni_svm(j))=ortak_oylar(j,votes_uni_svm(j))+2;
        ortak_oylar_agr(j,votes_bi_rf(j))=ortak_oylar(j,votes_bi_rf(j))+2;
        ortak_oylar_agr(j,votes_bi_svm(j))=ortak_oylar(j,votes_bi_svm(j))+2;
        ortak_oylar_agr(j,votes_type_rf(j))=ortak_oylar(j,votes_type_rf(j))+3;
        ortak_oylar_agr(j,votes_type_svm(j))=ortak_oylar(j,votes_type_svm(j))+2;

        %%weighted voting - rf
%         ortak_oylar_agr(j,votes_uni_rf(j))=ortak_oylar(j,votes_uni_rf(j))+2;
%         ortak_oylar_agr(j,votes_bi_rf(j))=ortak_oylar(j,votes_bi_rf(j))+2;
%         ortak_oylar_agr(j,votes_type_rf(j))=ortak_oylar(j,votes_type_rf(j))+1;
        
        %%weighted voting - svm
%         ortak_oylar_agr(j,votes_uni_svm(j))=ortak_oylar(j,votes_uni_svm(j))+1;
%         ortak_oylar_agr(j,votes_bi_svm(j))=ortak_oylar(j,votes_bi_svm(j))+2;
%         ortak_oylar_agr(j,votes_type_svm(j))=ortak_oylar(j,votes_type_svm(j))+1;
    end
    
    [~,vote_karar]=max(ortak_oylar,[],2);
    [~,vote_karar_agr]=max(ortak_oylar_agr,[],2);
    
    %sum - rf+svm
    ortak_score=score_uni_rf{i}+score_uni_svm{i}+score_bi_rf{i}+score_bi_svm{i}+score_type_rf{i}+score_type_svm{i};
      
        %%tek çeþit sýnýflandýrýcýlý topluluklar için sum rule
%     ortak_score=score_uni_svm{i}+score_bi_svm{i}+score_type_svm{i};

    [~,sum_karar]=max(ortak_score,[],2);

    %weighted sum - rf+svm
      ortak_score_agr=score_uni_rf{i}.*3.5+score_uni_svm{i}.*3.3+score_bi_rf{i}.*0.5+score_bi_svm{i}.*3+score_type_rf{i}.*0.3+score_type_svm{i}.*0.1;
    
    %%weighted sum - rf
%     ortak_score_agr=score_uni_rf{i}.*3+score_bi_rf{i}.*0.5+score_type_rf{i}.*0.3;
    
    %%weighted sum - svm
%     ortak_score_agr=score_uni_svm{i}.*3+score_bi_svm{i}.*3+score_type_svm{i}.*0.1;
    
    [~,sum_karar_agr]=max(ortak_score_agr,[],2);
    
    testing_y=testing_y1{i};
    basarili_vote_karar=0;
    basarili_vote_karar_agr=0;
    basarili_sum_karar=0;
    basarili_sum_karar_agr=0;
    
    [nofsample,noffeature]=size(testing_y);
        for t=1:nofsample
            if vote_karar(t)==testing_y(t);
            basarili_vote_karar=basarili_vote_karar+1;
            end
            if vote_karar_agr(t)==testing_y(t);
            basarili_vote_karar_agr=basarili_vote_karar_agr+1;
            end
            if sum_karar(t)==testing_y(t);
            basarili_sum_karar=basarili_sum_karar+1;
            end 
            if sum_karar_agr(t)==testing_y(t);
            basarili_sum_karar_agr=basarili_sum_karar_agr+1;
            end 
        end
        
    acc_vote_karar(i)=100*basarili_vote_karar/nofsample;
    acc_vote_karar_agr(i)=100*basarili_vote_karar_agr/nofsample;
    acc_sum_karar(i)=100*basarili_sum_karar/nofsample;
    acc_sum_karar_agr(i)=100*basarili_sum_karar_agr/nofsample;    
end
avg_vote_karar=sum(acc_vote_karar)/cvfold;
avg_vote_karar_agr=sum(acc_vote_karar_agr)/cvfold;
avg_sum_karar=sum(acc_sum_karar)/cvfold;
avg_sum_karar_agr=sum(acc_sum_karar_agr)/cvfold;



