# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils cmake-utils

DESCRIPTION="libringclient is the common interface for Ring applications"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/libringclient/wiki"

SRC_URI="https://dl.ring.cx/ring-release/tarballs/ring_20161020.1.42bef36.tar.gz"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="=net-voip/ring-daemon-20161020
	>=dev-qt/qtdbus-5"

RDEPEND="${DEPEND}"

S=${WORKDIR}/ring-project/lrc/

src_configure() {
	mkdir build
	cd build
	#cmake .. -DRING_BUILD_DIR="$S/ring" -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
}

src_compile() {
	cd build
	emake
}

src_install() {
	cd build
	make DESTDIR="${D}" install
}
