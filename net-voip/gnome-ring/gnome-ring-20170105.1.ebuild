# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

if [[ ${PV} == *99999999* ]]; then
	inherit eutils git-r3 cmake-utils gnome2-utils

	EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-client-gnome"
	SRC_URI=""

	KEYWORDS=""
else
	inherit eutils cmake-utils gnome2-utils

	COMMIT_HASH="27bfa91"
	MY_SRC_P="ring_${PV}.${COMMIT_HASH}"
	SRC_URI="https://dl.ring.cx/ring-release/tarballs/${MY_SRC_P}.tar.gz"

	KEYWORDS="~amd64"

	S=${WORKDIR}/ring-project/client-gnome
fi

DESCRIPTION="Gnome Ring client"
HOMEPAGE="https://tuleap.ring.cx/projects/ring"

LICENSE="GPL-3"

SLOT="0"

IUSE=""

DEPEND="=net-libs/libringclient-${PVR}
	media-libs/clutter-gtk
	media-gfx/qrencode
	>=dev-qt/qtcore-5
	>=dev-qt/qtgui-5
	>=dev-qt/qtwidgets-5
	|| ( net-libs/webkit-gtk:4 net-libs/webkit-gtk:3 )
	x11-themes/gnome-icon-theme
	gnome-extra/evolution-data-server
	x11-libs/libnotify
"

RDEPEND="${DEPEND}"

src_configure() {
	mkdir build
	cd build
	cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DGSETTINGS_COMPILE=OFF -DCMAKE_BUILD_TYPE=Release || die "Configure failed"
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
