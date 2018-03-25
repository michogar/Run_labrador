#!/bin/bash

rsync -ah --progress --exclude roms_clm.nc --exclude roms_frc.nc --exclude roms_grd.nc --exclude roms_ini.nc --exclude roms_oa.nc roms_*.nc /media/michogarcia/MARSH/