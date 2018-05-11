
function [prediction] = predict (lifespan, gdp_per_head)
  gdp_mean  = mean(gdp_per_head);
  
  #Durchschnitt der Lebensspanne als n (-5 zum Nachbessern)
  lifespan_mean = mean(lifespan);
  
  #m berechnet nach einfacher linearer regression
  m = sum((gdp_per_head-gdp_mean) .* (lifespan - lifespan_mean));
  m = m/ sum((gdp_per_head .- gdp_mean).^2);
  n = lifespan_mean;
  
  #y=m * x+n
  prediction = m*gdp_per_head+lifespan_mean;
  
endfunction
