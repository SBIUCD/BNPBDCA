function [ c] = clust2( B, samples,outfilename, c,fact,alpha,beta,gamma,T)
%Clusters binary data using a Beta-Bernoulli-Discrete-Dirichlet model. 
% B=data, each row represents a data vector, samples=number of iterations,
% outfilename= output file to save the cluster c=initial cluster
% labels, fact=cooling factor, alpha=ajk, beta=bjk both are beta parameters, gamma=alpha=Dirichlet parameters, T= initial temperatures  
%output argument c = new clusters
sd=size(B);
if(nargin==3)
    c=[1:sd(1)]';
    stats=[sd(1) sum(B)];
end
%length(c)
[c, stats]=cleancls(B,c);
%T=1;

%alpha=1;
%beta=1;
%gamma=1;
iter=[];
logl=[];
figure; hold on;
bestc=[];
maxl=-10^50;
for j=1:samples
    disp(['at iteration:' num2str(j)]);
    ll=0;
   for i=1:sd(1)
    [l, p]=probs(B(i,:),c(i), stats,  sd(2), alpha, beta, gamma ,T);
    
    r=rand();
    new_i= min(find(p>r));
    if length(new_i)<1
        disp(p);
    end
    ll=ll+l(new_i);
    old_i=c(i);
    if(new_i~=old_i)
        if(new_i>size(stats,1))
            stats=[stats;[1 B(i,:)]];
            c(i)=new_i;
            stats(old_i,:)=[stats(old_i,1)-1 stats(old_i,2:sd(2)+1)-B(i,:)];
        else
           stats(old_i,:)=[stats(old_i,1)-1 stats(old_i,2:sd(2)+1)-B(i,:)];
           stats(new_i,:)=[stats(new_i,1)+1 stats(new_i,2:sd(2)+1)+B(i,:)];
           c(i)=new_i;
        end
        %[c, stats]=cleancls(B,c);
    end
    %i
   end
   if(ll>maxl)
       maxl=ll;
       bestc=c;
   end
       
   if(mod(j,20)==0)
       T=T*fact;
       dlmwrite(outfilename,bestc);
   end

   if(mod(j,1)==0)
       logl=[logl ll];
       iter = [iter j];
       plot(iter,logl);
       drawnow;
   end
   
   uc=unique(c);
   if(length(uc)<max(uc))
       [c, stats]=cleancls(B,c);
   end
end
hold off;
  
end

