# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit autotools eutils

DESCRIPTION="Ring daemon"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/ring-daemon/wiki"

SRC_URI="https://dl.ring.cx/ring-release/tarballs/ring_20161020.1.42bef36.tar.gz"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

IUSE="system-boost system-ffmpeg"

DEPEND="system-boost? ( >=dev-libs/boost-1.56.0 )
	system-ffmpeg? ( >=media-video/ffmpeg-3.1.3[v4l,vaapi,vdpau] )
	>dev-libs/jsoncpp-1.7
	dev-libs/dbus-c++
	dev-cpp/yaml-cpp
	media-sound/gsm
	media-libs/libsamplerate
	x11-libs/libva"

#	dev-libs/gmp
#	net-libs/opendht
#	>=net-libs/pjproject-2.5.5
#	boost should be at 1.61

RDEPEND="${DEPEND}"

S=${WORKDIR}/ring-project/daemon/

src_configure() {
#	cd "$S"/ring-project/daemon/
	# this should be fixed by a proper list of deps
	# at the moment not all deps are available in the Gentoo repo
	cd contrib


	if ! use system-boost; then
		# boost is failing with a compilation error
		# patch boost
		sed -i.bak 's/\.\/b2/\.\/b2 --ignore-site-config /g' src/boost/rules.mak
	fi

	if use system-boost; then
		rm -r src/boost
	fi
	if use system-ffmpeg; then
		rm -r src/ffmpeg
	fi

#	rm -r src/gmp
	mkdir build
	cd build
	../bootstrap

	#make .gmp otherwise fails
	export ABI=64 # why is this necessary? with the portage user it just builds fine
	make

	cd ../..
	# patch jsoncpp include
	grep -rli '#include <json/json.h>' . | xargs -i@ sed -i 's/#include <json\/json.h>/#include <jsoncpp\/json\/json.h>/g' @
	./autogen.sh

	./configure --prefix=/usr
	sed -i.bak 's/LIBS = \(.*\)$/LIBS = \1 -lopus /g' bin/Makefile
}

src_compile() {
	cd "$"/ring-project/daemon/
	emake
}
