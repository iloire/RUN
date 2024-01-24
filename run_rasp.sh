#!/bin/bash

. ../env.sh

./run_clean.sh

echo $REGION
echo $BASEDIR

(
  rm -f ../WRF/namelist.wps ../WRF/namelist.input ../WRF/run/namelist.input
  rm -f ../WPS/namelist.wps ../WPS/namelist.input
  echo -e "\n===================="
  echo "Setting up the inputs"
 python3 inputer.py
  if [ $? -eq 0 ]; then
     echo "SUCCESS: inputer executed correctly."
  else
     1>&2 echo "FAIL: Error executing inputer"
     exit 1
  fi
  ln -s "$BASEDIR/$REGION/namelist.wps" "../WPS/"
  ln -s "$BASEDIR/$REGION/namelist.input" "../WPS/"

  ln -s "$BASEDIR/$REGION/namelist.wps" "../WRF/"
  ln -s "$BASEDIR/$REGION/namelist.input" "../WRF/"

  ln -s "$BASEDIR/$REGION/namelist.input" "../WRF/run/"

  echo "WRF/WPS Input files:"
  ls ../WPS/namelist.*
  ls ../WRF/run/namelist.*
)
if [ $? -eq 0 ]; then
   echo "SUCCESS: inputs generated correctly."
else
   1>&2 echo "FAIL: Error during input generation"
   exit 1
fi

(
  echo -e "\n===================="
  echo "Downloading GFS data"
  time python3 download_gfs_data.py
  if [ $? -eq 0 ]; then
     echo "GFS data downloaded"
  else
     1>&2 echo "Error downloading GFS data"
     exit 1
  fi
)

(
  echo -e "\n===================="
  echo "Running geogrid"
  time ./geogrid.exe >& log.geogrid
  grep "Successful completion of geogrid" log.geogrid
  if [ $? -eq 0 ]; then
     echo "Geogrid was successful"
     echo "Geogrid geo_em* files:"
     ../WPS/link_grib.csh ../dataGFS/
     ls geo_em*.*
  else
     1>&2 echo "Error running Geogrid"
     exit 1
  fi
)
if [ $? -eq 0 ]; then
   echo "SUCCESS: executing geogrid."
else
   1>&2 echo "FAIL: Error executing geogrid"
   exit 1
fi


(
  echo -e "\n===================="
  echo "Running ungrib"
  ln -sf ../WPS/ungrib/Variable_Tables/Vtable.GFS Vtable
  time ./ungrib.exe
  echo "Ungrib 'FILES*' files:"
  ls UNGRIB*.*
  cat ungrib.log
)

(
  echo -e "\n===================="
  echo "Running metgrid"
  time ./metgrid.exe >& log.metgrid && tail log.metgrid
  grep -i "Successful completion of program metgrid.exe" metgrid.log
  if [ $? -eq 0 ]; then
     echo "Metgrid was successful"
     echo 'Metgrid met_em* files:'
  else
     1>&2 echo "Error running Metgrid"
     exit 1
  fi
)

# Check WPS codes
if [ $? -eq 0 ]; then
   echo "SUCCESS: WPS run Ok."
else
   1>&2 echo "FAIL: Error during WPS steps"
   exit 1
fi

(
  #### WRF
  echo -e "\n===================="
  echo "Going for WRF"
  cd ../WRF/run
  ln -sf ../../Lanzarote/met_em* .
  echo "met* files are present:"
  ls met_em*
  echo -e "\nStarting real.exe"
  time ./real.exe
  tail -n 1 rsl.error.0000 | grep -w SUCCESS
  if [ $? -eq 0 ]; then
     echo "REAL worked!!"
  else
     1>&2 echo "Error running real.exe"
     cat rsl.error.0000
     exit 1
  fi

  echo -e "\nStarting wrf.exe"
  T0=`date`
  time ./wrf.exe
  # time mpirun -np $Ncores --map-by node:PE=$OMP_NUM_THREADS --rank-by core ./wrf.exe
  echo "Start" $2 $3 $T0 >> TIME.txt
  echo "End" $2 $3 `date` >> TIME.txt
  tail -n 1 rsl.error.0000 | grep -w SUCCESS
  if [ $? -eq 0 ]; then
     echo "WRF worked!!"
  else
     1>&2 echo "Error running wrf.exe"
     exit 1
  fi
  # mkdir -p "${OUTdata}"
  # rm wrfoutReady*
  # mv wrfout_* "${OUTdata}"
)

# Check WRF
if [ $? -eq 0 ]; then
   echo "SUCCESS: WRF run Ok."
else
   1>&2 echo "FAIL: Error during WRF steps"
   exit 1
fi
