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
t = 45;
%temp=squeeze(nc{'temp'}(t, :, eta, :)); temp(temp<-10)=NaN;
%salt=squeeze(nc{'salt'}(t, :, eta, :)); salt(salt<0)=NaN;


sections = [c1(1) c2(1) c3(1)];

for sec=1:length(sections)
    eta = sections(sec);
    [lon, lat] = getLonLat(nc);
    h=nc{'h'}(eta, :);
    [m, ~]=size(lat);
    [~, lons]=size(lon);
    
    time=nc{'time'}(:);
    [maxt, ~]=size(time);

    zeta=nc{'zeta'}(t, eta, :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1));

    % variable
    salt=squeeze(nc{'temp'}(t, :, eta, :)); salt(salt<-10)=NaN;

    % with this hack delete the unnecessary 
    % rows
    for i=1:180
        lon([1], :) = [];
    end

    figure(sec+1); [C, h] = contourf(lon, depth, salt, 20); clabel(C, h); colorbar;
    %figure(sec+2); pcolor(lon(1, :), depth, temp); colorbar;% shading flat;  title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.5);
end

% Salinity
for sec=1:length(sections)
    eta = sections(sec);
    [lon, lat] = getLonLat(nc);
    h=nc{'h'}(eta, :);
    [m, ~]=size(lat);
    [~, lons]=size(lon);
    
    time=nc{'time'}(:);
    [maxt, ~]=size(time);

    zeta=nc{'zeta'}(t, eta, :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1));

    % variable
    salt=squeeze(nc{'salt'}(t, :, eta, :)); salt(salt<-10)=NaN;

    % with this hack delete the unnecessary 
    % rows
    for i=1:180
        lon([1], :) = [];
    end

    figure(sec+1); [C, h] = contourf(lon, depth, salt, 20); clabel(C, h); colorbar;
    %figure(sec+2); pcolor(lon(1, :), depth, temp); colorbar;% shading flat;  title(strcat("Day", " - ", num2str(nc{'time'}(t:t)/86400))); pause(0.5);
end

%% Temperature 

% current meters
current1 = [45.516667, -48.516667];
current2 = [45.366667, -48.783333];

