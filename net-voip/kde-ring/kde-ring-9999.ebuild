# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 cmake-utils

DESCRIPTION="KDE Ring client"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/ring-kde-client/wiki"

EGIT_REPO_URI="git://anongit.kde.org/ring-kde"
SRC_URI=""

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
	net-libs/libringclient
	>=dev-qt/qtcore-5
	>=dev-qt/qtgui-5
	>=dev-qt/qtwidgets-5
	>=dev-qt/qtsvg-5
	kde-frameworks/kinit
	kde-frameworks/kio
	>=kde-frameworks/extra-cmake-modules-1.1.0
"

#S=${WORKDIR}/${P}

src_configure() {
	mkdir build
	cd build
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
}

src_compile() {
	cd build
	make
}

src_install() {
	cd build
	make DESTDIR="${D}" install
}
