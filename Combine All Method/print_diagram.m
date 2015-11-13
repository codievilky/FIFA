function print_diagram()
close all;
load print_data.mat
figure;
%figure('Position',[1 1 1200 900])
plot(x_label, FPR_Advanced_mean, 'rs-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
hold on;
plot(x_label, FPR_Basic_mean, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
plot(x_label, FPR_Recursion_mean, 'b+-', 'LineWidth', 2, 'MarkerFaceColor', 'b');
hold off
legend('\fontsize{12}\bf Advanced','\fontsize{12}\bf Basic','\fontsize{12}\bf Recursion');

xlabel('\fontsize{12}\bf Sequence Number');
ylabel('\fontsize{12}\bf False Positive Rate');
title('\fontsize{12}\bf  Sequence Number vs. FPR');
figure;
%figure('Position',[1 1 1200 900])
plot(x_label, FNR_Advanced_mean, 'rs-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
hold on;
plot(x_label, FNR_Basic_mean, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
plot(x_label, FNR_Recursion_mean, 'b+-', 'LineWidth', 2, 'MarkerFaceColor', 'b')
hold off
legend('\fontsize{12}\bf Advanced','\fontsize{12}\bf Basic','\fontsize{12}\bf Recursion');

xlabel('\fontsize{12}\bf Sequence Number');
ylabel('\fontsize{12}\bf False Negative Rate');
title('\fontsize{12}\bf  Sequence Number vs. FNR');
