function distance=calculate_dis(location,cita,localization)
distance=abs(tan(cita)*localization(1)+localization(2)-tan(cita)*location(1)-location(2))/sqrt(tan(cita)^2+1);
end