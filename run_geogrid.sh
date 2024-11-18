(
	echo -e "\n===================="
	echo "Running geogrid"
	time ./geogrid.exe >&log.geogrid
	grep "Successful completion of geogrid" log.geogrid
	if [ $? -eq 0 ]; then
		echo "Geogrid was successful"
		echo "Geogrid geo_em* files:"
		../WPS/link_grib.csh ../dataGFS/
		ls geo_em*.*
	else
		1>&2 echo "Error running Geogrid. Displaying log:"
		cat log.geogrid
		exit 1
	fi
)
if [ $? -eq 0 ]; then
	echo "SUCCESS: executing geogrid."
else
	1>&2 echo "FAIL: Error executing geogrid"
	exit 1
fi
