clear;
function result = rmse(orig_data, prediction)
  
  result = sqrt(sum((prediction .- orig_data) .^ 2) / size(prediction,1));
  
  return;
endfunction
X = [1 0.0129 0.0001; 1 0.2652 0.0703; 1 0.7890 0.6226; 1 1.0000 1.0000];

Y = [0.56;0.75;0.85;0.80];

theta = ones(3,1)

learn_rate = 0.3;
m = size(X,1);

for i=1:1000000
  hypothesis = X*theta;
 error = rmse(Y,hypothesis);
  diff = hypothesis - Y;


  alteration = X' * diff;


  dampening = alteration * (learn_rate/m);

  theta_new = theta - dampening;
  theta = theta_new;
endfor
