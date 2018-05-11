nations = dlmread("nations.csv", ",", 1, 0);

function result = polynom (x, k, rang, abs)
  
  polynom_mask = bsxfun(@power, x, (0:rang));
  result = sum(polynom_mask .* k, 2) + abs;
  
  return;
endfunction

function result = rmse(orig_data, prediction)
  
  result = sqrt(sum((prediction .- orig_data) .^ 2) / size(prediction,1));
  
  return;
endfunction
function result = normalize(data)
  
  result = (data - min(data)) / (max(data) - min(data));
  
  return;
endfunction

function result = denormalize(data_norm,original_data)
  
  result = data_norm * (max(original_data) - min(original_data)) +min(original_data);
  
  return;
endfunction


#Bis auf Normalisierung wie vorige Aufgabe

population = nations(:,7);
gdp_millions = nations(:,4) * 1000000;
life_expectancy = nations(:,5);
bip = gdp_millions ./ population;



#CSV_Daten werden normalisiert
bip_norm = normalize(bip);
life_norm = normalize(life_expectancy);

best_pol = [];
best_abs = 100;
best_coeffs = [];
best_rmse = 1000;

for i=1:100000
  rand_coeffs = unifrnd(-1, 1, [1,3]);
  abs = 0;
  pol = polynom(bip_norm, rand_coeffs, 2, abs);
  pol_denorm = denormalize(pol,life_expectancy);
  error = rmse(life_expectancy, pol_denorm);
  
  
  if error < best_rmse
    best_rmse = error;
    best_coeffs = rand_coeffs;
    best_pol = pol_denorm;
    best_abs = abs;
  endif
  
  
endfor




scatter(bip, life_expectancy, "r", "x");
hold;
plot(bip, best_pol,"xg");


