function fixdisplay(scale)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if strcmp(scale,'4k')
    scale=2;
elseif strcmp(scale,'1080')
    scale=1;
end

% save cwd
cwd = pwd;
cd ~/Documents/MATLAB/
fid = fopen('cwd.txt','wt');
fprintf(fid, cwd);
fclose(fid);

% save workspace variables
evalin('base','save("temp_storage")');

% save figure handles
figHandles = findall(0, 'Type', 'figure');
if length(figHandles)
    savefig(figHandles,'temp_figs.fig');
end
close all

% change resolution
s = settings;
s.matlab.desktop.DisplayScaleFactor.PersonalValue = scale;

system('matlab -desktop -r "after_fixdisplay" &');
quit;

end

