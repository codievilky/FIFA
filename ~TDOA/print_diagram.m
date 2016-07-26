function print_diagram()
close all;
load print_data.mat
figure;
%figure('Position',[1 1 1200 900])
plot(x_label, FPR_Basic_mean, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
hold on;
plot(x_label, FPR_OnlyOne_mean, 'ro-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
hold off
set(gca,'xtick',x_label);
axis([min(x_label) max(x_label) 0 2]); 
legend('\fontsize{12}\bf Basic','\fontsize{12}\bf OnlyOne');

xlabel('\fontsize{12}\bf TDOA error range');
ylabel('\fontsize{12}\bf False Positive Rate');
title('\fontsize{12}\bf  TDOA error range vs. FPR');
figure;
%figure('Position',[1 1 1200 900])
plot(x_label, FNR_Basic_mean, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
hold on;
plot(x_label, FNR_OnlyOne_mean, 'ro-', 'LineWidth', 2, 'MarkerFaceColor', 'r')
hold off
set(gca,'xtick',x_label);
axis([min(x_label) max(x_label) 0 2]); 
legend('\fontsize{12}\bf Basic','\fontsize{12}\bf OnlyOne');
xlabel('\fontsize{12}\bf TDOA error range');
ylabel('\fontsize{12}\bf False Negative Rate');
title('\fontsize{12}\bf  TDOA error range vs. FNR');
