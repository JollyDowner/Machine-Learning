clear;

cars = dlmread("cars.csv", ",", 1, 1);

cylinders = cars(:,1);
displacement = cars(:,2);
horsepower = cars(:,3);
weight = cars(:,4);
acceleration = cars(:,5);
model_year = cars(:,6);
mpg = cars(:,7);

function result = normalize(data)
  
  result = (data - min(data)) / (max(data) - min(data));
  
  return;
endfunction

function result = denormalize(data_norm,original_data)
  
  result = data_norm * (max(original_data) - min(original_data)) +min(original_data);
  
  return;
endfunction

function result = predict (x, k)
  
  result = sum(x* k, 2) ;
  
  return;
endfunction

function result = rmse(orig_data, prediction)
  
  result = sqrt(sum((prediction .- orig_data) .^ 2) / size(prediction,1));
  
  return;
endfunction


cylinders_norm = normalize(cylinders);
displacement_norm = normalize(displacement);
weight_norm = normalize(weight);
acceleration_norm = normalize(acceleration);
model_year_norm = normalize(model_year);
mpg_norm = normalize(mpg);
horsepower_norm = normalize(horsepower);



cars_prepped = [ones(392,1) cylinders_norm displacement_norm weight_norm acceleration_norm model_year_norm horsepower_norm];

m = size(cars,1);

learn_rate = 0.01;

rand("seed",7);
theta  =rand(size(cars_prepped,2),1);

error_alpha0_01 =[];
for i =1:100
  
  hypothesis = cars_prepped*theta;
  prediction_denorm = denormalize(hypothesis,mpg);
  error_alpha0_01 = [error_alpha0_01; rmse(mpg,prediction_denorm)];
  diff = hypothesis-mpg_norm;

  alteration = cars_prepped' * diff;

  dampening = alteration * (learn_rate/m);
  theta_new = theta - dampening;
  theta = theta_new;

endfor

learn_rate = 1;

rand("seed",7);
theta  =rand(size(cars_prepped,2),1);

error_alpha1 =[];
for i =1:100
  
  hypothesis = cars_prepped*theta;
  prediction_denorm = denormalize(hypothesis,mpg);
  error_alpha1 = [error_alpha1; rmse(mpg,prediction_denorm)];
  diff = hypothesis-mpg_norm;

  alteration = cars_prepped' * diff;

  dampening = alteration * (learn_rate/m);
  theta_new = theta - dampening;
  theta = theta_new;

endfor

learn_rate = 2;

rand("seed",7);
theta  =rand(size(cars_prepped,2),1);

error_alpha2 =[];
for i =1:100
  
  hypothesis = cars_prepped*theta;
  prediction_denorm = denormalize(hypothesis,mpg);
  error_alpha2 = [error_alpha2; rmse(mpg,prediction_denorm)];
  diff = hypothesis-mpg_norm;

  alteration = cars_prepped' * diff;

  dampening = alteration * (learn_rate/m);
  theta_new = theta - dampening;
  theta = theta_new;

endfor

learn_rate = 0.1;

rand("seed",7);
theta  =rand(size(cars_prepped,2),1);

error_alpha0_1 =[];
for i =1:100
  
  hypothesis = cars_prepped*theta;
  prediction_denorm = denormalize(hypothesis,mpg);
  error_alpha0_1 = [error_alpha0_1; rmse(mpg,prediction_denorm)];
  diff = hypothesis-mpg_norm;

  alteration = cars_prepped' * diff;

  dampening = alteration * (learn_rate/m);
  theta_new = theta - dampening;
  theta = theta_new;

endfor




plot(error_alpha1,"g");
hold on;
plot(error_alpha2,"m");
hold on;
plot(error_alpha0_1);
hold on;
plot(error_alpha0_01,"r");

axis([1,100 ,1 ,60]);

