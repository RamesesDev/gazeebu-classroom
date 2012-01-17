#!/bin/bash

TARGET="/c/Users/JAYROME VERGARA/Desktop/target"
SRC="/c/Users/JAYROME VERGARA/Desktop/src"
BAK="/c/Users/JAYROME VERGARA/Desktop/bak"

USE_SUDO="false"
WAR="folder1"
EAR="folder2"

#-- backing up original files
if [ -d "$TARGET/$WAR" ]; then
	echo "moving $TARGET/$WAR to $BAK/"
	if [ "$USE_SUDO" == "true" ]; then
		sudo mv $TARGET/$WAR $BAK/
	else
		mv $TARGET/$WAR $BAK/
	fi
else
	echo "target $TARGET/$WAR does not exists"
fi

if [ -d "$TARGET/$EAR" ]; then
	echo "moving $TARGET/$EAR to $BAK/"
	if [ "$USE_SUDO" == "true" ]; then
		sudo mv $TARGET/$EAR $BAK/
	else
		mv $TARGET/$EAR $BAK/
	fi
else
	echo "target $TARGET/$EAR does not exists"
fi

#-- deploying new files
if [ -d "$SRC/$WAR" ]; then
	echo "moving $SRC/$WAR to $TARGET/"
	if [ "$USE_SUDO" == "true" ]; then
		sudo mv $SRC/$WAR $TARGET/
	else
		mv $SRC/$WAR $TARGET/
	fi
else
	echo "source $SRC/$WAR does not exists";
fi

if [ -d "$SRC/$EAR" ]; then
	echo "moving $SRC/$EAR to $TARGET/"
	if [ "$USE_SUDO" == "true" ]; then
		sudo mv $SRC/$EAR $TARGET/
	else
		mv $SRC/$EAR $TARGET/
	fi
else
	echo "source $SRC/$EAR does not exists"
fi

echo "modules successfully deployed."

