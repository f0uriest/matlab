function state = lstm_1cell(inputs,states,Wi,Wf,Wc,Wo,Ui,Uf,Uc,Uo,bi,bf,bc,bo) 

h_tm1 = states(1,:);  % previous memory state
c_tm1 = states(2,:);  % previous carry state

inputs_i = inputs;
inputs_f = inputs;
inputs_c = inputs;
inputs_o = inputs;

x_i = inputs_i*Wi;
x_f = inputs_f*Wf;
x_c = inputs_c*Wc;
x_o = inputs_o*Wo;

x_i = x_i +bi;
x_f = x_f +bf;
x_c = x_c +bc;
x_o = x_o +bo;

h_tm1_i = h_tm1;
h_tm1_f = h_tm1;
h_tm1_c = h_tm1;
h_tm1_o = h_tm1;

yi = hard_sigmoid(x_i + h_tm1_i*Ui); 
yf = hard_sigmoid(x_f + h_tm1_f*Uf); 
yc = yf.*c_tm1 + yi .* relu(x_c + h_tm1_c*Uc); 
yo = hard_sigmoid(x_o + h_tm1_o*Uo); 
h = yo .* relu(yc); 
state = [h;yc];

end
