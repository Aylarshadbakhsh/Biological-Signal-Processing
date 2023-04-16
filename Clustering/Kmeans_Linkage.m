clc
clear
close all
%% load data
load DATA1.mat
%% K-Means Settings

nCluster=3;                              % Number of Clusters

DistanceMetric='cityblock';            % Metric

Options  = statset('Display','final');

%% Run K-Means

[I, C , sumd ,D]=kmeans(x,nCluster,...
    'Distance',DistanceMetric,...
    'Options',Options);

%% Plot results

figure;
plot(x(I==1,1),x(I==1,2),'r.');
hold on;
plot(x(I==2,1),x(I==2,2),'b.');
plot(x(I==3,1),x(I==3,2),'m.');

plot(C(:,1),C(:,2),'kx','LineWidth',2,'MarkerSize',14);
plot(C(:,1),C(:,2),'ko','LineWidth',2,'MarkerSize',14);

legend('Claster 1','Cluster 2','Cluster 3','Cluster Centers');

xlabel('x_1');
ylabel('x_2');
title('Kmeans clustering')

hold off;
%% Hierarchical clustering 
Z = linkage(x,'ward');
c = cluster(Z,'Maxclust',3);
figure;
plot(x(c==1,1),x(c==1,2),'r.');
hold on;
plot(x(c==2,1),x(c==2,2),'b.');
plot(x(c==3,1),x(c==3,2),'m.');
title('Hierarchical clustering ')
figure;
cutoff = median([Z(end-2,3) Z(end-1,3)]);
dendrogram(Z,'ColorThreshold',cutoff)
title('Cluster Dendrogram')





