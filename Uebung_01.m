nations = dlmread("nations.csv",",",1,0);
one_mil = 1000000;


#Gesamtbev�lkerung
sum_pop = sum(nations(:,7)); 


nations_gdp = (nations(:,4)./nations(:,7))*one_mil;
nations_lifespan = nations(:,5);



[prediction] =predict(nations_lifespan,nations_gdp);

#rmse der Pr�diktion
rmse = sqrt(sum((nations_lifespan .- prediction).^2)/size(prediction,1));


#Plot von Lesende BEv�lkerung in % und Lebenserwartzung
plot(nations(:,6)*100,nations(:,5),"xr");
figure;

#Plot der Pr�diktion
plot((nations(:,4)./nations(:,7)*one_mil),nations(:,5),"xr");

hold;

plot(nations_gdp,prediction);




