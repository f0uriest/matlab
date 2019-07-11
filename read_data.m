dirlist = dir;
for i=1:30
    fname = 'etste' + string(i);
    te(i,:) = csvread(fname);
end

for i=1:40
    fname = 'etsrho' + string(i);
    rho(i,:) = csvread(fname);
end

for i=1:40
    fname = 'etsteraw' + string(i);
    teraw(i,:) = csvread(fname);
end

for i=1:256
    fname = 'etsin' + string(i);
    in(i,:) = csvread(fname);
end

fname = 'etsip';
ip = csvread(fname);

fname = 'etspinj';
pinj = csvread(fname);

fname = 't';
t = csvread(fname);
