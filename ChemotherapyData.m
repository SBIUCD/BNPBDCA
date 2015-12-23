clear all;
%% add paths to codes and data
addpath('Visualization/export_fig/');
addpath('Visualization/');
addpath('BNPBDCA/');
addpath('data/Chemotherapy/')
addpath('data/misc/');

outdir='results\Chemotherapy\'; % define output directory, change if necessary
if exist(outdir)~=7
mkdir(outdir);
end
% select chemotherapy drugs
interesting_drugs={'Doxorubicin', 'Etoposide', 'Gemcitabine', 'Cisplatin','Docetaxel', 'Methotrexate'}
%% Read data
data=dlmread('binary_data.txt');
cell_lines=textread('cell_lines.txt','%s');
headers=textread('headers.txt','%s');
data_mut=data(:,14:21);%mutation data
Id=sum(data_mut,2)~=0;%find cell lines that have no mutations
Im=ismember(headers,interesting_drugs);
Im(1:21)=true;
data=data(Id,Im);
cell_lines=cell_lines(Id);
headers=headers(Im);
size(data)

%% Initialize parameters and hyper parameters
fact=0.9; % cooling factor
NOIT=500; % no of iterations
alpha=1; % beta parameter
beta=betaparams(data); % beta parameter
gamma=1; % Dirichlet parameter
T=1; % initial temperature
labels=1:size(data,1); % initial labels
c=clust2(data(:,:),NOIT,[outdir 'outfile.txt'],labels,fact,alpha,beta,gamma,T);% cluster data

%% Visualization
map=flipud(brewermap([],'RdYlBu'));
figure;imagesc(data);colormap(map);
export_fig(gcf,[outdir 'data'],'-jpg','-q100','-r300','-transparent');
plot_clusters(c,data,[0 0 800 900]);colormap(map);set(gca,'YDir','normal','XTick',1:length(headers),'XTickLabel',headers,'FontSize',12);rotateXLabels(gca,-45);
export_fig(gcf,[outdir 'clustered_data'],'-jpg','-q100','-r300','-transparent');
plot_clusters1(c,data,headers,outdir,-1,[0 0 900 250]);


