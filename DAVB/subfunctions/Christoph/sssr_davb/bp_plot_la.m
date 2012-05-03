% Plots estimate generated by bp_sssr_est()
% Usage:  est = bp_sssr_est(data); bp_plot_la(est);
function bp_plot_la(r)

% Number of trials
t = length(r.u.x1);

% Optional plotting of standard deviations (true or false)
plotsd2 = false;
plotsd3 = false;

subplot(3,1,1);
plot(1:t, r.la.mu3, 'b', 'LineWidth', 2);
hold all;
plot(0, r.p.mu3_0, 'ob', 'LineWidth', 2); % prior
if plotsd3 == true
    plot(1:t, r.la.mu3 +sqrt(r.la.sa3), 'b', 'LineWidth', 1);
    plot(1:t, r.la.mu3 -sqrt(r.la.sa3), 'b', 'LineWidth', 1);
    plot(0, r.p.mu3_0 +sqrt(r.p.sa3_0), 'ob', 'LineWidth', 1); % prior
    plot(0, r.p.mu3_0 -sqrt(r.p.sa3_0), 'ob', 'LineWidth', 1); % prior
end
%axis([0 t -0.2 0.2]);
xlim([0 t]);
title('Posterior expectation \mu_3 of log-volatility of tendency x_3', 'FontWeight', 'bold');
xlabel('Trial number');
ylabel('\mu_3');
hold off;

subplot(3,1,2);
plot(1:t, r.la.mu2, 'r', 'LineWidth', 2);
hold all;
plot(0, r.p.mu2_0, 'or', 'LineWidth', 2); % prior
if plotsd2 == true
    plot(1:t, r.la.mu2 +sqrt(r.la.sa2), 'r', 'LineWidth', 1);
    plot(1:t, r.la.mu2 -sqrt(r.la.sa2), 'r', 'LineWidth', 1);
    plot(0, r.p.mu2_0 +sqrt(r.p.sa2_0), 'or', 'LineWidth', 1); % prior
    plot(0, r.p.mu2_0 -sqrt(r.p.sa2_0), 'or', 'LineWidth', 1); % prior
end
%axis([0 t -3 3]);
xlim([0 t]);
title('Posterior expectation \mu_2 of tendency x_2', 'FontWeight', 'bold');
xlabel({'Trial number', ' '}); % A hack to get the relative subplot sizes right
ylabel('\mu_2');
hold off;

subplot(3,1,3);
plot(1:t, sgm(r.la.mu2, 1), 'r', 'LineWidth', 2);
hold all;
plot(0, sgm(r.p.mu2_0, 1), 'or', 'LineWidth', 2); % prior
plot(1:t, r.u.x1, '.', 'Color', [0 0.6 0]); % true state
cc = r.y.cc -0.5; cc = 1.16 *cc; cc = cc +0.5; % stretch congruency of choices
cc(r.irr) = NaN; % weed out irregular choices
plot(1:t, cc, '.', 'Color', [1 0.7 0]); % congruency of choices
plot(r.irr,  1.08.*ones([1 length(r.irr)]), 'x', 'Color', [1 0.7 0], 'Markersize', 11, 'LineWidth', 2); % irregular choices
plot(r.irr, -0.08.*ones([1 length(r.irr)]), 'x', 'Color', [1 0.7 0], 'Markersize', 11, 'LineWidth', 2); % irregular choices
plot(1:t, 0.5, 'k');
axis([0 t -0.15 1.15]);
title(['Choice (orange), stimulus category x_1 (green), and posterior expectation of x_1 = 1 (red) for \kappa=', ...
       num2str(r.p.ka), ', \omega=', num2str(r.p.om), ', \vartheta=', ...
       num2str(r.p.th)], 'FontWeight', 'bold');
% title('Stimulus category x_1 (green) and posterior expectation of x_1 = 1 (red)', 'FontWeight', 'bold');
xlabel('Trial number');
ylabel('x_1, s(\mu_2)');
hold off;