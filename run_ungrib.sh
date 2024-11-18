(
	echo -e "\n===================="
	echo "Running ungrib"
	ln -sf ../WPS/ungrib/Variable_Tables/Vtable.GFS Vtable
	time ./ungrib.exe
	echo "Ungrib 'FILES*' files:"
	ls UNGRIB*.*
	cat ungrib.log
)
