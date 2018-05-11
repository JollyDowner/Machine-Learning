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



cars_norm = [cylinders_norm displacement_norm weight_norm acceleration_norm model_year_norm horsepower_norm];



best_prediction =[];
best_k = [];
best_rmse = inf();


for i =1:300
  k = unifrnd(-1,1,[6,1]);
  prediction = predict(cars_norm,k);
  pred_denorm = denormalize(prediction, mpg);
  error = rmse(mpg,pred_denorm);
  
  if error < best_rmse
    best_rmse = error;
    best_k =k;
    best_prediction = pred_denorm;
  endif
endfor


