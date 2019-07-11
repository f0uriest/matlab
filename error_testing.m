%% Interpolation check
clear
load shot968001.mat
load constants.mat

interp_err = zeros(1,length(t));
for slice =1:length(t)
    x = [rho(21:40,slice);rho(1:20,slice)];
    v = [teraw(21:40,slice);teraw(1:20,slice)];
    if(numel(unique(x))-1)
        te_interp(:,slice) = interp1(x,v,rhotrain','linear','extrap');
        interp_err(slice) = norm(te_interp(:,slice)-te(:,slice))/norm(te_interp(:,slice));
    end
end
plot(t,interp_err)


%% raw te vs interp te error 1 slice

i=16000;

[x1,ind] = sort(rho(:,i));
x2 = rhotrain;
y1 = teraw(ind,i);
y2 = te(:,i);
plot(x1,y1,x2,y2)

%% interp error 1 slice

i=15000;
y1 = te_interp(:,i);
y2 = te(:,i);
x1 = rhotrain;
x2 = rhotrain;
plot(x1,y1,x2,y2)


%% averaging
clear
load shot968001.mat
load constants.mat

t = t-t(1);
dt = 20000;
cts = [];
ringbuffersize = 1000;
for slice=1:length(t)
    input_te = single(zeros(5,30));
    input_ip =  single(zeros(5,1));
    input_pinj =  single(zeros(5,1));
    ct = zeros(5,1);
    ctidx = 5;
    curtime = t(slice);
    for j = slice:-1:(slice-ringbuffersize)
        ct(ctidx) = ct(ctidx)+1;
        if j>0
            input_ip(ctidx) =  single(input_ip(ctidx)) +  single(ip(j));
            input_pinj(ctidx) =  single(input_pinj(ctidx)) +  single(pinj(j));
            input_te(ctidx,:) =  single(input_te(ctidx,:)) +  single(te(:,j))';
            if (curtime - t(j)) >= dt
                curtime = t(j);
                ctidx = ctidx-1;
            end
        elseif curtime>=dt
                curtime = 0;
                ctidx = ctidx-1;
        end
        if ctidx<1
            break
        end
            %         if (t(slice)-t(j)) > 0 && (t(slice)-t(j)) < .02
            %             ct(5) = ct(5) + 1;
            %             input_ip(5) = input_ip(5) + ip(j);
            %             input_pinj(5) = input_pinj(5) + pinj(j);
            %             input_te(5,:) = input_te(5,:) + te(:,j)';
            %         elseif (t(slice)-t(j)) > .020 && (t(slice)-t(j)) < .040
            %             ct(4) = ct(4) + 1;
            %             input_ip(4) = input_ip(4) + ip(j);
            %             input_pinj(4) = input_pinj(4) + pinj(j);
            %             input_te(4,:) = input_te(4,:) + te(:,j)';
            %         elseif (t(slice)-t(j)) > .040 && (t(slice)-t(j)) < .060
            %             ct(3) = ct(3) + 1;
            %             input_ip(3) = input_ip(3) + ip(j);
            %             input_pinj(3) = input_pinj(3) + pinj(j);
            %             input_te(3,:) = input_te(3,:) + te(:,j)';
            %         elseif (t(slice)-t(j)) > .060 && (t(slice)-t(j)) < .080
            %             ct(2) = ct(2) + 1;
            %             input_ip(2) = input_ip(2) + ip(j);
            %             input_pinj(2) = input_pinj(2) + pinj(j);
            %             input_te(2,:) = input_te(2,:) + te(:,j)';
            %         elseif (t(slice)-t(j)) > .080 && (t(slice)-t(j)) < .100
            %             ct(1) = ct(1) + 1;
            %             input_ip(1) = input_ip(1) + ip(j);
            %             input_pinj(1) = input_pinj(1) + pinj(j);
            %             input_te(1,:) = input_te(1,:) + te(:,j)';
            %         end
        end
        cts = [cts,ct];
        input_ip = (single(input_ip)./max(ct,1) - single(meanip))/single(stdip);
        input_pinj = (single(input_pinj)./max(ct,1) - single(meanpinj))/single(stdpinj);
        input_te = (single(input_te/1000)./max(ct,1) -  single(meante)')./single(stdte)';
        input = single(zeros(5,32));
        input(1:5,1) = single(input_ip);
        input(1:5,2) = single(input_pinj);
        input(1:5,3:end) = single(input_te);
        actinput = single(in(:,slice));
        actinput = reshape(actinput,[32,8])';
        futurete = actinput(6:8,3:end);
        actinput = actinput(1:5,:);
        %     future_te_err(slice) = norm(futurete);
        inputarr(slice,:,:) = input;
        iperror(slice) = norm(actinput(:,1)-input(:,1));
        pinjerror(slice) = norm(actinput(:,2)-input(:,2));
        teerror(slice) = norm(actinput(:,3:end)-input(:,3:end));
        avgerror(slice) = norm(single(actinput(:)) - single(input(:)))/numel(actinput);
    end
    figure(1)
    plot(t,avgerror);
    % figure(2)
    % plot(t,future_te_err);
    
    %% ip pinj error
    close all
    for slice = 1:length(t)
    actinput = in(:,slice);
    actinput = reshape(actinput,[32,8])';
    actinput = actinput(1:5,1:2);
    corinput = reshape(inputarr(slice,:,:),[5,32]);
    corinput = corinput(1:5,1:2);
    ippinjerr(slice,:) = sum(abs((corinput-actinput)))./sum(abs(corinput));
    end
       plot(t,ippinjerr);
    
    
    
    %% te avg error 1 slice
    close all
    slice = 797;
    actinput = in(:,slice);
    actinput = reshape(actinput,[32,8])';
    actinput = actinput(1:5,3:end);
    corinput = reshape(inputarr(slice,:,:),[5,32]);
    corinput = corinput(1:5,3:end);
    for i=1:5
        figure(i)
    plot(rhotrain,actinput(i,:),rhotrain,corinput(i,:))
    end
    
    %%
    close all
    
    ioerror = zeros(1,length(t));
    for slice=1:length(t)
        input = in(:,slice);
        input = reshape(input,[32,8])';
        out = test(input);
        corinput = reshape(inputarr(slice,:,:),[5,32]);
        corinput = [corinput;zeros(3,32)];
        corinput(6:8,1:2) = [corinput(5,1:2);corinput(5,1:2);corinput(5,1:2);];
        corout = test(corinput);
    
        ioerror(slice) = norm(out'-pred(:,slice))/norm(out);
        corioerror(slice) = norm(corout'-pred(:,slice))/norm(corout);
    
    end
    plot(t,corioerror)
    
    %%
    slice = 797;
        corinput = reshape(inputarr(slice,:,:),[5,32]);
        corinput = [corinput;zeros(3,32)];
        corinput(6:8,1:2) = [corinput(5,1:2);corinput(5,1:2);corinput(5,1:2);];
        corout = test(corinput);
        x1 = rhotrain;
        x2 = rhotrain;
        y1 = corout;
        y2 = pred(:,slice);
        plot(x1,y1,x1,y2)
    
    
    
    %% io error
    clear
    load shot968024.mat
    load constants.mat
    
    ioerror = zeros(1,length(t));
    for slice=1:length(t)
        input = in(:,slice);
        input = reshape(input,[32,8])';
        out = test(input);
        corinput = zeros(8,32);
    
    
        ioerror(slice) = norm(out'-pred(:,slice))/norm(out);
    
    end
    plot(t,ioerror)
    
    
    %% io error 1 slice
    slice = 900;
      input = in(:,slice);
        input = reshape(input,[32,8])';
        out = test(input);
        x1 = rhotrain;
        x2 = rhotrain;
        y1 = out;
        y2 = pred(:,slice);
        plot(x1,y1,x1,y2)
    
    
    
    %% prediction error
    clear
    load shot968024.mat
    load constants.mat
    
    pred_error = zeros(1,length(t));
    act_error = zeros(1,length(t));
    dt = .060;
    for slice=300:length(t)-160
       curr_pred = (pred(:,slice).*stdte+meante);
       curr_act = te(:,slice)/1000;
       future_ind = find((t-t(slice)-dt)>0,1);
       future_act = te(:,future_ind)/1000;
       pred_error(slice) = norm(curr_pred-future_act)/norm(future_act);
       act_error(slice) = norm(curr_act-future_act)/norm(future_act);
    
    end
    plot(t,pred_error,t,act_error)