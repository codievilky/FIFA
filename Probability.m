function output=Probability(Scan_Number,Error_PerCent,Erro_Number)
Error_PerCent=1/2*Error_PerCent;
output=combntns(Scan_Number,Erro_Number).*(Error_PerCent.^Erro_Number).*((1-Error_PerCent).^(Scan_Number-Erro_Number));