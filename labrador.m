%% Plot surface
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

[lon, lat] = getLonLat(nc);
h = nc{'h'}(:); h(h<100)=NaN;

pcolor(lon, lat, -h); shading flat;

%% Carson Coordinates

latlon1 = [45.516667, -48.516667];
latlon2 = [45.366667, -48.783333];



%% Plot bathimetry with section
clear all; close all;
ncparent=netcdf('ROMS_FILES/roms_grd.nc');
nc=netcdf('ROMS_FILES/roms_grd.nc.1');

h=nc{'h'}(:);
lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:);
%P1=[-48.87, 45.6667];
%P2=[-48.5, 45.3333];
P1=[-49.516667, 45.516667];
P2=[-47.516667, 45.516667];
plot([P1(1) P2(1)],[P1(2) P2(2)],'r')
hold on
surf(lon, lat, -h);


%% Plot section across longitude
clear all; close all;
nc=netcdf('/media/michogarcia/Casa/ROMS_FILES/roms_his.nc');

[lon, ~] = getLonLat(nc); x=lon(floor(end/2), :);
h=nc{'h'}(floor(end/2), :); [~, m]=size(lon);
time=nc{'time'}(:); [maxt, ~]=size(time);

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
nc=netcdf('ROMS_FILES/history/19-apr/roms_his.nc.1');

[~, lat] = getLonLat(nc);
h=nc{'h'}(:, 89); [m, ~]=size(lat);
time=nc{'time'}(:); [maxt, ~]=size(time);

rgb=tempColorbar();
colormap(rgb);

for t=1:maxt
    zeta=nc{'zeta'}(t, :, floor(end/2));
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1)); x=depth;
    
    temp=squeeze(nc{'temp'}(t, :, :, floor(end/2))); temp(temp<-10)=NaN;
    for i=1:m
        y(i, :)=lat(i, 1);
    end
    pcolor(-y, depth, temp); colorbar; shading flat; title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.5);
end

%%
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

[~, lat] = getLonLat(nc);
h=nc{'h'}(:, floor(end/2)); [m, ~]=size(lat);

[m, ~]=size(lat);

    for i=1:m
        y(i, :)=lat(i, 1);
    end
%% Surface 
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc');

[lon, lat] = getLonLat(nc);
time=nc{'time'}(:); [maxt, ~]=size(time);

rgb=tempColorbar();
colormap(rgb);

for t=1:maxt
    temp=nc{'temp'}(t, 32, :, :); temp(temp==0)=NaN;
    pcolor(lon, lat, temp); colorbar; shading flat; title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.2);
end

%% Surface to GIF
% https://waterprogramming.wordpress.com/2013/07/31/generating-gifs-from-matlab-figures/
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

[lon, lat] = getLonLat(nc);
time=nc{'time'}(:); [maxt, ~]=size(time);

rgb=tempColorbar();
colormap(rgb);

initLoop=1;
endLoop=120;

for t=initLoop:maxt
 
    temp=nc{'temp'}(t, 32, :, :); temp(temp==0)=NaN;
    pcolor(lon, lat, temp); colorbar; shading flat; title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400), " - ",  "temp ºC")); pause(0.2);
 
    % gif utilities
    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'surface.gif';
 
    % On the first loop, create the file. In subsequent loops, append.
    if t==initLoop
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
 
end

%% Get cell from coords
clear all; close all;
nc=netcdf('ROMS_FILES/history/19-apr/roms_his.nc.1');

latlon1 = [45.516667, -48.516667];
latlon2 = [45.366667, -48.783333];

lat=nc{'lat_rho'}(:);
[lons, ~]=size(lat);

lon=nc{'lon_rho'}(:);
[~, lats]=size(lon);

coord=latlon1;

% get lat
for cell=1:lons
    if (lon(1, cell) > coord(2))
        coord(2)=cell;
        disp(cell);
        break;
    end
end

% get lon
for cell=1:lats
    if (lat(cell, 1) > coord(1))
        coord(1)=cell;
        disp(cell);
        break;
    end
end

%%
clear all; close all;
nc=netcdf('ROMS_FILES/history/19-apr/roms_his.nc.1');

lats=nc{'lat_rho'}(:);
[etas, ~]=size(lats);

lons=nc{'lon_rho'}(:);
[~, xis]=size(lons);

latlon1 = [45.516667, -48.516667];
coord=[latlon1(1), latlon1(2)];

% get lat
for cell=1:xis
    if (lon(1, cell) > coord(2))
        eta=cell;
        disp(cell);
        break;
    end
end

% get lon
for cell=1:etas
    if (lat(cell, 1) > coord(1))
        xi=cell;
        disp(cell);
        break;
    end
end


%% Plot v on currentmeter 1
t = nc{'temp'}(:, 1, 149, 89);

plot(nc{'sustr'}(:,149, 89))
hold on
plot(nc{'svstr'}(:,149, 89))

%% Get some s_rho from a prof
clear all; close all;
nc=netcdf('ROMS_FILES/history/19-apr/roms_his.nc.1');

current1 = [45.516667, -48.516667];
current2 = [45.366667, -48.783333];

cell = fromLatLonToCell(nc, current1(1), current1(2));

level = getLevelFromProf(nc, cell, 164);

