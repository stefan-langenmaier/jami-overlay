# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 cmake-utils

DESCRIPTION="libringclient is the common interface for Ring applications"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/libringclient/wiki"

EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-lrc"
SRC_URI=""

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="net-voip/ring-daemon"

RDEPEND="${DEPEND}"

#S=${WORKDIR}/${P}

src_configure() {
	mkdir build
	cd build
	cmake .. -DRING_BUILD_DIR=$RING -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug
}

src_compile() {
	cd build
	make
}

src_install() {
	cd build
	make DESTDIR="${D}" install
}
