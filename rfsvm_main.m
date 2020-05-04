clear all;
rng(1);
dizin_uni='C:\Users\Melike Nur Mermer\Desktop\Doðal Dil Ýþleme\2siniflifeaturesets\kokler.arff';
dizin_bi='C:\Users\Melike Nur Mermer\Desktop\Doðal Dil Ýþleme\2siniflifeaturesets\word2gram.arff';
dizin_type='C:\Users\Melike Nur Mermer\Desktop\Doðal Dil Ýþleme\2siniflifeaturesets\type.arff';

[acc_uni_rf,score_uni_rf,avgval_uni_rf]=sadecerf(dizin_uni,1);
[acc_uni_svm,score_uni_svm,avgval_uni_svm]=sadecesvm(dizin_uni,1);
[acc_bi_rf,score_bi_rf,avgval_bi_rf]=sadecerf(dizin_bi,1);
[acc_bi_svm,score_bi_svm,avgval_bi_svm]=sadecesvm(dizin_bi,1);
[acc_type_rf,score_type_rf,avgval_type_rf]=sadecerf(dizin_type,1);
[acc_type_svm,score_type_svm,avgval_type_svm]=sadecesvm(dizin_type,1);

