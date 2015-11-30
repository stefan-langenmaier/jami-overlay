# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 cmake-utils gnome2-utils

DESCRIPTION="Gnome Ring client"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/ring-gnome-client/wiki"

EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-client-gnome"
SRC_URI=""

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
	net-libs/libringclient
	media-libs/clutter-gtk
	>=dev-qt/qtcore-5
	>=dev-qt/qtgui-5
	>=dev-qt/qtwidgets-5
	x11-themes/gnome-icon-theme
	app-text/libebook
"

#S=${WORKDIR}/${P}

src_configure() {
	mkdir build
	cd build
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DGSETTINGS_COMPILE=OFF
}

src_compile() {
	cd build
	make
}

src_install() {
	cd build
	make DESTDIR="${D}" install
}

pkg_preinst() {
   gnome2_schemas_savelist
}

pkg_postinst() {
   gnome2_schemas_update
}

pkg_postrm() {
   gnome2_schemas_update
}
