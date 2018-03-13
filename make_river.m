function make_river(fo)

    nc=netcdf(fo,'clobber'); % 'clobber' -> If the file exists, delete it and create a new one.

    result = redef(nc); % Define a new netcdf file

    %% Global attributes:
    nc.title = ncchar('River file to use with ROMS');
    nc.title = 'River file to use with ROMS';
    nc.type = ncchar('ROMS river file');
    nc.type = 'ROMS river file';
    %% (none)

    nd=365; nr=2;

    %% Dimensions:

    nc('qbar_time') = nd;
    nc('temp_src_time') = nd;
    nc('salt_src_time') = nd;
    nc('n_riv') = nr;
    nc('RivnameStrLen') = 14;

    %% Variables and attributes:

    nc{'qbar_time'} = ncdouble('qbar_time'); %% 12 elements.
    nc{'qbar_time'}.long_name = ncchar('river runoff time');
    nc{'qbar_time'}.units = ncchar('days');
    nc{'qbar_time'}.cycle_length = ncdouble(36500);

    nc{'temp_src_time'} = ncdouble('temp_src_time'); %% 12 elements.
    nc{'temp_src_time'}.long_name = ncchar('river temperature time');
    nc{'temp_src_time'}.units = ncchar('days');
    nc{'temp_src_time'}.cycle_length = ncdouble(36500);

    nc{'salt_src_time'} = ncdouble('salt_src_time'); %% 12 elements.
    nc{'salt_src_time'}.long_name = ncchar('river salinity time');
    nc{'salt_src_time'}.units = ncchar('days');
    nc{'salt_src_time'}.cycle_length = ncdouble(36500);

    nc{'Qbar'} = ncdouble('n_riv', 'qbar_time'); %% 36 elements.
    nc{'Qbar'}.long_name = ncchar('river runoff time');
    nc{'Qbar'}.units = ncchar('m3/s');

    nc{'temp_src'} = ncdouble('n_riv', 'qbar_time'); %% 36 elements.
    nc{'temp_src'}.long_name = ncchar('river temperature time');
    nc{'temp_src'}.units = ncchar('ºC');

    nc{'salt_src'} = ncdouble('n_riv', 'qbar_time'); %% 36 elements.
    nc{'salt_src'}.long_name = ncchar('river salinity time');
    nc{'salt_src'}.units = ncchar('psu');

    nc{'riv_name'} = ncchar('n_riv', 'RivnameStrLen'); %% 6 elements.
    nc{'riv_name'}.long_name = ncchar('river runoff time');
    
    
    result = endef(nc);
    result = close(nc);

    nc=netcdf(fo,'write');
    rivernames=['Minho','Duero'];
    nc{'qbar_time'}(:)=[0:1:nd-1]; nc{'temp_src_time'}(:)=[0:1:nd-1]; nc{'salt_src_time'}(:)=[0:1:nd-1];
    for i=1:nr
      nc{'riv_name'}(i,:)=rivernames(i);
      nc{'Qbar'}(i,:)=500*cos(2*pi*([0:1:nd-1])/365)+500;
      nc{'temp_src'}(i,:)=5*cos(-pi+2*pi*([0:1:nd-1])/365)+15;
      nc{'salt_src'}(i,:)=0;
    end

close(nc);
