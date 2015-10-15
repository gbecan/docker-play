#!/bin/bash

configFile=config.conf
packagedAppFile=app.zip
configOption=""

function usage {
    echo "USAGE: the application can be given either as a zip or git repository:"
	echo "zip [OPTIONS]"
	echo "git path/to/my/repo [OPTIONS]"
	exit 1
}

if [ "$#" -lt 1 ]
then
	usage
fi


# Detect configuration file
if [ -f $configFile ]
then
    echo "Using configuration file"
	configOption="-Dconfig.file=/play/$configFile"
fi


if [ $1 == "zip" ]
then
	# Unzip app if necessary
	if [ -f $packagedAppFile ]
	then
		echo "Unzipping app"
		unzip app.zip -d app/
	fi

	# Start server
	cd app/
	echo "Starting server script"

	# Find script
	binDir=$(find . -name "bin" -type d | sed 1q)

	if [ -z "$binDir" ]
	then
		echo "bin directory not found"
		exit 1
	fi

	cd $binDir
	script=$(find . -type f ! -name "*.*" | sed 1q)
	
	# Start server
	$script $configOption "${@:2}"

fi


if [ $1 == "git" ]
then
	if [ "$#" -lt 2 ]
	then
		usage
	fi

	repo=$2
	echo "Cloning github repository"
	git clone $repo app/

	# Start server
	cd app/
	echo "Starting server with activator"

	# Find app directory
	appDir=$(find . -type f -name "activator" -printf '%h\n' | sed 1q)

	if [ -z "$appDir" ]
	then
		echo "activator not found"
		exit 1
	fi

	cd $appDir

	# Start server
	./activator start $configOption "${@:3}"

fi
