# RASP for Canary Islands
Based on RASP by Uri & Noel https://raspuri.mooo.com/

## Docker

```
docker compose build base
docker compose build run
docker compose run run

> ./ run_rasp.sh
```

## Instalation steps (done inside docker already)

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

## Running WRF

https://www.youtube.com/watch?v=yixvMF-g0nc

real.exe
-----------


## References
- namelist.wps: https://ral.ucar.edu/sites/default/files/public/Lesson-wps.html
- namelist.input: https://yidongwonyi.wordpress.com/models/wrf-weather-research-and-forecasting/namelist-input-description/
- Running the WRF: https://www.youtube.com/watch?v=fIbg5T-aUM4


