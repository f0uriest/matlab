clear

shotnumber = 968001;

for i=1:30
    fname = 'etste' + string(i) + '.csv';
    te(i,:) = csvread(fname);
end

for i=1:30
    fname = 'etspred' + string(i) + '.csv';
    pred(i,:) = csvread(fname);
end

for i=1:40
    fname = 'etsrho' + string(i) + '.csv';
    rho(i,:) = csvread(fname);
end

for i=1:40
    fname = 'etsrawte' + string(i) + '.csv';
    teraw(i,:) = csvread(fname);
end

for i=1:256
    fname = 'etsin' + string(i) + '.csv';
    in(i,:) = csvread(fname);
end

fname = 'etsip.csv';
ip = csvread(fname);

fname = 'etspinj.csv';
pinj = csvread(fname);

fname = 't.csv';
t = csvread(fname);

fname = 'etserract.csv';
erract = csvread(fname);

fname = 'etserrtor.csv';
errtor = csvread(fname);

fname = 'etserrrpp.csv';
errrpp = csvread(fname);

fname = 'etserrcer1.csv';
errcer1 = csvread(fname);

fname = 'etserrcer2.csv';
errcer2 = csvread(fname);


savename = 'shot' + string(shotnumber) + '.mat';
save(char(savename));