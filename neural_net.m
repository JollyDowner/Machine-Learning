
clear;


x=[0.35 0.9;0.1 -0.7;0.22 0.02];
y=[0.5;0.35;0.33];

x_xor=[0 0;0 1;1 0;1 1];
y_xor= [0;1;1;0];

x_ex10 =[0 0 0;1 0 0;0 1 0; 1 1 0; 0 0 1; 1 0 1;0 1 1;1 1 1];
y_ex10 =[1 0 0;0 1 0;0 1 0;1 0 0;1 0 0;0 0 1;0 0 1; 1 0 0];#0 =100,x1=010,2=001

function result = sigmoid(data)
  result = 1./(1+exp(-data));
endfunction

function result = neural_net_train(x,y,epochs,hidden_neurons,output_neurons,learn_rate)
  theta1 = unifrnd(-1,1,[(size(x,2)+1),hidden_neurons]);
  theta2=unifrnd(-1,1,[hidden_neurons+1,output_neurons]);
  
  step = learn_rate/size(x,1);
  
 for i=1:epochs
    h1=[ones(size(x,1),1) x]; 
    z2=h1*theta1;

    a2=sigmoid(z2);

    h2=[ones(size(x,1),1) a2];
    z3 = h2*theta2;
    a3 = sigmoid(z3);

    sigmoidDeriv = (a3-y).*a3.*(1-a3);

    delta_theta_2 = step*h2'*sigmoidDeriv;

    diff3=sigmoidDeriv*theta2';

    delta_theta_1 = step*h1'*(diff3(:,2:end).*a2.*(1-a2));
    

    theta1 = theta1-delta_theta_1;
    theta2 = theta2-delta_theta_2;
  endfor
  result =a3;
endfunction

prediction_test = neural_net_train(x,y,2000,4,1,3);
prediction_xor = neural_net_train(x_xor,y_xor,2000,10,1,1);
prediction_ex10=neural_net_train(x_ex10,y_ex10,2000,10,3,1);

  

