function [] = average_image(B,c,outdir)
%create and save average image for each cluster

ucl = unique(c,'stable');
sqrt(size(B,2))
figure;
for i=1:length(ucl)
    Bi=B(c==ucl(i),:);
    if size(Bi,1)==1
        mb=Bi;
    else
        mb=mean(Bi);
    end
    img=reshape(mb,sqrt(size(B,2)),sqrt(size(B,2)));
    img1=imresize(img,4);
    subplot(6,6,i);imshow(img1);drawnow;
    %imwrite(img,[outdir 'c' num2str(c(i)) '.png']);
    
end
export_fig(gcf,[outdir 'clusts'],'-jpg','-r300','-q100','-transparent');

end

