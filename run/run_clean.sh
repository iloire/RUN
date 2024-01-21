echo "Cleaning up previous runs"
cd $1
pwd
#### Clean previous runs
rm ../dataGFS/*
rm met_em* geo_em.*
# rm WPS/namelist.wps WPS/namelist.input
rm WPS/FILE* WPS/GRIBFILE.AA*
# rm WRF/run/namelist.input
# rm WRF/run/rsl.* WRF/run/wrfout* WRF/run/met_em*
echo "cleaned"
