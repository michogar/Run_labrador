function level = getLevelFromProf(nc, cell, prof)
%GETLEVELFROMPROF From a prof and a cell passed as parameter, calculates the level 
% that this prof is 
s = nc{'s_rho'};
h = nc{'h'};

levels = size(s);
max_prof = h(cell(1), cell(2));

if (prof > max_prof) 
    disp('Prof over the max prof at this point. Max prof is:')
    disp(max_prof);
    level = NaN;
else 
    level = levels(1) - round(prof/(max_prof / levels(1)));
end
end

