clear;

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



cars = dlmread("cars.csv", ",", 1, 1);

cylinders = cars(:,1);
displacement = cars(:,2);
horsepower = cars(:,3);
weight = cars(:,4);
acceleration = cars(:,5);
model_year = cars(:,6);
mpg = cars(:,7);




cylinders_norm = normalize(cylinders);
displacement_norm = normalize(displacement);
weight_norm = normalize(weight);
acceleration_norm = normalize(acceleration);
model_year_norm = normalize(model_year);
mpg_norm = normalize(mpg);
horsepower_norm = normalize(horsepower);



cars_norm = [cylinders_norm displacement_norm weight_norm acceleration_norm model_year_norm horsepower_norm];



function [best_coeffs,best_rmse,initial_rmse] = evolution(descendants, generations,dataset,compare_values) 

  parent = unifrnd(-1,1,[6,1]);
  initial_prediction = predict(dataset,parent);
  init_pred_denorm = denormalize(initial_prediction,compare_values);

  initial_rmse = rmse (compare_values,init_pred_denorm); 
  final_rmse = initial_rmse;

  for i=1:generations
     for j = 1:descendants
       mutation_steps = unifrnd(-0.01,0.01,[6,1]);
       children_tmp = parent+mutation_steps;
       
       prediction_tmp = predict(dataset,children_tmp);
       pred_tmp_denorm=denormalize(prediction_tmp,compare_values);
       error = rmse(compare_values,pred_tmp_denorm);
       
       if error<final_rmse
         final_rmse = error;
         parent = children_tmp;
         
       endif
     endfor
  endfor

  
  best_coeffs = parent;
  best_rmse = final_rmse;
  
  
  disp(sprintf("Initial RMSE : %0.2f",initial_rmse));
  disp(sprintf("Running for %i generations - %i parents, %i children",generations,size(parent,2),descendants));
  disp(sprintf("Final RMSE: %0.2f",final_rmse));
  
  return;

endfunction


[best_coeffs,best_rmse,initial_rmse] = evolution(10,300,cars_norm,mpg);

line_4_mpg = mpg(4);
line_57_mpg = mpg(57);
line_117_mpg = mpg(117);
line_219_mpg = mpg(219);


line_4_pred = denormalize(predict(cars_norm(4,:),best_coeffs),mpg);
line_57_pred = denormalize(predict(cars_norm(57,:),best_coeffs),mpg);
line_117_pred = denormalize(predict(cars_norm(117,:),best_coeffs),mpg);
line_219_pred = denormalize(predict(cars_norm(219,:),best_coeffs),mpg);

disp(sprintf("Line      4: mpg is %0.2f - predicted %0.2f",line_4_mpg, line_4_pred));
disp(sprintf("Line     57: mpg is %0.2f - predicted %0.2f",line_57_mpg, line_57_pred));
disp(sprintf("Line    117: mpg is %0.2f - predicted %0.2f",line_117_mpg, line_117_pred));
disp(sprintf("Line    219: mpg is %0.2f - predicted %0.2f",line_219_mpg, line_219_pred));






