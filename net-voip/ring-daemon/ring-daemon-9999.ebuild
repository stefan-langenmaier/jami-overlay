# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Ring daemon"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/ring-daemon/wiki"

EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-daemon"
SRC_URI=""

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

#boost should be at 1.61
DEPEND=">=dev-libs/boost-1.56.0
	>dev-libs/jsoncpp-1.7
	dev-libs/dbus-c++
	dev-cpp/yaml-cpp
	media-sound/gsm
	x11-libs/libva"
#	media-libs/ffmpeg[v4l,vaapi,vdpau]"
#	dev-libs/gmp

RDEPEND="${DEPEND}"

#S=${WORKDIR}/${P}

src_configure() {
	# this should be fixed by a proper list of deps
	# at the moment not all deps are available in the Gentoo repo
	cd "$S"/contrib

	# boost is failing with a compilation error
	rm -r src/boost
#	rm -r src/ffmpeg
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
	make
}
