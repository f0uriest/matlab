
% change to matlab dir
cd ~/matlab
fileList = dir;

for i=1:length(fileList)
    if strcmp(fileList(i).name,'temp_storage.mat')
        % load variables
        load("temp_storage.mat")
        delete temp_storage.mat
    end
    if strcmp(fileList(i).name,'temp_figs.fig')
        % load figs
        openfig('temp_figs.fig');
        delete temp_figs.fig
    end
    if strcmp(fileList(i).name,'cwd.txt')
        % read old working directory
        cwd = fileread('cwd.txt');
        delete cwd.txt
    end
end

if exist('cwd')
    % go back to old cwd
    cd(cwd)
else
    cd ~/SCHOOL/Princeton
end
