%% Create contour latitudinal section
% Temperature
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

% sections
latS1 = 45.66666667;
latS2 = 45.41666667;
latS3 = 45.25000000;

none = -48.50;

% Convert to cells
c1 = fromLatLonToCell(nc, latS1, none);
c2 = fromLatLonToCell(nc, latS2, none);
c3 = fromLatLonToCell(nc, latS3, none);

% variables
t = 21;
%temp=squeeze(nc{'temp'}(t, :, eta, :)); temp(temp<-10)=NaN;
%salt=squeeze(nc{'salt'}(t, :, eta, :)); salt(salt<0)=NaN;


sections = [c1(1) c2(1) c3(1)];

for sec=1:length(sections)
    eta = sections(sec);
    [lons, lat] = getLonLat(nc);
    h=nc{'h'}(eta, :);
    [m, ~]=size(lat);
    [~, lons]=size(lons);
    
    time=nc{'time'}(:);
    [maxt, ~]=size(time);

    zeta=nc{'zeta'}(t, eta, :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1));

    % variable
    temp=squeeze(nc{'temp'}(t, :, eta, :)); temp(temp<-10)=NaN;

    % with this hack delete the unnecessary 
    % rows
    for i=1:180
        lons([1], :) = [];
    end

    figure(sec+1); 
    [C, h] = contourf(lons, depth, temp, 20);
    axis([-49 -48 -500 0])
    clabel(C, h); 
    colorbar;
    ylabel('Prof (m)'); xlabel('Longitude');
    legend({'Temp (ºC)'});
    %figure(sec+2); pcolor(lon(1, :), depth, temp); colorbar;% shading flat;  title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.5);
end

%% Salinity

clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

% sections
latS1 = 45.66666667;
latS2 = 45.41666667;
latS3 = 45.25000000;

none = -48.50;

% Convert to cells
c1 = fromLatLonToCell(nc, latS1, none);
c2 = fromLatLonToCell(nc, latS2, none);
c3 = fromLatLonToCell(nc, latS3, none);

% variables
t = 38;
%temp=squeeze(nc{'temp'}(t, :, eta, :)); temp(temp<-10)=NaN;
%salt=squeeze(nc{'salt'}(t, :, eta, :)); salt(salt<0)=NaN;


sections = [c1(1) c2(1) c3(1)];

for sec=1:length(sections)
    eta = sections(sec);
    [lons, lat] = getLonLat(nc);
    h=nc{'h'}(eta, :);
    [m, ~]=size(lat);
    [~, lons]=size(lons);
    
    time=nc{'time'}(:);
    [maxt, ~]=size(time);

    zeta=nc{'zeta'}(t, eta, :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1));

    % variable
    temp=squeeze(nc{'salt'}(t, :, eta, :)); temp(temp<-10)=NaN;

    % with this hack delete the unnecessary 
    % rows
    for i=1:180
        lons([1], :) = [];
    end

    figure(sec+1); 
    [C, h] = contourf(lons, depth, temp, 20); 
    clabel(C, h); 
    colorbar;
    ylabel('Prof (m)'); xlabel('Longitude');
    legend({'Sal (psu)'});
    %figure(sec+2); pcolor(lon(1, :), depth, temp); colorbar;% shading flat;  title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.5);
end

%% Temperature over the time
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

% sections
latS1 = 45.66666667;
latS2 = 45.41666667;
latS3 = 45.25000000;

none = -48.50;

% Convert to cells
c1 = fromLatLonToCell(nc, latS1, none);
c2 = fromLatLonToCell(nc, latS2, none);
c3 = fromLatLonToCell(nc, latS3, none);

% variables
t = 38;
%temp=squeeze(nc{'temp'}(t, :, eta, :)); temp(temp<-10)=NaN;
%salt=squeeze(nc{'salt'}(t, :, eta, :)); salt(salt<0)=NaN;

eta = c2(1);
[lons, lat] = getLonLat(nc);
h=nc{'h'}(eta, :);
[m, ~]=size(lat);
[~, lonssize]=size(lons);


% with this hack delete the unnecessary
% rows
for i=1:180
    lons([1], :) = [];
end

time=nc{'time'}(:);
[maxt, ~]=size(time);

for t=1:maxt
    zeta=nc{'zeta'}(t, eta, :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1));
    
    % variable
    temp=squeeze(nc{'temp'}(t, :, eta, :)); temp(temp<-10)=NaN;

    [C, con] = contourf(lons, depth, temp, 20);
    axis([-49 -48 -500 0])
    clabel(C, h);
    colorbar;
    ylabel('Prof (m)'); xlabel('Longitude');
    legend({'Temp (ºC)'});
    title(strcat("Day", " - ", num2str(round((nc{'time'}(t:t)/86400) - 150), -1)));
    pause(0.2);
    
    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'p2_temp.gif';
 
    % On the first loop, create the file. In subsequent loops, append.
    if t==1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
end


% current meters
current1 = [45.516667, -48.516667];
current2 = [45.366667, -48.783333];

%% Tides

ncold=netcdf('ROMS_FILES/history/19-apr/roms_his.nc');
nc=netcdf('ROMS_FILES/roms_his.nc');

% hibernia
hibernia = [46.75722222, -49.03777778];
cellHibernia = fromLatLonToCell(nc, hibernia(1), hibernia(2));

tide50 = nc{'zeta'}(1:100, cellHibernia(1), cellHibernia(2)); 
q = plot(tide50);
set(q,'LineWidth',4);
hold
tideold50 = ncold{'zeta'}(1:100, cellHibernia(1), cellHibernia(2)); 
q = plot(tideold50);
set(q,'LineWidth',4);
ylabel('Altura (m)'); xlabel('Timesteps');
legend({'Con marea', 'Sin marea'});

%% Profiles
%% Get some s_rho from a prof
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

current1 = [45.516667, -48.516667];
current2 = [45.366667, -48.783333];

cell = fromLatLonToCell(nc, current2(1), current2(2));
level = getLevelFromProf(nc, cell, 120);

% q = plot(nc{'temp'}(:, level(1), cell(1), cell(2)));
% 
% legend({'temp (ºC)'});

q = plot((nc{'salt'}((1:100), level(1), cell(1), cell(2))));
set(q,'LineWidth',4);
legend({'Salinidad (psu)'});

%% Calculate magnitude horizontal current
% ws = sqrt(u2+v2)
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

current1 = [45.516667, -48.516667];
cell = fromLatLonToCell(nc, current1(1), current1(2));
level = getLevelFromProf(nc, cell, 164);
u = 100 * nc{'u'}((1:100), level(1), cell(1), cell(2));
v = 100 * nc{'v'}((1:100), level(1), cell(1), cell(2));

[ws, wd] = uv_to_wswd(u, v);

figure(1)
bar(ws);
ylabel('Intesidad de la corriente (cm/s)');
figure(2)
q = plot(wd);
set(q,'LineWidth',4);
ylabel('Dirección de la corriente (º)');


%% Shows arrow direction 
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

h=nc{'h'}(:);
lons=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:);
current1 = [45.516667, -48.516667];
cell = fromLatLonToCell(nc, current1(1), current1(2));
level = getLevelFromProf(nc, cell, 164);
currentH = 164;

for t=1:100
    u = 100 * nc{'u'}(t, level(1), cell(1), cell(2));
    v = 100 * nc{'v'}(t, level(1), cell(1), cell(2));
    w = 100 * nc{'w'}(t, level(1), cell(1), cell(2));
    q = quiver3(current1(1), current1(2), currentH, u, v, w);
    if (w > 0)
       q.Color = [1 0 0];
    else
       q.Color = [0 0 1];
    end
    set(q,'LineWidth',4);
    axis([24 67 -100 -30 120 170])
    ylabel('Latitud'); xlabel('Longitud'); zlabel('Profundidad (m)')
    legend({'cm/s'});
    title(strcat("Day", " - ", num2str(round((nc{'time'}(t:t)/86400) - 150), -1)));
    pause(0.2);
    
    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'direction.gif';
 
    % On the first loop, create the file. In subsequent loops, append.
    if t==1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
end

%% winds in hibernia
clear all; close all;
u3cdf=netcdf('../COADS05/u3.cdf');
v3cdf=netcdf('../COADS05/v3.cdf');

u3s=u3cdf{'u3'}(:);
v3s=v3cdf{'v3'}(:);
lons=u3cdf{'X'}(:); lats=u3cdf{'Y'}(:);
hibernia = [46.75722222, -49.03777778];
hiberniaus=[46.7500, 310.7500];

u3 = u3cdf{'u3'}((1:12), 46.7500, 310.7500);
v3 = v3cdf{'v3'}((1:12), 46.7500, 310.7500);

[ws, wd] = uv_to_wswd(u3, v3);

figure(1)
bar(ws);
ylabel('Velocidad del viento (m/s)');
xlabel('Mes');
figure(2)
q = plot(wd);
set(q,'LineWidth',4);
ylabel('Dirección del viento (º)');
xlabel('Mes');

%% W minus tide
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc.1');

current1 = [45.516667, -48.516667];
cell = fromLatLonToCell(nc, current1(1), current1(2));
level = getLevelFromProf(nc, cell, 164);

tide50 = nc{'zeta'}(1:100, current1(1), current1(2));
tidespeed = (100 * tide50/86400); % seconds per day

w = 100 * nc{'w'}((1:100), level(1), cell(1), cell(2));
q = plot(w-tidespeed);
set(q,'LineWidth',4);
ylabel('Velocidad corregida (m/s)');

