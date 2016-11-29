# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

if [[ ${PV} == *99999999* ]]; then
	inherit eutils git-r3 cmake-utils

	EGIT_REPO_URI="git://anongit.kde.org/ring-kde"
	SRC_URI=""

	KEYWORDS=""
else
	inherit eutils cmake-utils

	COMMIT_HASH=""
	MY_SRC_P="ring_${PV}.${COMMIT_HASH}"
	SRC_URI="https://dl.ring.cx/ring-release/tarballs/${MY_SRC_P}.tar.gz"

	KEYWORDS="~amd64"
fi

DESCRIPTION="KDE Ring client"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/ring-kde-client/wiki"

LICENSE="GPL-3"

SLOT="0"

IUSE=""

DEPEND="net-libs/libringclient
	>=dev-qt/qtcore-5
	>=dev-qt/qtgui-5
	>=dev-qt/qtwidgets-5
	>=dev-qt/qtsvg-5
	kde-frameworks/kinit
	kde-frameworks/kio
	kde-frameworks/knotifications
	kde-frameworks/knotifyconfig
	>=kde-frameworks/extra-cmake-modules-1.1.0
"

RDEPEND="${DEPEND}"

src_configure() {
	mkdir build
	cd build
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release || die "Configure failed"
}

src_compile() {
	cd build
	default
}

src_install() {
	cd build
	default
}
