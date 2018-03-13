function [lon, lat] = getLonLat(nc)
% Returns lon and lat from xi and eta parameters
%   
    eta = nc{'eta_rho'}(:);
    xi = nc{'xi_rho'}(:);
    lon = nc{'lon_rho'}(eta, xi);
    lat = nc{'lat_rho'}(eta, xi);
end

