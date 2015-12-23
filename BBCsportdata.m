clear all;

% Add paths to the code and data folders
addpath('Visualization/export_fig/');
addpath('Visualization/');
addpath('BNPBDCA/');
addpath('data/BBCSport/')


% Output directory, change if necessary
outdir='results/bbcsport/';
if exist(outdir)~=7
mkdir(outdir);
end
% read and preprocess data
mat1=dlmread('mat.txt');
mat1=spconvert(mat1);
mat=sparse(zeros(size(mat1)));
mat(mat1>1)=1; %% Consider only those terms which appear more than once in a document
mat=mat';

I=sum(mat)>20;
mat=mat(:,I);



% Initialize params and hyperparams
fact=0.9; % Cooling factor
NOIT=500; % number of iterations
alpha=1; % ajk in the paper
beta=betaparams(mat); % bjk in the paper
gamma=1; % alpha in the paper
T=1; % T_init in the paper
labels=ones(1,size(mat,1));% initial labels set to 1
%%
tic;
c=clust2(mat,NOIT,[outdir 'output.txt'],labels,fact,alpha,beta,gamma,T);
toc;
%% visualization
map=flipud(brewermap([],'RdYlBu'));%Colormap
plot_clusters(labels,mat);colormap(map);%plot raw data
export_fig(gcf,[outdir 'data'],'-jpg','-q100','-r300','-transparent'); % save figure;

plot_clusters(c,mat);colormap(map);% plot clustered data
export_fig(gcf,[outdir 'clustered_data'],'-jpg','-q100','-r300','-transparent'); % save figure;
