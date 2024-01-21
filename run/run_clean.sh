echo "Cleaning up previous runs"
cd $1
pwd
rm -f ../dataGFS/*
rm -f met_em* geo_em.*
rm -f WPS/FILE* WPS/GRIBFILE.AA*
echo "cleaned"
