#! /bin/bash

directory=$1

ls ${directory}/*.stl | while read fname ; do
	fbase=$(basename $fname .stl | tr "A-Z\- " "a-z__" )
	echo "module ${fbase}() {"
	echo "	import( \"${fname}\" );"
	echo "}"
	echo ""
done
