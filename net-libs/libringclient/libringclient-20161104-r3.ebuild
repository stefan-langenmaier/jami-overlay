# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils cmake-utils

DESCRIPTION="libringclient is the common interface for Ring applications"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/libringclient/wiki"

SRC_URI="https://dl.ring.cx/ring-release/tarballs/ring_20161104.4.17a0616.tar.gz"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND="=net-voip/ring-daemon-${PVR}
	>=dev-qt/qtdbus-5"

RDEPEND="${DEPEND}"

S=${WORKDIR}/ring-project/lrc/

src_configure() {
	mkdir build
	cd build
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
}

src_compile() {
	cd build
	emake
}

src_install() {
	cd build
	default
}
