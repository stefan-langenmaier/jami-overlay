# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="For applications that require seamless and secure communication over HTTP"
HOMEPAGE="https://github.com/Corvusoft/${PN}"
if [ "$PV" != "9999" ]; then
	MY_PV=${PV/_/-} # replace underscore
	MY_PV=${MY_PV^^} # to uppercase
	SRC_URI="https://github.com/Corvusoft/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/${PN}-${MY_PV}"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Corvusoft/${PN}.git"
	KEYWORDS=""
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE="examples ssl static-libs test"

CMAKE_MIN_VERSION="2.8.10"

RDEPEND="
	>=dev-cpp/asio-1.11
	dev-cpp/catch
	dev-cpp/kashmir
	ssl? ( dev-libs/openssl:= )
	sys-libs/pam
	sys-libs/zlib
"
DEPEND="${RDEPEND}
"

DOCS="README.md
	documentation/API.md
	documentation/STANDARDS.md
	documentation/UML.md
"

src_prepare() {
	sed -r -i \
		-e 's/(LIBRARY DESTINATION) "library"/\1 '$(get_libdir)'/' \
		-e 's/(ARCHIVE DESTINATION) "library"/\1 '$(get_libdir)'/' \
		CMakeLists.txt || die

	if use examples; then
		sed -r -i \
			-e 's/\$\{CMAKE_INSTALL_PREFIX\}/\0\/share\/corvusoft\/restbed/' \
			-e 's/(DESTINATION) "resource"/\1 "${CMAKE_INSTALL_PREFIX}\/share\/corvusoft\/restbed\/resource"/' \
			example/CMakeLists.txt || die
	fi

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED=$(usex static-libs OFF ON)
		-DBUILD_TESTS=$(usex test ON OFF)
	)

	for x in {examples,ssl}; do
		mycmakeargs+=( -DBUILD_${x^^}=$(usex $x ON OFF) )
	done

	cmake-utils_src_configure
}
