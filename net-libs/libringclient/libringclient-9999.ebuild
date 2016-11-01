# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils git-r3 cmake-utils

DESCRIPTION="libringclient is the common interface for Ring applications"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/libringclient/wiki"

EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-lrc"
SRC_URI=""

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND="=net-voip/ring-daemon-9999
	>=dev-qt/qtdbus-5"

RDEPEND="${DEPEND}"

src_configure() {
	mkdir build
	cd build
	cmake .. -DRING_BUILD_DIR="$S/ring" -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug
}

src_compile() {
	cd build
	emake
}

src_install() {
	cd build
	default
}
