%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% step1:smooth reflectance data using smooth function(smoothFunction.m)
% step2:calculate mean value of reflectance data and plot it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%%%%%%% step1
%fileName¡ª¡ªorginal spectrum file folder
fileName = 'example\spec'; 
ASDdir = dir([fileName '\' '/*.txt']);
for i=1:length(ASDdir(:,1))
    ASDPath = [fileName '\' ASDdir(i).name];
    data = importdata(ASDPath);
    smoothFunction(ASDPath);
end


%%%%%%% step2

%datafilelist¡ª¡ªthe detailed information table of observations (.xlsx)
%picDirectory¡ª¡ªthe scence picture folder
%fileprex¡ª¡ªthe smoothing spectrum folder
%outputFolder¡ª¡ªoutput folder
 datafilelist='example\pictureAndInformation table\information';
 picDirectory = 'example\pictureAndInformation table\picture';
 fileprex='example\spec';
 outputFolder='example\result';

[ndata, text, alldata] = xlsread(datafilelist);
sample=text(2:end,1);% site name£¨ID£©
samplenumber = text(2:end,5);% site name
totalsite=text(2:end,7);% sample name 
target=text(2:end,8); %sample class 
pictures = text(2:end,14);%sample picture
startNo=ndata(1:end,8); 
endNo=ndata(1:end,9);
num = size(sample,1);
    
for i = 1:num
	outputDir = [outputFolder,'\',cell2mat(sample(i)),'\', cell2mat(samplenumber(i)), '-',cell2mat(totalsite(i)),'\'];
	mkdir(outputDir); %make new folder
	
	datas=zeros(2000,2);
	lege = [];
	if(~isempty(cell2mat(pictures(i))))
		copyfile([picDirectory,'\',cell2mat(pictures(i))],[outputDir,cell2mat(totalsite(i)),'_',cell2mat(target(i)),'.jpg']);
	end
	t = 0;
	for j = startNo(i):endNo(i)
		data=[];
		targetName=[fileprex,'\spec',num2str(j,'%05d'),'.txt']; 
		fid=fopen(targetName,'r');
		if fid ==-1  
			continue;
		else
		t = t+1;
		m = 1;
		while m<=2000
			temp=str2num(fgetl(fid));
			data=[data; temp];
			m=m+1;
		end
		datas = datas + data;
		cell2mat(sample(i))
		copyfile(targetName,[outputDir, '\',cell2mat(sample(i)), '_' ,cell2mat(totalsite(i)),'_',cell2mat(target(i)),'_',num2str(t,'%03d'),'_Ref.txt']);
		
		%% plot
		plot(data(:,1),data(:,2),'Linewidth',2);
		axis([350 2350 0 1.0]);
		xlabel('Wavelength (um)','fontsize',15);
		ylabel('Reflectance','fontsize',15);
		set(gca,'position',[0.1300    0.1524    0.7750    0.7726]);
		set(gca,'ytick',0.0:0.2:1.0);
		hold on
		lege=[lege;['Ref',num2str(j,'%04d')]];
		
		end
	end
	
	data2=datas./t;
	plot(data2(:,1),data2(:,2),'-bs');
	lege=[lege;'Ref-Ave'];
	legend(lege,'Location','NorthEastOutside');
	title([cell2mat(sample(i)),'-', cell2mat(totalsite(i))]);
	outputAver=[outputFolder,'\',cell2mat(sample(i)),'\', cell2mat(samplenumber(i)), '-',cell2mat(totalsite(i)),'\',cell2mat(totalsite(i)),'-',cell2mat(target(i)),'_RefAver.txt'];
	outputFileAver=[outputFolder,'\',cell2mat(sample(i)),'\',cell2mat(samplenumber(i)), '-',cell2mat(totalsite(i)),'\',cell2mat(totalsite(i)),'-',cell2mat(target(i)),'_Ref.tif'];
	dlmwrite(outputAver,data2,'-append'); %Output the final average reflectance file
	saveas(gcf, outputFileAver, 'tif') 
	fclose all;
	close all;
	fprintf('Over!\n');
end





