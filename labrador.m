%% Plot surface
clear all; close all;
nc=netcdf('/media/michogarcia/MARSH/roms_his.nc');

[lon, lat] = getLonLat(nc);
h = nc{'h'}(:);

pcolor(lon, lat, -h); shading flat;

%% Plot section across longitude
clear all; close all;
nc=netcdf('/media/michogarcia/MARSH/roms_his.nc');

lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:); x=lon(floor(end/2), :);
h=nc{'h'}(floor(end/2), :); [kk, m]=size(lon);

for t=1:31
    zeta=nc{'zeta'}(t, floor(end/2), :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1)); x=depth;
    for i=1:m
        x(:, i)=lon(1, i);
    end
    s=squeeze(nc{'salt'}(t, :, floor(end/2), :)); s(s<30)=NaN;
    
    pcolor(x, depth, s); colorbar; title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.5);
end

%% Plot section across latitude
clear all; close all;
nc=netcdf('/media/michogarcia/MARSH/roms_his.nc');

[lon, lat] = getLonLat(nc);
h=nc{'h'}(:, floor(end/2)); [m, kk]=size(lat);

for t=1:31
    zeta=nc{'zeta'}(t, :, floor(end/2));
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1)); x=depth;
    
    s=squeeze(nc{'temp'}(t, :, :, floor(end/2))); s(s<1)=NaN;
    for i=1:m
        y(i, :)=lat(i, 1);
    end
    pcolor(y, depth, s); colorbar; title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.5);
end