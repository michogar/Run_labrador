clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc');

lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:); x=lon(end/2, :);
h=nc{'h'}(end/2, :);

for t=1:31
    zeta=nc{'zeta'}(t, end/2, :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1));
    s=squeeze(nc{'salt'}(t, :, end/2, :)); s(s<1)=NaN;
    
    pcolor(x, depth, s); colorbar; pause(0.5);
end
    

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
    s=squeeze(nc{'salt'}(t, :, floor(end/2), :)); s(s<20)=NaN;
    
    pcolor(x, depth, s); colorbar; pause(0.5);
end


%% Plot section across latitude
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc');

lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:); y=lat(:, floor(end/2));
h=nc{'h'}(:, end/2);

for t=1:121
    zeta=nc{'zeta'}(t, end/2, :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1));
    s=squeeze(nc{'salt'}(t, end/2, :, :)); s(s<1)=NaN;
    
    pcolor(y, depth, s); colorbar; pause(0.5);
end


%% Plot bathimetry
clear all; close all;
nc=netcdf('/media/michogarcia/MARSH/roms_his.nc');

h=nc{'h'}(:);
lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:);
surf(lon, lat, -h);

%% Vertical plot

clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc');

lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:); [m, n]=size(lon)
h=nc{'h'}(:); nt=size(nc{'time'}(:));

ip1=23; jp1=24; ip2=52; jp2=52;

for i=ip1:ip2
    it(i)=i;
    jt(i)=round((i-ip1)/(ip2-ip1)*(jp2-jp1)+jp1);
end

ht=h(it(ip1:ip2),jt(jp1:jp2));

for t=1:1
    zeta=nc{'zeta'}(t,:,:); 
    zetat=zeta(it(ip1:ip2),jt(jp1:jp2));
    depth=zlevs(h(it(ip1:ip2), jt(jp1:jp2)), zeta(it(ip1:ip2), jt(jp1:jp2)), 6, 0, 10, 32, 'r', 1);
    for i=1:32
        for j=1:29
            xt(i,j)=j;
            deptht(i,j)=depth(i,1,j);
        end
    end

    s=nc{'salt'}(t,:,:,:); %sh=nc{'salt'}(t,32,:,:);
    st=s(:,it(ip1:ip2),jt(jp1:jp2));
    pcolor(xt,deptht,squeeze(st(:,1,:)));
end

%% Vertical plot

clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc');

lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:); [m n]=size(lon)
h=nc{'h'}(:); nt=size(nc{'time'}(:));

ip1=23; jp1=24; ip2=26; jp2=26;

for i=ip1:ip2
    it(i)=i;
    jt(i)=round((i-ip1)/(ip2-ip1)*(jp2-jp1)+jp1);
end
ht=h(it(ip1:ip2),jt(jp1:jp2));
for t=1:1
  zeta=nc{'zeta'}(t,:,:);
zetat=zeta(it(ip1:ip2),jt(jp1:jp2));
depth=zlevs(h(it(ip1:ip2),jt(jp1:jp2)),zeta(it(ip1:ip2),jt(jp1:jp2)),6,0,10,32,'r',2);
  for i=1:32
      for j=1:29
       xt(i,j)=j;
       deptht(i,j)=depth(i,1,j);
      end
  end

  s=nc{'salt'}(t,:,:,:); th=nc{'salt'}(t,32,:,:);
  st=s(:,it(ip1:ip2),jt(jp1:jp2));
  pcolor(xt,deptht,squeeze(st(:,1,:)));
end

%% Vertical and horizontal plot salinity

clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc');

lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:); [m, n]=size(lon)
xh=lon; yh=lat;

h=nc{'h'}(:); [nt, kk]=size(nc{'time'}(:));

i1=23; j1=24; i2=52; j2=52; ii=i2-i1+1; ji=j2-j1+1; % i1,j1, i2, j2 obvious, ii -> i inclination, ji -> jinclination

if(ii>ji)
  xv=zeros(ii,32); ip=i1; fp=i2; % Set initial point and final point
  for k=i1:i2
    it(k)=k;
    jt(k)=round((k-i1)/(i2-i1)*(j2-j1)+j1);
  end
else
  xv=zeros(ji,32); ip=j1; fp=j2; % Set initial point and final point
  for i=j1:j2
    jt(i)=i;
    it(i)=round((i-j1)/(j2-j1)*(i2-i1)+i1);
  end
end

yv=xv; zv=xv; tv=xv;

for t=1:121
    zh=nc{'zeta'}(t,:); th=nc{'salt'}(t,32,:,:);
    for i=ip:fp
       zeta=nc{'zeta'}(t,it(i),jt(i));
       zv(i-ip+1,:)=zlevs(h(it(i),jt(i)),zeta,6,0,10,32,'r',1);
       xv(i-ip+1,:)=lon(it(i),jt(i));
       yv(i-ip+1,:)=lat(it(i),jt(i));
       tv(i-ip+1,:)=nc{'salt'}(t,:,it(i),jt(i));
    end
  tv(tv<5)=NaN; th(th<5)=NaN;
  surf(xh,yh,zh,th); hold on;
  surf(xv,yv,zv,tv); shading flat; title(num2str(t)); pause(.5);
end

%% Vertical and horizontal plot temp

clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc');

lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:); [m, n]=size(lon)
xh=lon; yh=lat;

h=nc{'h'}(:); [nt, kk]=size(nc{'time'}(:));

i1=23; j1=24; i2=52; j2=52; ii=i2-i1+1; ji=j2-j1+1; % i1,j1, i2, j2 obvious, ii -> i inclination, ji -> jinclination

if(ii>ji)
  xv=zeros(ii,32); ip=i1; fp=i2; % Set initial point and final point
  for k=i1:i2
    it(k)=k;
    jt(k)=round((k-i1)/(i2-i1)*(j2-j1)+j1);
  end
else
  xv=zeros(ji,32); ip=j1; fp=j2; % Set initial point and final point
  for i=j1:j2
    jt(i)=i;
    it(i)=round((i-j1)/(j2-j1)*(i2-i1)+i1);
  end
end

yv=xv; zv=xv; tv=xv;

for t=1:121
    zh=nc{'zeta'}(t,:); th=nc{'temp'}(t,32,:,:);
    for i=ip:fp
       zeta=nc{'zeta'}(t,it(i),jt(i));
       zv(i-ip+1,:)=zlevs(h(it(i),jt(i)),zeta,6,0,10,32,'r',1);
       xv(i-ip+1,:)=lon(it(i),jt(i));
       yv(i-ip+1,:)=lat(it(i),jt(i));
       tv(i-ip+1,:)=nc{'temp'}(t,:,it(i),jt(i));
    end
  tv(tv<0)=NaN; th(th<0)=NaN;
  surf(xh,yh,zh,th); hold on;
  surf(xv,yv,zv,tv); shading flat; title(num2str(t)); pause(.5);
end

%% show child grid bathimetry
clear all; close all;
nc=netcdf('ROMS_FILES/roms_grd.nc');
nc1=netcdf('ROMS_FILES/roms_grd.nc.1');

x1=nc1{'xi_rho'}(:); y1=nc1{'eta_rho'}(:); h1=nc1{'h'}(:);
lon1=nc1{'lon_rho'}(:); lat1=nc1{'lat_rho'}(:);
x=nc{'xi_rho'}(:); y=nc{'eta_rho'}(:); h=nc{'h'}(:);
lon=nc{'lon_rho'}(:); lat=nc{'lat_rho'}(:);
figure(1); surf(lon1, lat1, -h1);
figure(2); surf(lon, lat, -h);

figure(3); surf(lon1, lat1, -h1); hold on; surf(lon, lat, -h);

%%
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc');
nc1=netcdf('ROMS_FILES/roms_his.nc.1');

[lon, lat] = getLonLat(nc1); x=lon(end/2, :);
h=nc1{'h'}(floor(end/2), :); [kk, m]=size(lon);

for t=1:1
    zeta=nc1{'zeta'}(t, floor(end/2), :);
    depth=squeeze(zlevs(h, zeta, 6, 0, 10, 32, 'r', 1)); x=depth;
    for i=1:m
        x(:, i)=lon(1, i);
    end
    s=squeeze(nc1{'salt'}(t, :, floor(end/2), :)); s(s<1)=NaN;
    
    pcolor(x, depth, s); pause(0.5);
end

%% Horizontal salinity
clear all; close all;
nc=netcdf('ROMS_FILES/roms_his.nc');
nc1=netcdf('ROMS_FILES/roms_his.nc.1');

[lon, lat]=getLonLat(nc); [nt, kk]=size(nc{'time'}(:));

for t=1:nt
    salt=nc{'salt'}(t, 32, :, :); salt(salt<30)=NaN;
    pcolor(lon, lat, salt); shading flat; title(num2str(t)); colorbar; pause(.5);
end

%%

B = [ [1 2 3]' [2 4 7]' [3 5 8]'];

for b = B(:)
    disp(b)
end
