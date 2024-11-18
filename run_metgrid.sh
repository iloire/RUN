(
	echo -e "\n===================="
	echo "Running metgrid"
	time ./metgrid.exe >&log.metgrid && tail log.metgrid
	grep -i "Successful completion of program metgrid.exe" metgrid.log
	if [ $? -eq 0 ]; then
		echo "Metgrid was successful"
		echo 'Metgrid met_em* files:'
	else
		1>&2 echo "Error running Metgrid"
		exit 1
	fi
)
