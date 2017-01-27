# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit libtool eutils

DESCRIPTION="Portable uuid C library"
HOMEPAGE="http://libuuid.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	elibtoolize
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	prune_libtool_files --all
}
