function [FPR,FNR]=False_Rate(Standed,Calculated)
%False Positive Rate 虚报率
FPR=False_Positive_Rate(Standed,Calculated);
%False Negative Rate 误报率
FNR=False_Negative_Rate(Standed,Calculated);