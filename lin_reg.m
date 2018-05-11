function [rmse] = lin_reg(data,iterations,learn_rate)
  data_prepped = [ones(size(data,1),1) data];
  
  m = size(data);
  
  theta = rand(size(data_prepped,2),1);
  
  error =[];
  
  
endfunction
