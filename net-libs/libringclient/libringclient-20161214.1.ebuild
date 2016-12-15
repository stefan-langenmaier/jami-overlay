# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

if [[ ${PV} == *99999999* ]]; then
	inherit eutils git-r3 cmake-utils

	EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-lrc"
	SRC_URI=""

	KEYWORDS=""
else
	inherit eutils cmake-utils

	COMMIT_HASH="2e7a668"
	MY_SRC_P="ring_${PV}.${COMMIT_HASH}"
	SRC_URI="https://dl.ring.cx/ring-release/tarballs/${MY_SRC_P}.tar.gz"

	KEYWORDS="~amd64"
fi

DESCRIPTION="libringclient is the common interface for Ring applications"
HOMEPAGE="https://tuleap.ring.cx/projects/ring"

LICENSE="GPL-3"

SLOT="0"

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
