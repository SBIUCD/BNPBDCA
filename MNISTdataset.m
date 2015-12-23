%% add path to code and data
addpath('Visualization/export_fig/');
addpath('Visualization/');
addpath('BNPBDCA/');
addpath('data/MNIST/')
addpath('data/misc/');

% Define output directory
outdir='results\MNIST\';
if exist(outdir)~=7
mkdir(outdir);
end

% Read data file
B=dlmread('data.txt');
L=dlmread('labels.txt');
I=1:1000; % Take only first 1000 images
B=B(I,:);
L=L(I);
N=size(B,1);
%% Initialize params and hyper params
NOIT=100; % no of iterations
fact=0.9; % cooling factor
alpha=1; % beta parameters
beta=betaparams(B); %beta parameters 
gamma=1; % Dirichlet parameters
labels=ones(N,1); %initial labels
T=1; % initial temperature
tic;
c=clust2(B,NOIT,[outdir 'outfile.txt'],labels,fact,alpha,beta,gamma,T);
%dlmwrite([outdir 'binclust_labels.txt'],c);
toc;

%% Save average image of each cluster
average_image(B,c,outdir);

%% Visualization
map=flipud(brewermap([],'RdYlBu'));
plot_clusters(ones(size(B,1),1),B);colormap(map); % plot data
export_fig(gcf,[outdir 'data'],'-jpg','-q100','-r300','-transparent');
plot_clusters(c,B);colormap(map);
export_fig(gcf,[outdir 'clustered_data'],'-jpg','-q100','-r300','-transparent');
