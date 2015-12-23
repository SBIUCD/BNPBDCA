% Add paths to the code and data folders 
addpath('Visualization/export_fig/');
addpath('Visualization/');
addpath('BNPBDCA/');
addpath('BNPGibbs/');
addpath('GapStatistic/kmeans/')
addpath('misc/');
addpath('data/Simulation/')

outdir='results\simulation\'; % define output directory, change if necessary
if exist(outdir)~=7
mkdir(outdir);
end

%%
 B=dlmread('data1.txt'); % select a datafile data1-10.txt
 L=dlmread('labels1.txt'); % select the corresponding label file for comparison
 N=size(B,1);
%%
%%
NOIT=100; % No of iterations
fact=0.9; % Cooling factors
alpha=1; % Beta parameter
beta=betaparams(B); % Beta parameter
gamma=1; % Dirichlet parameter
labels=ones(N,1); % initial labels
T=1; % initial temperatures
tic;
c=clust2(B,NOIT,[outdir 'outfile.txt'],labels,fact,alpha,beta,gamma,T);
toc;
% calculate accuracy 
[accuracy, true_labels, CM] = calculateAccuracy(c, L);

%% Full Bayesian (BNPGibbs)
Z=dpmm_bernoulli(B);
d=size(Z);
if length(d)==2 % data is grouped in one cluster
    c1=ones(N,1);
else
c1=post_process_dpmm_bernoulli(Z);
end
dlmwrite([outdir 'binclust_labels_dpmm.txt'],c1);
[accuracy1, true_labels1, CM1] = calculateAccuracy(c1, L);

%% Hierarchical agglomerative
T=clusterdata(B,20);
dlmwrite([outdir 'binclust_labels_hagl.txt'],T);
[accuracy2, true_labels2, CM2] = calculateAccuracy(T, L);

%% Gap statistic k-means
[opt_k, gap, slwk] = GapStatisticsMe(B,2:15,100,[outdir 'Gap']);
idx=kmeans(B,opt_k, 'Distance','hamming','emptyaction','drop');
[accuracy3, true_labels3, CM3] = calculateAccuracy(idx, L);
%%
dlmwrite([outdir 'binclust_labels_gapkmeans.txt'],idx);
dlmwrite([outdir 'accuracy.txt'],[accuracy accuracy1 accuracy2 accuracy3]); % write all accuraries

