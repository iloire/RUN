#!/bin/bash

# source $RUN_DIR/rasp_env.sh
# FOLDER_tmp=/tmp/METEO
# FOLDER_WRF=${FOLDER_tmp}/WRF
# FOLDER_WPS=${FOLDER_tmp}/WPS


# DOMAIN=`./get_domain.py | head -n 1 | tail -n 1`
# GFSdata=`./get_domain.py | head -n 2 | tail -n 1`
# OUTdata=`./get_domain.py | head -n 3 | tail -n 1`
# Ncores=`./get_domain.py | head -n 4 | tail -n 1`

. env.sh

echo -e "Starting RUN"
echo -e "Domain         : ${DOMAIN}"
echo -e "GFS Data Folder: ${GFSdata} "
echo -e "Ncores: ${Ncores}\n"
echo -e "OMP: ${OMP_NUM_THREADS}\n"

# (
# echo "Cleaning up previous runs"
# cd $1
# pwd
# #### Clean previous runs
# rm dataGFS/*
# rm RUN/namelist.wps RUN/namelist.input
# # rm "${DOMAIN}"/met_em* "${DOMAIN}"/geo_em.*
# rm WPS/namelist.wps WPS/namelist.input
# rm WPS/FILE* WPS/GRIBFILE.AA* WPS/*.log WPS/log.*
# rm WRF/run/namelist.input
# rm WRF/run/rsl.* WRF/run/wrfout* WRF/run/met_em*
# echo "cleaned"
# )

(
  echo "Downloading GFS data"
  time python3 download_gfs_data.py
  if [ $? -eq 0 ]; then
     echo "GFS data downloaded"
  else
     echo "Error downloading GFS data"
     exit 1
  fi
)

(
  echo "Running geogrid"
  time ./geogrid.exe >& log.geogrid
  grep "Successful completion of geogrid" log.geogrid
  if [ $? -eq 0 ]; then
     echo "Geogrid was successful"
     echo "Geogrid geo_met* files:"
     ../WPS/link_grib.csh ../dataGFS/
  else
     echo "Error running Geogrid"
     exit 1
  fi
)

(
  echo "Running ungrib"
  ln -sf ../WPS/ungrib/Variable_Tables/Vtable.GFS Vtable
  time ./ungrib.exe
  echo "Ungrib 'FILES*' files:"
)

#
# echo "Running metgrid"
# time ./metgrid.exe >& log.metgrid && tail log.metgrid
# grep -i "Successful completion of program metgrid.exe" metgrid.log
# if [ $? -eq 0 ]; then
#    echo "Metgrid was successful"
#    echo 'Metgrid met_em* files:'
#    ls $1/WPS/met_em*
# else
#    1>&2 echo "Error running Metgrid"
#    exit 1
# fi
#
# # Check WPS codes
# if [ $? -eq 0 ]; then
#    echo "SUCCESS: WPS run Ok."
# else
#    echo "FAIL: Error during WPS steps"
#    exit 1
# fi
#
#
# (
# #### WRF
# echo "Going for WRF"
# cd $1/WRF/run
# ln -sf $1/WPS/met_em* .
# echo "met* files are present:"
# ls met_em*
# echo -e "\nStarting real.exe"
# time mpirun -np 1 ./real.exe
# tail -n 1 rsl.error.0000 | grep -w SUCCESS
# if [ $? -eq 0 ]; then
#    echo "REAL worked!!"
# else
#    1>&2 echo "Error running real.exe"
# fi
#
# # WRF
# echo -e "\nStarting wrf.exe"
# T0=`date`
# time mpirun -np $Ncores ./wrf.exe
# # time mpirun -np $Ncores --map-by node:PE=$OMP_NUM_THREADS --rank-by core ./wrf.exe
# echo "Start" $2 $3 $T0 >> /storage/WRFOUT/TIME.txt
# echo "End" $2 $3 `date` >> /storage/WRFOUT/TIME.txt
# tail -n 1 rsl.error.0000 | grep -w SUCCESS
# if [ $? -eq 0 ]; then
#    echo "WRF worked!!"
# else
#    1>&2 echo "Error running wrf.exe"
# fi
#
# mkdir -p "${OUTdata}"
# rm wrfoutReady*
# # mv wrfout_* "${OUTdata}"
# )
# # Check WRF
# if [ $? -eq 0 ]; then
#    echo "SUCCESS: WRF run Ok."
#    #$HOME/bin/mybot/sysbot.py "SUCCESS: WRF run Ok."
# else
#    echo "FAIL: Error during WRF steps"
#    $HOME/bin/mybot/sysbot.py "FAIL: Error during WRF steps"
#    exit 1
# fi
