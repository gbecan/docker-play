#!/bin/sh

configFile=config.conf
packagedAppFile=app.zip
gitRepoFile=repo.txt
packaged=true
options=""


# Detect configuration file
if [ -f $configFile ]
then
    echo "Using configuration file"
	options="-Dconfig.file=$configFile"
fi

# Unzip app if necessary
if [ -f $packagedAppFile ]
then
    echo "Unzipping app"
	unzip app.zip -d app/
fi

# Clone git repository if necessary
if [ -f $gitRepoFile ]
then
    echo "Cloning github repository"
	packaged=false
	gitRepo=$(head -n 1 $gitRepoFile)
	git clone $gitRepo app/
fi

# Start server
cd app/

if $packaged
then
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
	$script $options
else
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
	./activator start $options
fi
