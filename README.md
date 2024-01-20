# RUN
Based on RASP by Uri & Noel

## Docker

docker compose build base

## Instalation steps

- Install required libraries (install/install_libraries.sh).
- Clone WRF from Github, configure, install.
- Clone WPS (WRP Preprocessing System) from Github, configure, install (WRF is required).
  - It will create geogrid.exe, ungrib.exe, metgrid.exe.
- Download Static Terrestrial Data.
https://www2.mmm.ucar.edu/wrf/users/download/get_source.html (need to be downloaded only once)

## Running WPS

Running WPS (https://mmg.atm.ucdavis.edu/wp-content/uploads/2014/10/WPS-Duda.pdf)

geogrid.exe
-----------
Define size/location of model domains and interpolate static terrestrial fields to simulation grids.
- edit namelist.wps (&share and &geogrid sections)
  - https://jiririchter.github.io/WRFDomainWizard/
- make sure the correct GEOGRID.TBL is used (ls -l geogrid/GEOGRID.TBL*)
- type 'geogrid.exe' to run
- check output in geogrid.log

ungrib.exe
----------
- edit namelist.wps for start_date and end_date, output file prefix
  (&share and &ungrib sections)
- link correct Vtable:
  ls -l ungrib/Variable_Tables
  For example, for NCEP GFS (or AVN, FNL) data,
  ln -sf ungrib/Variable_Tables/Vtable.GFS Vtable
- link grib data files:
  link_grib.csh /data-directory/file*
- type 'ungrib.exe >& ungrib.out' to run
- check output in ungrib.log and ungrib.out

metgrid.exe
-----------
- edit namelist.wps (&share and &metgrid sections)
- make sure the correct METGRID.TBL is used (ls -l metgrid/METGRID.TBL*)
- type 'metgrid.exe' to run
- check output in metgrid.log


## To-Do
### Post-Processing
- [x] Optimize plots (no replot terrain, or frontiers)
- [ ] Update matplotlib version to fix heights axis
- [x] zoom for post-process
- [ ] Improve Colormap to highlight differences in small regions while keeping the blue-green-yellow-red scale of difficulty
- [ ] cloud fraction to "cloud satellite" or something
- [x] Implement low, mid, high clouds (frac)
### WRF/RUN
- [ ] Add option to discard first N wrfout files
- [ ] Fix mask_days for longer runs [break in days]
- [ ] Persistent, rotating log (at least keep logs for a couple of days?)
- [ ] Check everything for simultanous runs
- [ ] Check for GFS download errors (err:500)
- [ ] http/ftp alternative downloads
- [ ] Try Pirineos domain
- - [ ] Compare sibiling domains vs complete domains
- - [ ] 9_3_1 vs 6_1.2
- - [ ] merge Guadarrama + Pirineos + ...
### General
- [x] Old computer for testing
- [x] Web repo
- [ ] Web design
- [ ] Bot & repo
- [ ] Documentation properties
- - [ ] images
- - [ ] soundings full explanation
- [ ] Remove plots folder
