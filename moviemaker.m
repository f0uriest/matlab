% Write Video
%creates video file from images

output = VideoWriter('003-7modeapprox.avi'); %specifies output filename
output.FrameRate = 5;
open(output)
n=26; %how many frames?
for i=26*5:26*5+n-1
    name = sprintf('003-7modeapprox-time%.2f.png',.2*i*dt); %have to change to match image name format
    frame = imread(name);
    writeVideo(output,frame)
end
close(output)