# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils git-r3 cmake-utils gnome2-utils

DESCRIPTION="Gnome Ring client"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/ring-gnome-client/wiki"

EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-client-gnome"
SRC_URI=""

LICENSE="GPL-3"

SLOT="0"
KEYWORDS=""

IUSE=""

DEPEND="=net-libs/libringclient-99999999
	media-libs/clutter-gtk
	media-gfx/qrencode
	>=dev-qt/qtcore-5
	>=dev-qt/qtgui-5
	>=dev-qt/qtwidgets-5
	x11-themes/gnome-icon-theme
	gnome-extra/evolution-data-server
	x11-libs/libnotify
"

RDEPEND="${DEPEND}"

#S=${WORKDIR}/${P}

src_configure() {
	mkdir build
	cd build
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DGSETTINGS_COMPILE=OFF -DCMAKE_BUILD_TYPE=Release
}

src_compile() {
	cd build
	default
}

src_install() {
	cd build
	default
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
