# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ ${PV} == *99999999* ]]; then
	inherit kde5

	EGIT_REPO_URI="git://anongit.kde.org/ring-kde"
	SRC_URI=""

	KEYWORDS=""
else
	inherit kde5

	COMMIT_HASH=""
	MY_SRC_P="ring_${PV}.${COMMIT_HASH}"
	SRC_URI="https://dl.ring.cx/ring-release/tarballs/${MY_SRC_P}.tar.gz"

	KEYWORDS="~amd64"
fi

DESCRIPTION="KDE Ring client"
HOMEPAGE="https://projects.savoirfairelinux.com/projects/ring-kde-client/wiki"

LICENSE="GPL-3"

SLOT="0"

IUSE="akonadi doc +video"

RDEPEND="net-libs/libringclient[video?]
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kglobalaccel)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep knotifyconfig)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtopengl)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtsvg)
	$(add_qt_dep qtwidgets)
	akonadi? ( $(add_kdeapps_dep akonadi) $(add_kdeapps_dep akonadi-contacts) $(add_kdeapps_dep kcontacts) )
"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

kde5_src_configure()  {
		local mycmakeargs=(
		-DENABLE_VIDEO="$(usex video true false)"
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_BUILD_TYPE=Release
	)
	cmake-utils_src_configure
}

kde5_src_install() {
	use doc && doxygen Doxyfile
	use doc && HTML_DOCS=( "${S}/html/" )
	use !doc && rm {AUTHORS,NEWS,README.md}
	cmake-utils_src_install
}
