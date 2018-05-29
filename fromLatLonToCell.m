function cells = fromLatLonToCell(nc, lat, lon)
%Get a LonLat values and look for the cells that get these values

eta = getEta(nc, lat);
xi = getXi(nc, lon);

cells = [eta, xi];

end

function xi = getXi(nc, lon)
lons=nc{'lon_rho'}(:);
[~, xis]=size(lons);

% get xi
for xii=1:xis
    if (lons(1, xii) > lon)
        xi = xii;
        break;
    end
end
end

function eta = getEta(nc, lat)

lats=nc{'lat_rho'}(:);
[etas, ~]=size(lats);

for etaj=1:etas
    if (lats(etaj, 1) > lat)
        eta = etaj;
        break;
    end
end
end

