%% Plot surface
clear all; close all;
nc=netcdf('/media/michogarcia/MARSH/roms_his.nc');

[lon, lat] = getLonLat(nc);
h = nc{'h'}(:); h(h<100)=NaN;

pcolor(lon, lat, -h); shading flat;

%% Plot bathimetry
clear all; close all;
nc=netcdf('/media/michogarcia/MARSH/roms_his.nc');

h=nc{'h'}(:);
lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:);
surf(lon, lat, -h);


%% Plot section across longitude
clear all; close all;
nc=netcdf('/media/michogarcia/MARSH/roms_his.nc');

[lon, kk] = getLonLat(nc); x=lon(floor(end/2), :);
h=nc{'h'}(floor(end/2), :); [kk, m]=size(lon);
time=nc{'time'}(:); [maxt, kk]=size(time);

rgb=tempColorbar();
colormap(rgb);

for t=1:maxt
    zeta=nc{'zeta'}(t, floor(end/2), :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1)); x=depth;
    for i=1:m
        x(:, i)=lon(1, i);
    end
    temp=squeeze(nc{'temp'}(t, :, floor(end/2), :)); temp(temp==0)=NaN;
    
    pcolor(x, depth, temp); colorbar; title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.5);
end

%% Plot section across latitude
clear all; close all;
nc=netcdf('/media/michogarcia/MARSH/roms_his.nc');

[kk, lat] = getLonLat(nc);
h=nc{'h'}(:, floor(end/2)); [m, kk]=size(lat);
time=nc{'time'}(:); [maxt, kk]=size(time);

rgb=tempColorbar();
colormap(rgb);

for t=1:maxt
    zeta=nc{'zeta'}(t, :, floor(end/2));
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1)); x=depth;
    
    temp=squeeze(nc{'temp'}(t, :, :, floor(end/2))); temp(temp<1)=NaN;
    for i=1:m
        y(i, :)=lat(i, 1);
    end
    pcolor(-y, depth, temp); colorbar; title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.5);
end

%% Surface 
clear all; close all;
nc=netcdf('/media/michogarcia/MARSH/roms_his.nc');

[lon, lat] = getLonLat(nc);
time=nc{'time'}(:); [maxt, kk]=size(time);

rgb=tempColorbar();
colormap(rgb);

for t=1:maxt
    temp=nc{'temp'}(t, 32, :, :); temp(temp==0)=NaN;
    pcolor(lon, lat, temp); colorbar; shading flat; title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.2);
end