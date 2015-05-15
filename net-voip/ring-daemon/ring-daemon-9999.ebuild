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

DEPEND="dev-libs/dbus-c++
	dev-cpp/yaml-cpp"

RDEPEND="${DEPEND}"

#S=${WORKDIR}/${P}

src_configure() {
	# this should be fixed by a proper list of deps
	# at the moment not all deps are available in the Gentoo repo
	cd "$S"/contrib
	mkdir native
	cd native
	../bootstrap
	make

	cd ../..
	chmod +x ./autogen.sh
	./autogen.sh

	econf
}
