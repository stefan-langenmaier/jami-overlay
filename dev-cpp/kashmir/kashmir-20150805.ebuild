# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Library is provide functionality that not present in the C++ standard library."
HOMEPAGE="https://github.com/Corvusoft/kashmir-dependency"
EGIT_REPO_URI="https://github.com/Corvusoft/${PN}-dependency.git"
EGIT_COMMIT="2f3913f49c4ac7f9bff9224db5178f6f8f0ff3ee"
KEYWORDS="~amd64 ~x86"

LICENSE="Boost-1.0"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	insinto "/usr/include/${PN}"
	doins ${PN}/*.h

	insinto "/usr/include/${PN}/system"
	doins ${PN}/system/*.h
}
