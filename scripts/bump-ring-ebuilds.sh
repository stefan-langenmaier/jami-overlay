#!/bin/bash

SOURCE_FILE=$1

if [[ ! -f "$SOURCE_FILE" ]] ; then
	echo "No source for bumping found"
	exit
fi

VERSION=(${SOURCE_FILE//_/ });
VERSION=${VERSION[1]}
VERSION=(${VERSION//./ });
REV=${VERSION[2]}
VERSION=${VERSION[0]}.${VERSION[1]}

echo "Bumping ebuilds"

echo "Bumping ring-daemon"
RD="net-voip/ring-daemon/ring-daemon-"
cp ${RD}99999999.ebuild ${RD}$VERSION.ebuild
sed -i "s/\tCOMMIT_HASH=\"\"$/\tCOMMIT_HASH=\"$REV\"/" ${RD}$VERSION.ebuild
ebuild ${RD}$VERSION.ebuild manifest

echo "Bumping libringclient"
LR="net-libs/libringclient/libringclient-"
cp ${LR}99999999.ebuild ${LR}$VERSION.ebuild
sed -i "s/\tCOMMIT_HASH=\"\"$/\tCOMMIT_HASH=\"$REV\"/" ${LR}$VERSION.ebuild
ebuild ${LR}$VERSION.ebuild manifest

echo "Bumping gnome-ring"
GR="net-voip/gnome-ring/gnome-ring-"
cp ${GR}99999999.ebuild ${GR}$VERSION.ebuild
sed -i "s/\tCOMMIT_HASH=\"\"$/\tCOMMIT_HASH=\"$REV\"/" ${GR}$VERSION.ebuild
ebuild ${GR}$VERSION.ebuild manifest
