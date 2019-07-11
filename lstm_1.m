function output = lstm_1(input,Wi,Wf,Wc,Wo,Ui,Uf,Uc,Uo,bi,bf,bc,bo) 
[num_inputs,input_size] = size(input); 
state = single(zeros(2,input_size)); 
for i =1:num_inputs 
state = lstm_1cell(input(i,:),state,Wi,Wf,Wc,Wo,Ui,Uf,Uc,Uo,bi,bf,bc,bo); 
end 
output = state(1,:); 
end