# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils git-r3

DESCRIPTION="Ring daemon"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/ring-daemon/wiki"

EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-daemon"
SRC_URI=""

LICENSE="GPL-3"

SLOT="0"
KEYWORDS=""

IUSE=""

DEPEND="dev-libs/dbus-c++
	media-sound/pulseaudio
	x11-libs/libva"

RDEPEND="${DEPEND}"

#S=${WORKDIR}/${P}

src_configure() {
	cd "$S"/contrib

	# boost is failing with a compilation error
	# patch boost
	sed -i.bak 's/\.\/b2/\.\/b2 --ignore-site-config /g' src/boost/rules.mak

	mkdir build
	cd build
	../bootstrap

	#make .gmp otherwise fails
	export ABI=64 # why is this necessary? with the portage user it just builds fine
	make || die "Dependency build failed"

	cd ../..
	# patch jsoncpp include
	grep -rli '#include <json/json.h>' . | xargs -i@ sed -i 's/#include <json\/json.h>/#include <jsoncpp\/json\/json.h>/g' @
	./autogen.sh || die "Autogen failed"

	./configure --prefix=/usr || die "Configure failed"
	sed -i.bak 's/LIBS = \(.*\)$/LIBS = \1 -lopus /g' bin/Makefile
}
